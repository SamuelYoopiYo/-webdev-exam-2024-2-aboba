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

# Initialize Flask app
app = Flask(__name__)
app.config.from_pyfile('config.py')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize SQLAlchemy, Bcrypt, and LoginManager
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
login_manager = LoginManager(app)
login_manager.login_view = 'login'

# Define Role model
class Role(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=False)
    users = db.relationship('User', backref='role', lazy=True)

# Define User model
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    last_name = db.Column(db.String(255), nullable=False)
    first_name = db.Column(db.String(255), nullable=False)
    middle_name = db.Column(db.String(255))
    role_id = db.Column(db.Integer, db.ForeignKey('role.id'), nullable=False)
    reviews = db.relationship('Review', backref='user', lazy=True)

# Define Book model
class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=False)
    year = db.Column(db.Integer, nullable=False)
    publisher = db.Column(db.String(255), nullable=False)
    author = db.Column(db.String(255), nullable=False)
    pages = db.Column(db.Integer, nullable=False)
    cover_id = db.Column(db.Integer, db.ForeignKey('cover.id'), nullable=False)
    genres = db.relationship('Genre', secondary='book_genre', back_populates='books')
    reviews = db.relationship('Review', backref='book', lazy=True)

    @property
    def average_rating(self):
        total_rating = sum(review.rating for review in self.reviews)
        num_reviews = len(self.reviews)
        return total_rating / num_reviews if num_reviews > 0 else 0

# Define Genre model
class Genre(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), unique=True, nullable=False)
    books = db.relationship('Book', secondary='book_genre', back_populates='genres')

# Define many-to-many relationship table for Book and Genre
book_genre = db.Table('book_genre',
                      db.Column('book_id', db.Integer, db.ForeignKey('book.id'), primary_key=True),
                      db.Column('genre_id', db.Integer, db.ForeignKey('genre.id'), primary_key=True)
                      )

# Define Cover model
class Cover(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255), nullable=False)
    mime_type = db.Column(db.String(255), nullable=False)
    md5_hash = db.Column(db.String(255), nullable=False)
    book = db.relationship('Book', backref='cover', lazy=True)

# Define Review model
class Review(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    rating = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now(), nullable=False)

# Define user_loader for LoginManager
@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Define index route
@app.route('/')
def index():
    page = request.args.get(get_page_parameter(), type=int, default=1)
    books = Book.query.order_by(Book.year.desc()).paginate(page=page, per_page=9)
    return render_template('index.html', books=books)

# Define book_detail route
@app.route('/book/<int:book_id>')
def book_detail(book_id):
    book = Book.query.get_or_404(book_id)
    return render_template('book_detail.html', book=book)

# Define login route
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

# Define logout route
@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Вы вышли из системы.', 'success')
    return redirect(url_for('index'))

# Define register route
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

# Define add_book route
@app.route('/add', methods=['GET', 'POST'])
@login_required
def add_book():
    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия.', 'danger')
        return redirect(url_for('index'))

    if request.method == 'POST':
        title = request.form['title']
        description = request.form['description']
        year = request.form['year']
        publisher = request.form['publisher']
        author = request.form['author']
        pages = request.form['pages']
        cover_file = request.files['cover']
        
        cover = save_cover(cover_file)  # Функция сохранения обложки
        genres = request.form.getlist('genres')

        new_book = Book(title=title, description=description, year=year, publisher=publisher, author=author, pages=pages, cover=cover)
        
        for genre_id in genres:
            genre = Genre.query.get(genre_id)
            new_book.genres.append(genre)

        db.session.add(new_book)
        db.session.commit()

        flash('Книга успешно добавлена!', 'success')
        return redirect(url_for('index'))
    
    genres = Genre.query.all()
    return render_template('add_book.html', genres=genres)

# Define edit_book route
@app.route('/edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
def edit_book(book_id):
    book = Book.query.get_or_404(book_id)

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
        
        genres = request.form.getlist('genres')
        book.genres.clear()
        for genre_id in genres:
            genre = Genre.query.get(genre_id)
            book.genres.append(genre)

        db.session.commit()
        flash('Книга успешно обновлена!', 'success')
        return redirect(url_for('book_detail', book_id=book.id))
    
    genres = Genre.query.all()
    return render_template('edit_book.html', book=book, genres=genres)

# Define delete_book route
@app.route('/book/<int:book_id>/delete', methods=['POST'])
@login_required
def delete_book(book_id):
    book = Book.query.get_or_404(book_id)

    if current_user.role.name != 'Администратор':
        flash('У вас недостаточно прав для выполнения данного действия.', 'danger')
        return redirect(url_for('index'))
    
    db.session.delete(book)
    db.session.commit()

    flash('Книга успешно удалена!', 'success')
    return redirect(url_for('index'))

# Define function to save
# Функция сохранения обложки
def save_cover(cover_file):
    if cover_file:
        filename = secure_filename(cover_file.filename)
        mime_type = cover_file.mimetype
        md5_hash = hashlib.md5(cover_file.read()).hexdigest()
        cover_file.seek(0)
        
        existing_cover = Cover.query.filter_by(md5_hash=md5_hash).first()
        if existing_cover:
            return existing_cover
        
        cover_file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        cover_file.save(cover_file_path)
        
        cover = Cover(filename=filename, mime_type=mime_type, md5_hash=md5_hash)
        db.session.add(cover)
        db.session.commit()
        
        return cover
    return None

# Запуск приложения
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        admin_role = Role(name='admin', description='Администратор')

        db.session.add(admin_role)
        db.session.commit()

        if not User.query.filter_by(username='admin').first():
            hashed_password = bcrypt.generate_password_hash('admin').decode('utf-8')
            admin_user = User(
                username='admin',
                first_name='Admin',
                last_name='Admin',
                password_hash=hashed_password,
                role_id=admin_role.id
            )
            db.session.add(admin_user)
            db.session.commit()

    app.run(debug=True, port=5002)
