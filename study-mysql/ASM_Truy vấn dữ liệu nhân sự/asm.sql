CREATE DATABASE hr;
USE hr;

CREATE TABLE departments
    ( department_id INTEGER PRIMARY KEY
    , department_name VARCHAR(30)
    , location_id INTEGER
    ) ;

CREATE TABLE employees
   ( employee_id INTEGER
   , first_name VARCHAR(20)
   , last_name VARCHAR(25) 
   , email VARCHAR(25)
   , phone_number VARCHAR(20)
   , hire_date DATE
   , job_id VARCHAR(10)
   , salary INTEGER
   , commission_pct INTEGER
   , manager_id INTEGER
   , department_id INTEGER
   , constraint pk_emp primary key (employee_id) 
   , constraint fk_deptno foreign key (department_id) references departments(department_id)  
   ) ;


## Insert insto Departments table
 INSERT INTO departments VALUES ( 20,'Marketing',  180);
 INSERT INTO departments VALUES ( 30,'Purchasing',  1700);
 INSERT INTO departments VALUES ( 40, 'Human Resources',  2400);
 INSERT INTO departments VALUES ( 50, 'Shipping',  1500);
 INSERT INTO departments VALUES ( 60 , 'IT',  1400);
 INSERT INTO departments VALUES ( 70, 'Public Relations',  2700);
 INSERT INTO departments VALUES ( 80 , 'Sales',  2500 );
 INSERT INTO departments VALUES ( 90 , 'Executive',  1700);
 INSERT INTO departments VALUES ( 100 , 'Finance',  1700);
 INSERT INTO departments VALUES ( 110 , 'Accounting',  1700);
 INSERT INTO departments VALUES ( 120 , 'Treasury' ,  1700);
 INSERT INTO departments VALUES ( 130 , 'Corporate Tax' ,  1700 );
 INSERT INTO departments VALUES ( 140, 'Control And Credit' ,  1700);
 INSERT INTO departments VALUES ( 150 , 'Shareholder Services', 1700);
 INSERT INTO departments VALUES ( 160 , 'Benefits', 1700);
 INSERT INTO departments VALUES ( 170 , 'Payroll' , 1700);


