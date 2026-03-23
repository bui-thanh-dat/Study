-- ============================================================
-- NGÀY 2: Kiểu Dữ Liệu - Thực hành nhận biết
-- ============================================================

-- BƯỚC 1: Thực hành kiểu số
SELECT 42 AS so_nguyen;
SELECT 3.14 AS so_thap_phan;
SELECT -100 AS so_am;

-- Xem giới hạn của các kiểu số
SELECT
    127 AS max_tinyint,
    32767 AS max_smallint,
    2147483647 AS max_int,
    9223372036854775807 AS max_bigint;

-- BƯỚC 2: Thực hành kiểu chuỗi
SELECT 'Xin chào' AS chuoi_don;
SELECT "MySQL" AS chuoi_kep;
SELECT LENGTH('MySQL') AS so_ky_tu;
SELECT CHAR_LENGTH('Tiếng Việt') AS so_ky_tu_utf8;

-- BƯỚC 3: Thực hành kiểu ngày
SELECT '2024-03-15' AS ngay_thang;
SELECT DATE('2024-03-15 14:30:00') AS chi_ngay;
SELECT TIME('2024-03-15 14:30:00') AS chi_gio;

-- BƯỚC 4: Chuyển đổi kiểu dữ liệu
SELECT CAST('123' AS UNSIGNED) AS chuoi_thanh_so;
SELECT CAST(3.99 AS UNSIGNED) AS thap_phan_thanh_nguyen;  -- làm tròn xuống
SELECT CAST(3.14 AS CHAR) AS so_thanh_chuoi;
SELECT CAST('2024-03-15' AS DATE) AS chuoi_thanh_ngay;

-- BƯỚC 5: Kiểm tra kiểu dữ liệu
SELECT TYPEOF(42);        -- MySQL không có TYPEOF, dùng cách khác
SELECT '42' + 0;          -- '42' tự chuyển thành số 42
SELECT '42abc' + 0;       -- chỉ lấy phần số đầu: 42
SELECT 'abc' + 0;         -- không có số: 0

-- ============================================================
-- BÀI TẬP:
-- 1. Tính: số byte cần để lưu VARCHAR(255)?
-- 2. '2024-12-31' - '2024-01-01' = bao nhiêu ngày?
-- 3. CAST('3.99' AS DECIMAL(5,2)) ra kết quả gì?
-- ============================================================

-- Giải bài tập
SELECT DATEDIFF('2024-12-31', '2024-01-01') AS so_ngay;
SELECT CAST('3.99' AS DECIMAL(5,2)) AS ket_qua;
