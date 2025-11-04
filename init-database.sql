-- Complete Database Initialization Script
-- Run this script to create and setup the database from scratch

CREATE DATABASE IF NOT EXISTS onlinebookstore;

USE onlinebookstore;

-- Create books table with all columns
CREATE TABLE IF NOT EXISTS books(
    barcode VARCHAR(100) PRIMARY KEY, 
    name VARCHAR(100), 
    author VARCHAR(100), 
    price INT, 
    quantity INT,
    category VARCHAR(100) DEFAULT 'General',
    description TEXT,
    image_url VARCHAR(500)
);

-- Create users table
CREATE TABLE IF NOT EXISTS users(
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100), 
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    address TEXT, 
    phone VARCHAR(100),
    mailid VARCHAR(100),
    usertype INT,
    is_blocked BOOLEAN DEFAULT FALSE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(100) PRIMARY KEY,
    user_email VARCHAR(100) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    shipping_address TEXT,
    FOREIGN KEY (user_email) REFERENCES users(username)
);

-- Create order_items table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(100) NOT NULL,
    book_barcode VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_barcode) REFERENCES books(barcode)
);

-- Create reviews table
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    book_barcode VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_approved BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (book_barcode) REFERENCES books(barcode),
    FOREIGN KEY (user_email) REFERENCES users(username)
);

-- Insert sample books
INSERT INTO books VALUES('9780134190563','The Go Programming Language','Alan A. A. Donovan and Brian W. Kernighan',400,8,'Programming','A comprehensive guide to Go programming language','');
INSERT INTO books VALUES('9780133053036','C++ Primer','Stanley Lippman and Josée Lajoie and Barbara Moo',976,13,'Programming','Complete guide to C++ programming','');
INSERT INTO books VALUES('9781718500457','The Rust Programming Language','Steve Klabnik and Carol Nichols',560,12,'Programming','The official book on Rust programming','');
INSERT INTO books VALUES('9781491910740','Head First Java','Kathy Sierra and Bert Bates and Trisha Gee',754,23,'Programming','A brain-friendly guide to Java','');
INSERT INTO books VALUES('9781492056300','Fluent Python','Luciano Ramalho',1014,5,'Programming','Clear, concise, and effective Python programming','');
INSERT INTO books VALUES('9781720043997','The Road to Learn React','Robin Wieruch',239,18,'Web Development','Learn React.js from scratch','');
INSERT INTO books VALUES('9780132350884','Clean Code: A Handbook of Agile Software Craftsmanship','Robert C Martin',288,3,'Programming','A handbook of agile software craftsmanship','');
INSERT INTO books VALUES('9780132181273','Domain-Driven Design','Eric Evans',560,28,'Programming','Tackling complexity in the heart of software','');
INSERT INTO books VALUES('9781951204006','A Programmers Guide to Computer Science','William Springer',188,4,'General','Essential computer science concepts','');
INSERT INTO books VALUES('9780316204552','The Soul of a New Machine','Tracy Kidder',293,30,'General','The story of building a computer','');
INSERT INTO books VALUES('9780132778046','Effective Java','Joshua Bloch',368,21,'Programming','Best practices for Java programming','');
INSERT INTO books VALUES('9781484255995','Practical Rust Projects','Shing Lyu',257,15,'Programming','Build real-world projects with Rust','');

-- Insert sample users
INSERT INTO users VALUES('demo','demo','Demo','User','Demo Home','42502216225','demo@gmail.com',2,FALSE,NOW());
INSERT INTO users VALUES('Admin','Admin','Mr.','Admin','Bhubaneswar Odisha','9584552224521','admin@gmail.com',1,FALSE,NOW());
INSERT INTO users VALUES('chintu','chintu','Chintu','Bhadrak','Odisha','7438993596','chintu@gmail.com',2,FALSE,NOW());

COMMIT;

SELECT 'Database initialized successfully!' as Status;
