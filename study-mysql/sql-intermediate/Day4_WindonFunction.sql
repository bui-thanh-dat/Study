-- GROUP BY: 8 dòng, mất tên nhân viên
SELECT department_id, AVG(salary) 
FROM employees 
GROUP BY department_id;

-- Window: 30 dong, giu du chi tiet
SELECT first_name, department_id, salary, 
		AVG(salary) OVER (PARTITION BY department_id) AS tb_phong
FROM employees;

-- Cấu trúc mệnh đề OVER

-- HAM() OVER(
-- 		PARTITION BY cot_chia_nhom -- chia dữ liệu thành các "cửa sổ" độc lập
--  	ORDER BY cot_sap_xep -- thứ tự bên trong mỗi cửa sổ
-- )

-- B. Bốn hàm xếp hạng
SELECT first_name, department_id, salary,
		ROW_NUMBER() 	OVER(ORDER BY salary DESC) AS rn, 
        RANK() 			OVER(ORDER BY salary DESC) AS rnk,
        DENSE_RANK() 	OVER(ORDER BY salary DESC) AS drnk,
        NTILE(4)   		OVER(ORDER BY salary DESC) AS nhom_4
FROM employees;


-- 2 nguoi luong cao nhat moi phong 
WITH xep_hang AS (
	SELECT first_name, last_name, department_id, salary, 
			DENSE_RANK() OVER(PARTITION BY department_id
								ORDER BY salary DESC ) AS hang
	FROM employees
)
SELECT first_name, last_name, department_id, salary
FROM xep_hang
WHERE hang <=2 
ORDER BY department_id, hang;

--  "Lương cao thứ 3" — so với 3 tầng subquery lồng nhau

WITH t AS (
	SELECT first_name, last_name,salary,
		DENSE_RANK() OVER (ORDER BY salary DESC) AS hang 
	FROM employees 
)
SELECT first_name, last_name, salary 
FROM t 
WHERE hang = 3;

-- "Nhân viên lương cao nhất mỗi phòng" — so với correlated subquery
WITH t AS (
	SELECT first_name, department_id, salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS hang
    FROM employees
)
SELECT * FROM t WHERE hang = 1;
	