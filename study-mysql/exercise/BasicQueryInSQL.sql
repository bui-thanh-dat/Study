-- =========================================
-- 1. TẠO DATABASE
-- =========================================

CREATE DATABASE company_db;

USE company_db;


-- =========================================
-- 2. TẠO BẢNG
-- =========================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hourly_pay DECIMAL(5,2),
    hire_date DATE,
    CONSTRAINT chk_hourly_pay
    CHECK (hourly_pay >= 10.00)
);


-- =========================================
-- 3. THÊM DỮ LIỆU (INSERT)
-- =========================================

INSERT INTO employees (first_name, last_name, hourly_pay, hire_date)
VALUES
('Eugene', 'Krabs', 25.50, '2023-01-02'),
('Squidward', 'Tentacles', 15.00, '2023-01-03'),
('Spongebob', 'Squarepants', 12.50, '2023-01-04'),
('Patrick', 'Star', 12.50, '2023-01-05'),
('Sandy', 'Cheeks', 17.25, '2023-01-06'),
('Sheldon', 'Plankton', 10.00, NULL);


-- =========================================
-- 4. XEM DỮ LIỆU (SELECT)
-- =========================================

SELECT * FROM employees;


-- =========================================
-- 5. CẬP NHẬT DỮ LIỆU (UPDATE)
-- =========================================

-- Cập nhật 1 nhân viên

UPDATE employees
SET hourly_pay = 10.50,
    hire_date = '2026-06-30'
WHERE employee_id = 6;


-- Cập nhật toàn bộ nhân viên

UPDATE employees
SET hourly_pay = 10.50,
    hire_date = '2026-06-30';


-- =========================================
-- 6. XÓA DỮ LIỆU (DELETE)
-- =========================================

-- Xóa 1 nhân viên

DELETE FROM employees
WHERE employee_id = 6;


-- Xóa toàn bộ dữ liệu

DELETE FROM employees;


-- =========================================
-- 7. ALTER TABLE - THÊM RÀNG BUỘC
-- =========================================

ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay
CHECK (hourly_pay >= 10.00);


-- =========================================
-- 8. ALTER TABLE - XÓA RÀNG BUỘC
-- =========================================

ALTER TABLE employees
DROP CHECK chk_hourly_pay;


-- =========================================
-- 9. ALTER TABLE - THÊM CỘT
-- =========================================

ALTER TABLE employees
ADD email VARCHAR(100);


-- =========================================
-- 10. ALTER TABLE - SỬA CỘT
-- =========================================

ALTER TABLE employees
MODIFY email VARCHAR(150);


-- =========================================
-- 11. ALTER TABLE - ĐỔI TÊN CỘT
-- =========================================

ALTER TABLE employees
RENAME COLUMN email TO employee_email;


-- =========================================
-- 12. ALTER TABLE - XÓA CỘT
-- =========================================

ALTER TABLE employees
DROP COLUMN employee_email;


-- =========================================
-- 13. XÓA BẢNG
-- =========================================

DROP TABLE employees;


-- =========================================
-- 14. XÓA DATABASE
-- =========================================

DROP DATABASE company_db;