## Insert into Employees table
INSERT INTO employees VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17' , 'AD_PRES', 24000 , NULL, NULL, 20);
INSERT INTO employees VALUES (101, 'Neena' , 'Kochhar' , 'NKOCHHAR' , '515.123.4568' , '1989-11-21' , 'AD_VP' , 17000 , NULL , 100 , 20);
INSERT INTO employees VALUES (102 , 'Lex' , 'De Haan' , 'LDEHAAN' , '515.123.4569' , '1993-09-12' , 'AD_VP' , 17000 , NULL , 100 , 30);
INSERT INTO employees VALUES (103 , 'Alexander' , 'Hunold' , 'AHUNOLD' , '590.423.4567' , '1990-09-30', 'IT_PROG' , 9000 , NULL , 102 , 60);
INSERT INTO employees VALUES (104 , 'Bruce' , 'Ernst' , 'BERNST' , '590.423.4568' , '1991-05-21',  'IT_PROG' , 6000 , NULL , 103 , 60);
INSERT INTO employees VALUES (105 , 'David' , 'Austin' , 'DAUSTIN' , '590.423.4569' , '1997-06-25',  'IT_PROG' , 4800 , NULL , 103 , 60);
INSERT INTO employees VALUES (106 , 'Valli' , 'Pataballa' , 'VPATABAL' , '590.423.4560' , '1998-02-05',  'IT_PROG' , 4800 , NULL , 103 , 40);
INSERT INTO employees VALUES (107 , 'Diana' , 'Lorentz' , 'DLORENTZ' , '590.423.5567' , '1999-02-09',  'IT_PROG' , 4200 , NULL , 103 , 40);
INSERT INTO employees VALUES (108 , 'Nancy' , 'Greenberg' , 'NGREENBE' , '515.124.4569' , '1994-08-17',  'FI_MGR' , 12000 , NULL , 101 , 100);
INSERT INTO employees VALUES (109 , 'Daniel' , 'Faviet' , 'DFAVIET' , '515.124.4169' , '1994-08-12',  'FI_ACCOUNT' , 9000 , NULL , 108 , 170);
INSERT INTO employees VALUES (110 , 'John' , 'Chen' , 'JCHEN' , '515.124.4269' , '1997-04-09',  'FI_ACCOUNT' , 8200 , NULL , 108 , 170);
INSERT INTO employees VALUES (111 , 'Ismael' , 'Sciarra' , 'ISCIARRA' , '515.124.4369' , '1997-02-01',  'FI_ACCOUNT' , 7700 , NULL , 108 , 160);
INSERT INTO employees VALUES (112 , 'Jose Manuel' , 'Urman' , 'JMURMAN' , '515.124.4469' , '1998-06-03', 'FI_ACCOUNT' , 7800 , NULL , 108 , 150);
INSERT INTO employees VALUES (113 , 'Luis' , 'Popp' , 'LPOPP' , '515.124.4567' , '1999-12-07',  'FI_ACCOUNT' , 6900 , NULL , 108 , 140);
INSERT INTO employees VALUES (114 , 'Den' , 'Raphaely' , 'DRAPHEAL' , '515.127.4561' , '1994-11-08',  'PU_MAN' , 11000 , NULL , 100 , 30);
INSERT INTO employees VALUES (115 , 'Alexander' , 'Khoo' , 'AKHOO' , '515.127.4562' , '1995-05-12',  'PU_CLERK' , 3100 , NULL , 114 , 80);
INSERT INTO employees VALUES (116 , 'Shelli' , 'Baida' , 'SBAIDA' , '515.127.4563' ,'1997-12-13', 'PU_CLERK' , 2900 , NULL , 114 , 70);
INSERT INTO employees VALUES (117 , 'Sigal' , 'Tobias' , 'STOBIAS' , '515.127.4564' , '1997-09-10', 'PU_CLERK' , 2800 , NULL , 114 , 30);
INSERT INTO employees VALUES (118 , 'Guy' , 'Himuro' , 'GHIMURO' , '515.127.4565' , '1998-01-02',  'PU_CLERK' , 2600 , NULL , 114 , 60);
INSERT INTO employees VALUES (119 , 'Karen' , 'Colmenares' , 'KCOLMENA' , '515.127.4566' , '1999-04-08',  'PU_CLERK' , 2500 , NULL , 114 , 130);
INSERT INTO employees VALUES (120 , 'Matthew' , 'Weiss' , 'MWEISS' , '650.123.1234' ,'1996-07-18',  'ST_MAN' , 8000 , NULL , 100 , 50);
INSERT INTO employees VALUES (121 , 'Adam' , 'Fripp' , 'AFRIPP' , '650.123.2234' , '1997-08-09',  'ST_MAN' , 8200 , NULL , 100 , 50);
INSERT INTO employees VALUES (122 , 'Payam' , 'Kaufling' , 'PKAUFLIN' , '650.123.3234' ,'1995-05-01',  'ST_MAN' , 7900 , NULL , 100 , 40);
INSERT INTO employees VALUES (123 , 'Shanta' , 'Vollman' , 'SVOLLMAN' , '650.123.4234' , '1997-10-12',  'ST_MAN' , 6500 , NULL , 100 , 50);
INSERT INTO employees VALUES (124, 'Kevin' , 'Mourgos' , 'KMOURGOS' , '650.123.5234' , '1999-11-12',  'ST_MAN' , 5800 , NULL , 100 , 80);
INSERT INTO employees VALUES (125, 'Julia' , 'Nayer' , 'JNAYER' , '650.124.1214' , '1997-07-02',  'ST_CLERK' , 3200 , NULL , 120 , 50);
INSERT INTO employees VALUES (126, 'Irene' , 'Mikkilineni' , 'IMIKKILI' , '650.124.1224' , '1998-11-12', 'ST_CLERK' , 2700 , NULL , 120 , 50);
INSERT INTO employees VALUES (127, 'James' , 'Landry' , 'JLANDRY' , '650.124.1334' , '1999-01-02' , 'ST_CLERK' , 2400 , NULL , 120 , 90);
INSERT INTO employees VALUES (128, 'Steven' , 'Markle' , 'SMARKLE' , '650.124.1434' , '2000-03-04' , 'ST_CLERK' , 2200 , NULL , 120 , 50);
INSERT INTO employees VALUES (129, 'Laura' , 'Bissot' , 'LBISSOT' , '650.124.5234' ,'1997-09-10' , 'ST_CLERK' , 3300 , NULL , 121 , 50);
INSERT INTO employees VALUES (130, 'Mozhe' , 'Atkinson' , 'MATKINSO' , '650.124.6234' , '1997-10-12' , 'ST_CLERK' , 2800 , NULL , 121 , 110);

 -- 1. Truy vấn first_name, last_name, job_id và salary của các nhân viên có tên bắt đầu bằng chữ “S”
