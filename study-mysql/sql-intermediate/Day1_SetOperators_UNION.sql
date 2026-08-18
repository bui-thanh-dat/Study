SELECT first_name, salary, 'Luong cao' AS nhom
FROM employees WHERE salary >= 10000

UNION ALL

SELECT first_name, salary, 'Luong thap' 
FROM employees WHERE salary < 5000

ORDER BY salary DESC;

-- Giao: co o ca hai 
SELECT department_id FROM employees
INTERSECT 
SELECT department_id FROM departments;

-- Hieu: co o ve trai, khong co o ve phai 
SELECT department_id FROM departments
EXCEPT 
SELECT department_id FROM employees;

-- Bài tập ngày 1B
-- 1. Tạo danh sách gộp: tất cả first_name của nhân viên phòng 50, nối với tất cả department_name của các phòng có location_id = 1700 . Thêm cột nhãn phân biệt hai nguồn.

SELECT first_name AS name, 'Employee' AS source 
FROM employees
WHERE department_id = 50

UNION ALL 

SELECT 