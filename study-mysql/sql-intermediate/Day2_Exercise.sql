-- Bài tập ngày 2
USE hr;
-- 1. Tìm nhân viên có lương cao hơn lương của quản lý trực tiếp của mình (correlated subquery hoặc self join).
SELECT e.employee_id, e.first_name, e.salary, m.salary AS luong_sep
FROM employees e
JOIN employees m 
ON e.manager_id = m.employee_id
WHERE e.salary > m.salary
GROUP BY e.employee_id; 

SELECT e.employee_id,
		e.first_name,
		e.last_name,
        e.salary
FROM employees e 
WHERE e.salary > ( SELECT m.salary 
					FROM employees m 
					WHERE m.employee_id = e.manager_id );
SELECT e.first_name, e.salary AS luong_nv,
       m.first_name AS ten_sep, m.salary AS luong_sep
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY (e.salary - m.salary) DESC;

-- 2. Tìm các phòng ban chưa có nhân viên nào — viết bằng cả 3 cách: NOT IN , NOT EXISTS , anti-join. So sánh kết quả.
SELECT d.department_id, d.department_name
FROM departments d
WHERE d.department_id NOT IN (SELECT department_id 
								FROM employees
                                WHERE department_id IS NOT NULL);
-- NOT EXISTS 
SELECT d.department_id, d.department_name 
FROM departments d 
WHERE NOT EXISTS ( SELECT 1 FROM employees e 
					WHERE e.department_id = d.department_id);
-- Anti-join
SELECT d.department_id, d.department_name
FROM departments d 
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

-- 3. Hiện mỗi nhân viên kèm số đồng nghiệp cùng phòng (không tính chính họ) — dùng correlated subquery trong SELECT .
SELECT e.employee_id, e.first_name, e.department_id,
	(SELECT 
	COUNT(*) 
    FROM employees c
    WHERE e.department_id = c.department_id 
		AND c.employee_id <> e.employee_id) AS  so_dong_nghiep
FROM employees e;

SELECT department_id, COUNT(*) - 1 AS so_dong_nghiep
FROM employees
GROUP BY department_id;