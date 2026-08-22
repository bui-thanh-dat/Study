-- 1. Hiện nhân viên kèm số năm thâm niên, sắp xếp giảm dần.
SELECT 
	employee_id,
    first_name,
    department_id,
    YEAR(hire_date) AS nam_vao,
    TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) AS so_nam_tham_nien
FROM employees;

-- Đếm số nhân viên tuyển theo từng tháng trong năm (gộp mọi năm lại, ra 12 dòng trở xuống).
SELECT 
	MONTH(hire_date) AS thang, 
    DATE_FORMAT(hire_date, '%M' ) AS ten_thang,
    COUNT(*) AS so_nguoi
FROM employees
GROUP BY MONTH(hire_date),DATE_FORMAT(hire_date, '%M' )
HAVING COUNT(*) >= 3
ORDER BY thang;

--  Tạo mã nhân viên dạng EMP-0100 từ employee_id bằng CONCAT + LPAD .

SELECT 
	employee_id,
    first_name,
    department_id,
    CONCAT_WS('-','EMP',LPAD(employee_id,3,'0') )AS Ma_NV
FROM employees;

-- 4. Hiện email viết thường và độ dài của first_name .
SELECT
	employee_id,
    first_name,
    LOWER(email) AS email_viet_thuong,
    LENGTH(first_name) AS do_dai_ten
FROM employees;

-- 5. So sánh COUNT(*) , COUNT(commission_pct) , COUNT(manager_id) trên bảng employees . Giải thích vì sao khác nhau
SELECT COUNT(*) , COUNT(commission_pct) , COUNT(manager_id)
FROM employees;

SELECT first_name, last_name, job_id
FROM employees
WHERE manager_id IS NULL;
	
--  Tìm nhân viên tuyển vào trong khoảng 1997–1998, viết bằng cả hai cách (dùng YEAR() và dùng khoảng ngày).
SELECT 
    YEAR(hire_date) AS nam, 
    COUNT(*) AS so_nguoi
FROM employees
-- WHERE YEAR(hire_date) = 1997
WHERE hire_date >= '1997-01-01' AND hire_date < '1998-01-01'
GROUP BY YEAR(hire_date)
ORDER BY nam;

