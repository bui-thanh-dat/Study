USE hr;

/* ------------------------------------------------------------
   BÀI 1: Lương, tổng lương phòng, tỷ trọng (%) làm tròn 2 số
   Ý chính: SUM(...) OVER (PARTITION BY ...) KHÔNG có ORDER BY
            → tổng của cả nhóm, giữ nguyên số dòng.
   ------------------------------------------------------------ */
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name)              AS full_name,
    e.department_id,
    e.salary,
    SUM(e.salary) OVER (PARTITION BY e.department_id)   AS dept_total_salary,
    ROUND(
        e.salary * 100.0
        / SUM(e.salary) OVER (PARTITION BY e.department_id)
    , 2)                                                AS salary_pct
FROM employees e
ORDER BY e.department_id, salary_pct DESC;


/* ------------------------------------------------------------
   BÀI 2: Tổng lương lũy kế theo thứ tự tuyển dụng
   Ý chính: thêm ORDER BY vào OVER() → SUM biến thành running total.
   Lưu ý: thêm employee_id để phá thế hòa (cùng ngày vào làm)
          và dùng ROWS thay vì RANGE mặc định để tránh gộp dòng trùng.
   ------------------------------------------------------------ */
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.hire_date,
    e.salary,
    SUM(e.salary) OVER (
        ORDER BY e.hire_date, e.employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                                       AS running_total_salary
FROM employees e
ORDER BY e.hire_date, e.employee_id;


/* ------------------------------------------------------------
   BÀI 3: Lương người tuyển ngay TRƯỚC và ngay SAU, cùng phòng
   Ý chính: LAG/LEAD + PARTITION BY department_id (reset mỗi phòng).
   ------------------------------------------------------------ */
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.department_id,
    e.hire_date,
    e.salary,
    LAG(e.salary) OVER w                    AS prev_hire_salary,
    LEAD(e.salary) OVER w                   AS next_hire_salary
FROM employees e
WINDOW w AS (
    PARTITION BY e.department_id
    ORDER BY e.hire_date, e.employee_id
)
ORDER BY e.department_id, e.hire_date;


/* ------------------------------------------------------------
   BÀI 4: Trung bình trượt 3 người, sắp theo employee_id
   Ý chính: frame ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            = dòng hiện tại + 2 dòng trước = 3 dòng.
   (Muốn trượt "ở giữa" thì đổi thành 1 PRECEDING AND 1 FOLLOWING)
   ------------------------------------------------------------ */
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.salary,
    ROUND(
        AVG(e.salary) OVER (
            ORDER BY e.employee_id
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        )
    , 2)                                    AS moving_avg_3
FROM employees e
ORDER BY e.employee_id;


/* ------------------------------------------------------------
   BÀI 5: Tên người lương CAO NHẤT / THẤP NHẤT của phòng
   Ý chính: frame mặc định là UNBOUNDED PRECEDING → CURRENT ROW,
            nên LAST_VALUE sẽ trả về chính dòng hiện tại (bẫy kinh điển).
            Phải mở frame ra UNBOUNDED FOLLOWING.
   ------------------------------------------------------------ */
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name)  AS full_name,
    e.department_id,
    e.salary,
    FIRST_VALUE(CONCAT(e.first_name, ' ', e.last_name)) OVER w AS top_paid_name,
    LAST_VALUE(CONCAT(e.first_name, ' ', e.last_name))  OVER w AS lowest_paid_name
FROM employees e
WINDOW w AS (
    PARTITION BY e.department_id
    ORDER BY e.salary DESC, e.employee_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
ORDER BY e.department_id, e.salary DESC;


/* ------------------------------------------------------------
   BÀI 6: Số nhân viên tuyển mỗi năm + chênh lệch so với năm trước
   Ý chính: GROUP BY gom dòng trước → dùng CTE làm lớp 1,
            lớp 2 mới chạy LAG trên kết quả đã gom.
   ------------------------------------------------------------ */
WITH hires_per_year AS (
    SELECT
        YEAR(e.hire_date) AS hire_year,
        COUNT(*)          AS total_hires
    FROM employees e
    GROUP BY YEAR(e.hire_date)
)
SELECT
    h.hire_year,
    h.total_hires,
    LAG(h.total_hires) OVER (ORDER BY h.hire_year)               AS prev_year_hires,
    h.total_hires
        - LAG(h.total_hires) OVER (ORDER BY h.hire_year)         AS diff_vs_prev_year
FROM hires_per_year h
ORDER BY h.hire_year;
