-- Cach cu: subquery long nhau, doc tu trong ra ngoai
USE hr;
SELECT first_name, salary FROM employees
WHERE salary = ( 
			SELECT MAX(salary)
            FROM employees
            WHERE salary < ( SELECT MAX(salary) FROM employees));
            
-- CACH CTE: doc tu tren xuong, tung buoc co ten
WITH max_all AS (
		SELECT MAX(salary) AS m FROM employees 
),
second_max AS (
	SELECT MAX(salary) AS m FROM employees
    WHERE salary < ( SELECT m FROM max_all)
)
SELECT first_name, salary
FROM employees
WHERE salary = ( SELECT m FROM second_max);

-- Nhiều CTE nối tiếp
WITH luong_phong AS (
		SELECT department_id, AVG(salary) AS tb, COUNT(*) AS so_nv
        FROM employees
        GROUP BY department_id
),
phong_lon AS (
	SELECT * FROM luong_phong WHERE so_nv >= 3
)
SELECT d.department_name, p.tb, p.so_nv 
FROM phong_lon p
JOIN departments d 
ON d.department_id = p.department_id
ORDER BY p.tb DESC;

--  Ví dụ so sánh một bảng với chính nó:
	WITH tb AS (
	SELECT department_id, AVG(salary) AS avg_sal
    FROM employees GROUP BY department_id
)
SELECT a.department_id, a.avg_sal, b.department_id, b.avg_sal
FROM tb a
JOIN tb b 
ON a.avg_sal > b.avg_sal; 

-- B. Recursive CTE
-- Cấu trúc bắt buộc
-- WITH RECURSIVE ten AS (
-- 	-- 1. ANCHOR: diem xuat phat, chay dung 1 lan
--     SELECT ... 
--     
--     UNION ALL 
--     
--     -- 2 RECURIVE: tu goi lai chinh no, chay toi khi khong ra dong moi
--     SELECT ... FROM bang JOIN ten ON 
-- )
-- SELECT * FROM ten;

-- Ví dụ 1 — sinh dãy số 1 đến 10
WITH RECURSIVE dem AS (
	SELECT 1 AS n  -- anchor
    UNION ALL 
    SELECT n + 1 FROM dem WHERE n < 10 -- recursive, co diem dung
)
SELECT n FROM dem;