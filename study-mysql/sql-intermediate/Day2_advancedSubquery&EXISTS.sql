-- TRONG SELECT: gia tri lap lai o moi dong
SELECT first_name, salary,
		(SELECT AVG(salary) FROM employees) AS luong_tb,
        salary - (SELECT AVG(salary) FROM employees) AS chenh_lech
FROM employees;

-- TRONG FROM: bat buoc phai co alias, neu thieu -> ERROR 1248
SELECT department_id, so_nv
FROM ( SELECT department_id, COUNT(*) AS so_nv
		FROM employees GROUP BY department_id) AS t
WHERE so_nv >= 3;

-- Trong HAVING
SELECT department_id, AVG(salary) AS tb
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees);

-- B. Correlated subquery — subquery tương quan
-- Nhân viên có lương cao hơn trung bình CỦA CHÍNH PHÒNG MÌNH

SELECT e.first_name, e.department_id, e.salary
FROM employees e 
WHERE e.salary > ( SELECT AVG(e2.salary)
					FROM employees e2
                    WHERE e2.department_id = e.department_id );  
                    
-- C. EXISTS vs IN vs JOIN
-- Cach 1: IN 
SELECT department_name 
FROM departments d 
WHERE d.department_id IN (SELECT department_id FROM employees);

-- Cach 2: EXISTS (correlated)
SELECT department_name FROM departments d
WHERE EXISTS (SELECT 1 FROM employees e 
				WHERE e.department_id = d.department_id);
                
-- Cach 3: JOIN + DISTINCT 
SELECT DISTINCT d.department_name 
FROM departments d
JOIN employees e 
ON e.department_id = d.department_id;

-- Tra ve 0 dong neu employees co ai do department_id = NULL
SELECT department_name FROM departments 
WHERE department_id NOT IN (SELECT department_id FROM employees);

-- Cach 1: loc NULL ra
SELECT department_name FROM departments 
WHERE department_id NOT IN ( SELECT department_id FROM employees
							WHERE department_id IS NOT NULL);

-- Cach 2: dung NOT EXISTS ( an toan voi NULL )
SELECT department_name FROM departments d 
WHERE NOT EXISTS ( SELECT 1 FROM employees e 
					WHERE e.department_id = d.department_id);

-- Anti-join — tìm cái "không có"
-- LEFT JOIN + IS NULL: cach thu ba, rat hay gap o trong de thi
SELECT d.department_name
FROM departments d
LEFT JOIN employees e
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

