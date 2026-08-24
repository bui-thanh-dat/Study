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

