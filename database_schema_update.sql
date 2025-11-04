-- Enhanced Database Schema for Online Bookstore
-- Run this script to add new features for admin panel

USE onlinebookstore;

-- Idempotent add column helper using INFORMATION_SCHEMA + prepared statements
-- books.category
SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'books' AND COLUMN_NAME = 'category');
SET @sql := IF(@exists=0, 'ALTER TABLE books ADD COLUMN category VARCHAR(100) DEFAULT ''General''', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- books.description
SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'books' AND COLUMN_NAME = 'description');
SET @sql := IF(@exists=0, 'ALTER TABLE books ADD COLUMN description TEXT', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- books.image_url
SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'books' AND COLUMN_NAME = 'image_url');
SET @sql := IF(@exists=0, 'ALTER TABLE books ADD COLUMN image_url VARCHAR(500)', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

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

-- Add blocked status to users table (idempotent)
-- users.is_blocked
SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'is_blocked');
SET @sql := IF(@exists=0, 'ALTER TABLE users ADD COLUMN is_blocked BOOLEAN DEFAULT FALSE', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- users.created_date
SET @exists := (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'created_date');
SET @sql := IF(@exists=0, 'ALTER TABLE users ADD COLUMN created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Create book categories reference (optional)
CREATE TABLE IF NOT EXISTS book_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Insert default categories
INSERT IGNORE INTO book_categories (category_name, description) VALUES
('Programming', 'Books about programming languages and software development'),
('Web Development', 'Books about web technologies and frameworks'),
('Data Science', 'Books about data analysis, machine learning, and AI'),
('Database', 'Books about database management and SQL'),
('Networking', 'Books about computer networks and security'),
('Mobile Development', 'Books about iOS and Android development'),
('DevOps', 'Books about deployment, CI/CD, and infrastructure'),
('General', 'General computer science and technology books'),
('Fiction', 'Fiction and literature books'),
('Non-Fiction', 'Non-fiction books');

COMMIT;
