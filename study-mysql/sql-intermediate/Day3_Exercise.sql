-- Viết lại bài "lương lớn thứ ba" bằng CTE, mỗi bước một CTE có tên rõ ràng.
USE hr;

WITH max_all AS (
	SELECT MAX(salary) AS m FROM employees
),
second_max AS (
	SELECT MAX(salary) AS m FROM employees
    WHERE salary < (SELECT m FROM max_all)
),
third_max AS (
	SELECT MAX(salary) AS m FROM employees
    WHERE salary < (SELECT m FROM second_max) 
)
SELECT first_name, salary
FROM employees
WHERE salary = (SELECT m FROM third_max);

-- 2. Dùng CTE tính lương trung bình mỗi phòng, sau đó liệt kê nhân viên có lương cao hơn trung bình phòng mình
WITH luong_tb_phong AS (
	SELECT department_id, AVG(salary) AS luong_tb
    FROM employees
    GROUP BY department_id
)

SELECT e.employee_id, e.first_name, e.salary, t.luong_tb
FROM employees e
JOIN luong_tb_phong t 
ON e.department_id = t.department_id 
WHERE e.salary > t.luong_tb;

-- 3. Dùng recursive CTE sinh dãy số từ 1 đến 30.
WITH RECURSIVE dem AS (
SELECT 1 AS n 
UNION ALL
SELECT n + 1 FROM dem WHERE n < 30
)
SELECT n FROM dem;

-- Chạy ví dụ cây quản lý ở trên. Sau đó sửa để chỉ hiện những người ở cấp 3 trở xuống.
WITH RECURSIVE cay AS (
-- Anchor: người không có sếp = đỉnh cây
SELECT employee_id, first_name, last_name, manager_id,
			1 AS cap,
			CAST(first_name AS CHAR(500)) AS duong_dan
FROM employees
WHERE manager_id IS NULL
UNION ALL
-- Recursive: tìm lính của những người đã có trong cây
SELECT e.employee_id, e.first_name, e.last_name, e.manager_id,
c.cap + 1,
CONCAT(c.duong_dan, ' > ', e.first_name)
FROM employees e
JOIN cay c ON e.manager_id = c.employee_id
)

SELECT c.cap, c.duong_dan, c.first_name, c.last_name
FROM cay c 
WHERE EXISTS ( 
		SELECT 1 FROM employees e
        WHERE e.manager_id = c.employee_id
)
ORDER BY c.duong_dan;

-- 5. Với mỗi nhân viên, đếm tổng số cấp dưới ở mọi cấp (không chỉ cấp trực tiếp) — dùng recursive CTE. 
WITH RECURSIVE hau_due AS (
	-- Anchor: moi nguoi tu lam goc cua chinh minh
    SELECT employee_id AS to_tien,
			employee_id AS hien_tai 
	FROM employees
    
    UNION ALL
    
    -- Recursive: di xuong 1 tang, nhung giu nguyen to tien 
    SELECT h.to_tien, -- giu nguyen, KHONG doi
			e.employee_id -- nhich xuong
	FROM employees e 
    JOIN hau_due h 
    ON e.manager_id = h.hien_tai
)
SELECT h.to_tien,
		COUNT(*) - 1 AS so_cap_duoi
FROM hau_due h
GROUP BY h.to_tien;
        
