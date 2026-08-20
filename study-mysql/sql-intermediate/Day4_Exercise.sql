USE hr;

SELECT 	first_name, 
		department_id,
		salary, 
	MAX(salary) OVER w  AS luong_cao_nhat_phong,
	MAX(salary) OVER w - salary	AS chech_lech
FROM employees
WINDOW w AS (PARTITION BY department_id)
ORDER BY department_id, salary DESC;

-- Tìm 3 người có lương cao nhất mỗi phòng. Nếu có người bằng lương thì lấy hết.

WITH t  AS (
	SELECT 	first_name,
			department_id,
            salary,
            RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS hang,
            DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS hang_dense
	FROM employees
)
SELECT * FROM t WHERE hang <= 3
ORDER BY department_id, hang;

-- 3. Xếp hạng nhân viên theo hire_date (vào trước hạng cao hơn) trong từng phòng. Ai là người kỳ cựu nhất mỗi phòng?
SELECT first_name,
		department_id,
        hire_date,
        RANK() OVER (PARTITION BY department_id ORDER BY hire_date ASC) tham_nien
FROM employees
ORDER BY department_id, tham_nien;

-- 4.Chia toàn bộ nhân viên thành 4 nhóm theo lương bằng NTILE(4) . Đếm xem mỗi nhóm có bao nhiêu người.
WITH t AS (
	SELECT first_name,
			salary, 
            NTILE(4) OVER (ORDER BY salary ASC ) AS nhom 	
	FROM employees 
)
SELECT nhom, COUNT(*) AS so_nguoi, MIN(salary), MAX(salary)
FROM t
GROUP BY nhom
ORDER BY COUNT(*) DESC;

-- 5. Với mỗi job_id , tìm người có lương cao nhất và người thấp nhất — hiện trên cùng một kết quả.
WITH t AS (
	SELECT 	job_id,
			first_name,
            salary,
            RANK() OVER (w ORDER BY salary DESC) AS hang_nhat,
			RANK() OVER (w ORDER BY salary ASC) AS hang_thap
	FROM employees
    WINDOW w AS (PARTITION BY job_id)
) 

SELECT job_id, first_name,salary,
		CASE 
			WHEN hang_nhat = 1 AND hang_thap = 1 THEN 'Duy nhat muc luong'
            WHEN hang_nhat = 1 THEN 'Cao nhat'
            ELSE 'Thap Nhat'
		END AS loai
FROM t 
WHERE hang_nhat = 1 OR hang_thap = 1
ORDER BY job_id, salary DESC;

-- lương cao nhất mỗi phòng bằng window function

WITH t AS (
	SELECT first_name,
			department_id,
            salary,
			RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) hang
	FROM employees
)
SELECT * FROM t WHERE hang = 1;

