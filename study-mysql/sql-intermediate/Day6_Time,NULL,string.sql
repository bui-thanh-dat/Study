-- Thâm niên và nhóm theo năm tuyển
USE hr;
SELECT first_name,
		hire_date,
        YEAR(hire_date) AS nam_vao,
        TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS tham_nien,
        DATE_FORMAT(hire_date, '%M ' '%Y') AS thang_nam
FROM employees;

-- Đếm nhân viên tuyển theo từng năm
SELECT YEAR(hire_date) AS nam, COUNT(*) AS so_nguoi
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY nam;

EXPLAIN SELECT * FROM employees WHERE YEAR(hire_date) = 1997;
EXPLAIN SELECT * FROM employees 
WHERE hire_date >= '1997-01-01' AND hire_date < '1998-01-01';