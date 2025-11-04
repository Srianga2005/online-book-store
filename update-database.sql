-- Update database schema to add missing columns
USE onlinebookstore;

-- Add is_blocked column to users table if it doesn't exist
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN DEFAULT FALSE;

-- Add created_date column to users table if it doesn't exist
ALTER TABLE users ADD COLUMN IF NOT EXISTS created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Add category column to books table if it doesn't exist
ALTER TABLE books ADD COLUMN IF NOT EXISTS category VARCHAR(100) DEFAULT 'General';

-- Add description column to books table if it doesn't exist
ALTER TABLE books ADD COLUMN IF NOT EXISTS description TEXT;

-- Add image_url column to books table if it doesn't exist
ALTER TABLE books ADD COLUMN IF NOT EXISTS image_url VARCHAR(500);

-- Update existing users to set is_blocked to FALSE if NULL
UPDATE users SET is_blocked = FALSE WHERE is_blocked IS NULL;

SELECT 'Database schema updated successfully!' as Status;
