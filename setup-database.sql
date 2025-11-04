-- Quick Database Setup Script
-- Run this in MySQL before starting the application

USE onlinebookstore;

-- Add new columns to books table
ALTER TABLE books 
ADD COLUMN IF NOT EXISTS category VARCHAR(100) DEFAULT 'General',
ADD COLUMN IF NOT EXISTS description TEXT,
ADD COLUMN IF NOT EXISTS image_url VARCHAR(500);

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

-- Add blocked status to users
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Insert sample data for testing
INSERT IGNORE INTO orders VALUES 
('ORD001', 'demo@gmail.com', NOW(), 976.00, 'Pending', '123 Demo Street, Demo City'),
('ORD002', 'chintu@gmail.com', NOW(), 400.00, 'Processing', '456 Test Avenue, Test Town');

INSERT IGNORE INTO order_items VALUES 
(NULL, 'ORD001', '9780133053036', 1, 976.00),
(NULL, 'ORD002', '9780134190563', 1, 400.00);

INSERT IGNORE INTO reviews VALUES 
(NULL, '9780134190563', 'demo@gmail.com', 5, 'Excellent book on Go programming!', NOW(), TRUE),
(NULL, '9780133053036', 'chintu@gmail.com', 4, 'Great C++ reference book.', NOW(), TRUE);

COMMIT;

SELECT 'Database setup completed successfully!' as Status;
