-- Viết lại bài "lương lớn thứ ba" bằng CTE, mỗi bước một CTE có tên rõ ràng.

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
