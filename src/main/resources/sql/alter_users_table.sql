-- Modify password column to accommodate hashed passwords
ALTER TABLE users MODIFY COLUMN password VARCHAR(255); 