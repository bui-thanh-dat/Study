-- A. Hàm tổng hợp dạng window
USE hr;

SELECT first_name, department_id, salary,
	SUM(salary) OVER (PARTITION BY department_id) AS tong_phong,
    AVG(salary) OVER (PARTITION BY department_id) AS tb_phong,
    COUNT(*) 	OVER (PARTITION BY department_id) AS so_nv_phong,
    MAX(salary)	OVER (PARTITION BY department_id) AS max_phong,
    ROUND(salary * 100.0 / SUM(salary) OVER (PARTITION BY department_id),2) AS phan_tram
FROM employees 
ORDER BY department_id, salary DESC;

SELECT first_name, hire_date, salary, 
	SUM(salary) OVER() AS tong_toan_bo,
    SUM(salary) OVER(ORDER BY hire_date) AS luy_ke
FROM employees
ORDER BY hire_date ASC;

-- Trung binh truot 3 dong 
SELECT first_name, hire_date, salary
