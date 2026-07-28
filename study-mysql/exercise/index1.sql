CREATE DATABASE IF NOT EXISTS string_practice
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE string_practice;

CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    cccd VARCHAR(12)
);

INSERT INTO employees (first_name, last_name, email, phone, cccd) VALUES
('nguyen', 'VAN AN',   'an.nguyen@gmail.com',    '0901234567', '048201001234'),
('tran',   'thi binh', 'BINH.TRAN@YAHOO.COM',    '0912345678', '001202005678'),
('LE',     'Quoc Cuong','cuong.le@funix.edu.vn', '0923456789', '048303009876'),
('PHAM',   'thu hoa',  'hoa.pham@outlook.com',   '0934567890', '079404001122');

SELECT * FROM employees;

SELECT 
	id, 
    CONCAT(first_name, ' ', last_name) AS full_name 
    FROM employees;
    
SELECT 
    cccd,
    SUBSTRING(cccd, 1, 3) AS ma_tinh
FROM employees;

SELECT 
	cccd,
	SUBSTRING(cccd,4,3) AS nam_thang_sinh
FROM employees;

SELECT 
	phone,
    REPLACE(phone, SUBSTRING(phone,4,4), '****') AS phone_masked
FROM employees;

SELECT 
	cccd,
    CHAR_LENGTH(cccd) AS do_dai,
    CASE
		WHEN char_length(cccd) = 12 THEN 'Hop Le'
        ELSE 'Khong Hop Le'
	END AS trang_thai
FROM employees;

SELECT * FROM employees 
WHERE lower(first_name) = 'nguyen';

SELECT 
	first_name,
    CONCAT(
		UPPER(SUBSTRING(first_name,1,1)),
        LOWER(SUBSTRING(first_name,2))
	) AS first_name_proper	
FROM employees;