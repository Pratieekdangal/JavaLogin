CREATE TABLE IF NOT EXISTS companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    website VARCHAR(255),
    founded_year INT,
    recruiter_id INT NOT NULL,
    address VARCHAR(255),
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (recruiter_id) REFERENCES users(id),
    UNIQUE KEY unique_name (name),
    INDEX idx_recruiter (recruiter_id),
    INDEX idx_status (status)
); 