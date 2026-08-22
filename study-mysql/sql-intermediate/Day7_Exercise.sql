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
GROUP BY e.department_id,d.department_id;
