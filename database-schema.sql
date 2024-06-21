CREATE TABLE role (
	id INTEGER NOT NULL, 
	name VARCHAR(255) NOT NULL, 
	description TEXT NOT NULL, 
	PRIMARY KEY (id)
);
CREATE TABLE genre (
	id INTEGER NOT NULL, 
	name VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (name)
);
CREATE TABLE cover (
	id INTEGER NOT NULL, 
	filename VARCHAR(255) NOT NULL, 
	mime_type VARCHAR(255) NOT NULL, 
	md5_hash VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id)
);
CREATE TABLE user (
	id INTEGER NOT NULL, 
	username VARCHAR(255) NOT NULL, 
	password_hash VARCHAR(255) NOT NULL, 
	last_name VARCHAR(255) NOT NULL, 
	first_name VARCHAR(255) NOT NULL, 
	middle_name VARCHAR(255), 
	role_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (username), 
	FOREIGN KEY(role_id) REFERENCES role (id)
);
CREATE TABLE book (
	id INTEGER NOT NULL, 
	title VARCHAR(255) NOT NULL, 
	description TEXT NOT NULL, 
	year INTEGER NOT NULL, 
	publisher VARCHAR(255) NOT NULL, 
	author VARCHAR(255) NOT NULL, 
	pages INTEGER NOT NULL, 
	cover_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(cover_id) REFERENCES cover (id)
);
CREATE TABLE book_genre (
	book_id INTEGER NOT NULL, 
	genre_id INTEGER NOT NULL, 
	PRIMARY KEY (book_id, genre_id), 
	FOREIGN KEY(book_id) REFERENCES book (id), 
	FOREIGN KEY(genre_id) REFERENCES genre (id)
);
CREATE TABLE review (
	id INTEGER NOT NULL, 
	book_id INTEGER NOT NULL, 
	user_id INTEGER NOT NULL, 
	rating INTEGER NOT NULL, 
	text TEXT NOT NULL, 
	created_at DATETIME DEFAULT (CURRENT_TIMESTAMP) NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(book_id) REFERENCES book (id), 
	FOREIGN KEY(user_id) REFERENCES user (id)
);
