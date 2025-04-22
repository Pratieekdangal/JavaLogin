CREATE TABLE IF NOT EXISTS jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    department VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    experience_level VARCHAR(50) NOT NULL,
    location VARCHAR(255) NOT NULL,
    salary VARCHAR(100),
    description TEXT NOT NULL,
    requirements TEXT NOT NULL,
    benefits TEXT,
    application_deadline TIMESTAMP,
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    company_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    FOREIGN KEY (company_id) REFERENCES companies(id),
    INDEX idx_company_status (company_id, status),
    INDEX idx_posted_date (posted_date)
); 