SELECT first_name, last_name, job_id,salary 
FROM employees 
WHERE first_name LIKE'S%';
-- 2. Viết truy vấn để tìm các nhân viên có số lương (salary) cao nhất
SELECT employee_id,first_name, last_name, job_id,salary 
FROM employees 
ORDER BY  salary DESC LIMIT 1 ;
--  Viết truy vấn để tìm các nhân viên có số lương lớn thứ hai. Ví dụ có 5 nhân viên có mức lương lần lượt là
-- 4, 4, 3, 3, 2 thì kết quả  đúng của mức lương lớn thứ hai sẽ là 3,3
SELECT first_name, last_name, job_id,salary 
FROM employees 
WHERE salary = (
	SELECT MAX(SALARY) 
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees) 
);
-- 4. Viết truy vấn để tìm các nhân viên có số lương lớn thứ ba. Tương tự như yêu cầu 3

SELECT first_name, last_name, job_id,salary 
FROM employees 
WHERE salary = (
	SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 1  OFFSET 2
);
-- 5. Viết truy vấn để hiển thị mức lương của nhân viên cùng với người quản lý tương ứng, tên nhân viên và quản lý kết hợp từ first_name và last_name
SELECT 
	CONCAT(e.first_name," ", e.last_name ) AS employee,
    e.salary AS emp_sal,
    CONCAT(m.first_name, " ",e.last_nsame ) AS manager,
    m.salary AS mgr_sal
    FROM employees e 
    JOIN employees m 
    ON e.manager_id = m.employee_id
    ORDER BY e.employee_id;
    
 -- 6. Viết truy vấn để tìm số lượng nhân viên cần quản lý của mỗi người quản lý, tên quản lý kết hợp từ first_name và last_name
 
SELECT 
	m.employee_id, 
	CONCAT(m.first_name," " ,m.last_name) AS manager_name,
    COUNT(e.employee_id) AS number_of_reportees
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name, m.last_name
-- GROUP BY m.employee_id
ORDER BY number_of_reportees DESC;

-- Viết truy vấn để tìm được số lượng nhân viên trong mỗi phòng ban sắp xếp theo thứ tự số nhân viên giảm dần

SELECT department_name, 
		COUNT(employee_id) AS emp_count
FROM departments d
JOIN employees 
ON  d.department_id = employees.department_id
GROUP BY d.department_name, d.department_id
ORDER BY emp_count DESC;

-- 8 Viết truy vấn để tìm số lượng nhân viên được thuê trong mỗi năm sắp xếp theo thứ tự số lương nhân viên giảm dần và nếu số lượng nhân viên bằng nhau thì sắp xếp theo năm tăng dần
SELECT YEAR(hire_date) AS hired_year ,
	COUNT(e.employee_id) AS  employees_hired_count
FROM employees e 
GROUP BY YEAR(hire_date)
ORDER BY employees_hired_count DESC, hired_year ASC;

