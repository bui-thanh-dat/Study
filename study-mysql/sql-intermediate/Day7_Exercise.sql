USE hr;
-- 1. Với mỗi phòng ban, hiện: tên phòng, số nhân viên, lương trung bình (làm tròn 0), tên người lương cao nhất phòng. Chỉ lấy phòng có từ 2 nhân viên trở lên, sắp theo lương trung bình giảm dần.

SELECT 	d.department_name,
		d.department_id,
		COUNT(*) AS so_nhan_vien,
        ROUND(AVG(e.salary)) AS luong_tb,
        MAX(e.salary) AS luong_cao_nhat
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP BY e.department_id,d.department_id 
HAVING COUNT(d.department_id) >= 2
ORDER BY luong_tb DESC;

-- 2. Tìm những nhân viên có lương nằm trong top 25% của công ty. Dùng NTILE .

SELECT 
	employee_id,
    first_name,
    salary
FROM (
	SELECT 
	employee_id,
    first_name,
    salary,
    NTILE(4) OVER(ORDER BY salary DESC) AS top_25pt_CTY
FROM employees
) AS t 
WHERE top_25pt_CTY = 1
ORDER BY salary DESC;

WITH t AS (
	SELECT employee_id, first_name, salary,
    NTILE(4) OVER(ORDER BY salary DESC) AS nhom
    FROM employees
)
SELECT * FROM t WHERE nhom = 1;
-- 3. Với mỗi năm tuyển dụng, hiện: năm, số người tuyển, tổng lương, và chênh lệch số người so với năm trước đó

SELECT 
	YEAR(hire_date) AS nam,
    COUNT(*) AS so_nguoi,
    SUM(salary) AS tong_luong,
    SUM(salary) - LAG(SUM(salary),1) OVER(ORDER BY YEAR(hire_date)) AS chech_lech_nam_truoc,
    COUNT(*) - LAG(COUNT(*),1) OVER(ORDER BY YEAR(hire_date)) AS chech_lech_so_nguoi
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY nam;

-- 4. Phân loại nhân viên thành 'Sếp' (có ít nhất 1 cấp dưới) và 'Nhân viên' (không có ai). Đếm mỗi loại bao nhiêu người.
SELECT 
	CASE WHEN  e.employee_id IN (SELECT m.manager_id FROM employees m)  THEN 'SEP' ELSE 'NHAN VIEN' END AS loai,
    COUNT(*) AS so_nguoi
FROM employees e
GROUP BY loai;

-- 5. Hiện toàn bộ chuỗi quản lý của Bruce Ernst từ cấp cao nhất xuống (dùng recursive CTE)
WITH RECURSIVE chuoi_ql AS (
	-- Anchor: chinh Bruce Ernst
    SELECT employee_id, first_name, last_name, manager_id, 1 AS cap
    FROM employees
    WHERE first_name = 'Bruce' AND last_name = 'Ernst'
    
    UNION ALL 
    
    -- Recursive: tu node hien tai nhay len sep cua no
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, c.cap + 1 
    FROM employees e 
    JOIN chuoi_ql c 
    ON e.employee_id = c.manager_id
)
SELECT cap, first_name, last_name
FROM chuoi_ql
ORDER BY cap DESC;

-- 6. Với mỗi job_id , hiện lương cao nhất, thấp nhất, trung bình, và số người có lương trên mức trung bình của chính job_id đó.
SELECT job_id, 
	MAX(salary) AS luong_cao_nhat, 
    MIN(salary) AS luong_thap_nhat, 
    AVG(salary) AS luong_tb,
    COUNT(CASE WHEN salary > tb_nhom THEN 1 END) AS so_nguoi_ten_tb 
FROM (
	SELECT job_id, salary,
		AVG(salary) OVER (PARTITION BY job_id) AS tb_nhom
	FROM employees
) t
GROUP BY job_id;