USE job_portal;

-- Check if table exists and modify password column
ALTER TABLE users MODIFY COLUMN password VARCHAR(255);

-- Verify the change
DESCRIBE users; 