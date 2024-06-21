from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, login_user, logout_user, current_user, login_required, UserMixin
from flask_bcrypt import Bcrypt
from flask_paginate import Pagination, get_page_parameter
import os
import hashlib
from werkzeug.utils import secure_filename
from faker import Faker
from random import randint

app = Flask(__name__)
app.config.from_pyfile('config.py')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
login_manager = LoginManager(app)
login_manager.login_view = 'login'


class Role(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=False)
    users = db.relationship('User', backref='role', lazy=True)


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    last_name = db.Column(db.String(255), nullable=False)
    first_name = db.Column(db.String(255), nullable=False)
    middle_name = db.Column(db.String(255))
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), nullable=False)
    reviews = db.relationship('Review', backref='user', lazy=True)

class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=False)
    year = db.Column(db.Integer, nullable=False)
    publisher = db.Column(db.String(255), nullable=False)
    author = db.Column(db.String(255), nullable=False)
    pages = db.Column(db.Integer, nullable=False)
    cover_id = db.Column(db.Integer, db.ForeignKey('cover.id'), nullable=True) 
    genres = db.relationship('Genre', secondary='book_genre', back_populates='books')
    reviews = db.relationship('Review', backref='book', lazy=True)

    @property
    def average_rating(self):
        total_rating = sum(review.rating for review in self.reviews)
        num_reviews = len(self.reviews)
        return total_rating / num_reviews if num_reviews > 0 else 0


class Genre(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), unique=True, nullable=False)
    books = db.relationship('Book', secondary='book_genre', back_populates='genres')

book_genre = db.Table('book_genre',
                      db.Column('book_id', db.Integer, db.ForeignKey('book.id'), primary_key=True),
                      db.Column('genre_id', db.Integer, db.ForeignKey('genre.id'), primary_key=True)
                      )


class Cover(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255), nullable=False)
    mime_type = db.Column(db.String(255), nullable=False)
    md5_hash = db.Column(db.String(255), nullable=False)
    book = db.relationship('Book', backref='cover', lazy=True)


class Review(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    rating = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now(), nullable=False)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@app.route('/')
def index():
    page = request.args.get(get_page_parameter(), type=int, default=1)
    books = Book.query.order_by(Book.year.desc()).paginate(page=page, per_page=9)
    return render_template('index.html', books=books)


@app.route('/book/<int:book_id>')
def book_detail(book_id):
    book = Book.query.get_or_404(book_id)
    return render_template('book_detail.html', book=book)


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user and bcrypt.check_password_hash(user.password_hash, password):
            login_user(user)
            flash('Вы успешно вошли в систему!', 'success')
            return redirect(url_for('index'))
        else:
            flash('Неверное имя пользователя или пароль.', 'danger')
    return render_template('login.html')


@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Вы вышли из системы.', 'success')
    return redirect(url_for('index'))


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']

        user = User.query.filter_by(username=username).first()
        if user:
            flash('Пользователь с таким именем уже существует.', 'danger')
        else:
            password_hash = bcrypt.generate_password_hash(password).decode('utf-8')
            new_user = User(username=username, password_hash=password_hash, first_name=first_name, last_name=last_name,
                            role_id=1)
            db.session.add(new_user)
            db.session.commit()
            flash('Регистрация прошла успешно! Теперь вы можете войти.', 'success')
            return redirect(url_for('login'))
    return render_template('register.html')

@app.route('/add', methods=['GET', 'POST'])
@login_required
def add_book():
    # Проверка, является ли текущий пользователь администратором
    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия.', 'danger')
        return redirect(url_for('index'))

    if request.method == 'POST':
        # Получение данных из формы
        title = request.form['title']
        description = request.form['description']
        year = request.form['year']
        publisher = request.form['publisher']
        author = request.form['author']
        pages = request.form['pages']
        cover_file = request.files['cover']
        
        # Сохранение обложки и создание нового объекта книги
        cover = save_cover(cover_file) if cover_file else None
        genres = request.form.getlist('genres')

        new_book = Book(
            title=title, 
            description=description, 
            year=year, 
            publisher=publisher, 
            author=author, 
            pages=pages, 
            cover=cover
        )
        
        # Добавление жанров к книге
        for genre_id in genres:
            genre = Genre.query.get(genre_id)
            new_book.genres.append(genre)

        # Сохранение книги в базе данных
        db.session.add(new_book)
        db.session.commit()

        flash('Книга успешно добавлена!', 'success')
        return redirect(url_for('index'))
    
    # Получение всех жанров для отображения в форме
    genres = Genre.query.all()
    return render_template('add_book.html', genres=genres)



@app.route('/edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
def edit_book(book_id):
    # Получение объекта книги по идентификатору
    book = Book.query.get_or_404(book_id)

    # Проверка прав доступа пользователя
    if current_user.role.name not in ['Администратор', 'Модератор']:
        flash('У вас недостаточно прав для выполнения данного действия.', 'danger')
        return redirect(url_for('index'))

    if request.method == 'POST':
        book.title = request.form['title']
        book.description = request.form['description']
        book.year = request.form['year']
        book.publisher = request.form['publisher']
        book.author = request.form['author']
        book.pages = request.form['pages']
        
        # Обновление обложки
        cover_file = request.files['cover']
        if cover_file:
            cover = save_cover(cover_file)
            book.cover = cover
        
        # Обновление жанров книги
        genres = request.form.getlist('genres')
        book.genres.clear()
        for genre_id in genres:
            genre = Genre.query.get(genre_id)
            book.genres.append(genre)

        # Сохранение изменений в базе данных
        db.session.commit()
        flash('Книга успешно обновлена!', 'success')
        return redirect(url_for('book_detail', book_id=book.id))
    
    # Получение всех жанров для отображения в форме
    genres = Genre.query.all()
    return render_template('edit_book.html', book=book, genres=genres)




@app.route('/delete/<int:book_id>', methods=['POST'])
@login_required
def delete_book(book_id):
    # Получение объекта книги по идентификатору
    book = Book.query.get_or_404(book_id)

    # Проверка прав доступа пользователя
    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия.', 'danger')
        return redirect(url_for('index'))

    # Удаление книги из базы данных
    db.session.delete(book)
    db.session.commit()
    flash('Книга успешно удалена!', 'success')
    return redirect(url_for('index'))

def save_cover(cover_file):
    filename = secure_filename(cover_file.filename)
    cover_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    cover_file.save(cover_path)
    mime_type = cover_file.content_type
    cover_file.seek(0)  # Возвращаемся к началу файла для хеширования
    md5_hash = hashlib.md5(cover_file.read()).hexdigest()
    cover = Cover(filename=filename, mime_type=mime_type, md5_hash=md5_hash)
    db.session.add(cover)
    db.session.commit()
    return cover

# не сделал
@app.route('/add_rating/<int:book_id>', methods=['POST']) 
@login_required
def add_rating(book_id):
    return 1



if __name__ == '__main__':
    app.run(debug=True)