-- 9 Viết truy vấn để lấy mức lương lớn nhất, nhỏ nhất và mức lương trung bình của các nhân viên (làm tròn mức lương trung bình về số nguyên)

SELECT 
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
    ROUND(AVG(salary)) AS avg_sal
FROM employees;

-- 10 Viết truy vấn để chia nhân viên thành ba nhóm dựa vào mức lương, tên nhân viên được kết hợp từ first_name và last_name, kết quả sắp xếp theo tên thứ tự tăng dần


SELECT 
	CONCAT(e.first_name, ' ' ,e.last_name) AS employee,
    e.salary,
		CASE 
        WHEN e.salary >= 2000 AND e.salary < 5000 THEN "low"
        WHEN e.salary >= 5000 AND e.salary < 10000 THEN "mid"
        ELSE "high" 
        END AS salary_level
FROM employees e 
JOIN employees m 
ON e.manager_id = m.employee_id
ORDER BY e.first_name ASC;

-- 11. Viết truy vấn hiển thị họ tên nhân viên và số điện thoại theo định dạng (_ _ _)-(_ _ _)-(_ _ _ _). Tên nhân viên kết hợp từ first_name và last_name, kết quả hiển thị như hình vẽ dưới đây
SELECT 
	CONCAT(first_name,' ', last_name) AS employee,
    CONCAT( SUBSTRING(phone_number, 1 , 3), '-' , SUBSTRING(phone_number, 5 , 3), '-', SUBSTRING(phone_number, 9 , 4)) AS phone_number
FROM employees;

-- 12 Viết truy vấn để tìm các nhân viên gia nhập vào tháng 08-1994, tên nhân viên kết hợp từ first_name và last_name
SELECT 
	CONCAT(first_name, ' ' , last_name) AS employee,
    hire_date
FROM employees
WHERE YEAR(hire_date) = 1994 AND MONTH(hire_date) = 8;

-- 13. Viết truy vấn để tìm những nhân viên có mức lương cao hơn mức lương trung bình của các nhân viên, kết quả sắp xếp theo thứ tự tăng dần của department_id

SELECT 
	CONCAT(first_name,last_name) AS name, 
    e.employee_id, 
    d.department_name AS department, 
    d.department_id, 
    e.salary 
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- 14. Viết truy vấn để tìm mức lương lớn nhất ở mỗi phòng ban, kết quả sắp xếp theo thứ tự tăng dần của department_id
SELECT 
    d.department_id, 
	d.department_name AS department, 
    MAX(e.salary) AS maxium_salary
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
GROUP BY d.department_id
ORDER BY d.department_id ASC;

-- 15. Viết truy vấn để tìm 5 nhân viên có mức lương thấp nhất
SELECT first_name, last_name, employee_id, salary
FROM employees
ORDER BY salary ASC LIMIT 5;

-- 16. Viết truy vấn để hiển thị tên nhân viên theo thứ tự ngược lại
SELECT LOWER(first_name) AS name,
	LOWER(REVERSE(first_name)) AS name_in_reverse
FROM employees;

-- Viết truy vấn để tìm những nhân viên đã gia nhập vào sau ngày 15 của tháng
SELECT 
	employee_id, 
    CONCAT(first_name, ' ', last_name) AS employee,
    hire_date 
FROM employees
WHERE DAY(hire_date) >  15;

-- 18. Viết truy vấn để tìm những quản lý và nhân viên làm trong các phòng ban khác nhau, kết quả sắp xếp theo thứ tự tăng dần của tên người quản lý (tên nhân viên và quản lý kết hợp từ first_name và last_name)
SELECT 
	CONCAT(m.first_name, ' ' ,m.last_name) AS manager, 
    CONCAT(e.first_name, ' ' ,e.last_name) AS employee,
    m.department_id AS mgr_dept,
    e.department_id AS emp_dept
FROM employees e
JOIN employees m
ON m.manager_id = e.employee_id
WHERE m.department_id != e.department_id
ORDER BY manager ASC;