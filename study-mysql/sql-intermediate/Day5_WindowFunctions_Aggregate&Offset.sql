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
SELECT first_name, hire_date, salary,
		ROUND(AVG(salary) OVER (ORDER BY hire_date
								ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ), 0) AS tb_truot
FROM employees ORDER BY hire_date;

-- Hàm offset — nhìn sang dòng khác 
-- LAG(cot, n, mac_dinh) -- Lay gia tri cua dong TRUOC n buoc 
-- LEAD(cot, n, mac_dinh) -- Lay gia tri cua dong SAU n buoc 


SELECT first_name, hire_date, salary,
	LAG(salary, 1) OVER (ORDER BY hire_date) AS luong_nguoi_truoc,
    LEAD(salary, 1) OVER (ORDER BY hire_date) AS luong_nguoi_sau,
    salary - LAG(salary, 1, 0) OVER (ORDER BY hire_date) AS chech_lech 
FROM employees
ORDER BY hire_date;

-- FIRST_VALUE, LAST_VALUE, NTH_VALUE
SELECT first_name, department_id, salary,
		FIRST_VALUE(first_name) OVER (PARTITION BY department_id 
										ORDER BY salary DESC ) nguoi_luong_cao_nhat,
		LAST_VALUE(first_name) OVER (PARTITION BY department_id ORDER BY salary DESC
				ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS nguoi_luong_thap_nhat
FROM employees;

