-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS student_management_db;

-- Use the database
USE student_management_db;

-- Create students table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(50) UNIQUE NOT NULL,
    grade VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    gender VARCHAR(10),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_roll_number (roll_number),
    INDEX idx_full_name (full_name)
);

-- Insert sample data (optional)
INSERT INTO students (full_name, roll_number, grade, email, phone, gender, date_of_birth) VALUES
('John Doe', 'STU001', '10', 'john.doe@example.com', '1234567890', 'Male', '2008-05-15'),
('Jane Smith', 'STU002', '11', 'jane.smith@example.com', '0987654321', 'Female', '2007-08-22'),
('Mike Johnson', 'STU003', '10', 'mike.j@example.com', '5551234567', 'Male', '2008-03-10'),
('Sarah Williams', 'STU004', '12', 'sarah.w@example.com', '5559876543', 'Female', '2006-11-30'),
('David Brown', 'STU005', '11', 'david.b@example.com', '5552223333', 'Male', '2007-07-18')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

SELECT 'Database setup completed successfully!' as Status;
SELECT COUNT(*) as 'Total Students' FROM students;
