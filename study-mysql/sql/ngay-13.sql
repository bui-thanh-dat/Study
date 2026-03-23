-- ============================================================
-- NGÀY 13: Hàm Chuỗi và Hàm Ngày Tháng
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: HÀM CHUỖI
-- ==============================

-- BƯỚC 1: Chữ hoa / chữ thường
SELECT UPPER('hello mysql');         -- HELLO MYSQL
SELECT LOWER('HELLO MYSQL');         -- hello mysql
SELECT UPPER(ho_ten) AS ten_viet_hoa FROM khach_hang;

-- BƯỚC 2: Độ dài chuỗi
SELECT LENGTH('MySQL');              -- 5 (bytes)
SELECT CHAR_LENGTH('Tiếng Việt');   -- 10 (ký tự)
SELECT CHAR_LENGTH(ho_ten) AS do_dai FROM khach_hang;

-- BƯỚC 3: Cắt chuỗi
SELECT LEFT('Nguyen Van An', 6);           -- Nguyen
SELECT RIGHT('Nguyen Van An', 2);          -- An
SELECT SUBSTRING('MySQL Database', 7, 8);  -- Database
SELECT MID('MySQL Database', 1, 5);        -- MySQL

-- Lấy họ (phần trước dấu cách đầu tiên)
SELECT
    ho_ten,
    LEFT(ho_ten, LOCATE(' ', ho_ten) - 1) AS ho
FROM khach_hang;

-- BƯỚC 4: Xóa khoảng trắng
SELECT TRIM('  hello  ');            -- 'hello'
SELECT LTRIM('  hello  ');           -- 'hello  '
SELECT RTRIM('  hello  ');           -- '  hello'

-- BƯỚC 5: Nối chuỗi
SELECT CONCAT('Xin chào', ' ', 'thế giới');
SELECT CONCAT(ho_ten, ' <', email, '>') AS thong_tin FROM khach_hang;

-- CONCAT_WS: nối với separator
SELECT CONCAT_WS(' | ', ho_ten, email, IFNULL(so_dien_thoai, 'N/A')) AS lien_he
FROM khach_hang;

-- BƯỚC 6: Tìm và thay thế
SELECT LOCATE('van', LOWER('Nguyen Van An'));    -- 8 (vị trí)
SELECT REPLACE('Xin chào World', 'World', 'MySQL');  -- Xin chào MySQL

-- Chuẩn hóa email (xóa khoảng trắng, viết thường)
SELECT LOWER(TRIM('  An.Nguyen@Email.COM  ')) AS email_chuan;

-- BƯỚC 7: Định dạng khác
SELECT LPAD('5', 3, '0');     -- 005
SELECT RPAD('A', 5, '-');     -- A----
SELECT REPEAT('*', 5);        -- *****
SELECT REVERSE('MySQL');      -- LQSyM

-- BƯỚC 8: Ứng dụng thực tế
-- Tạo mã khách hàng: KH + id 4 chữ số
SELECT CONCAT('KH', LPAD(id, 4, '0')) AS ma_kh, ho_ten
FROM khach_hang;

-- ==============================
-- PHẦN 2: HÀM NGÀY THÁNG
-- ==============================

-- BƯỚC 9: Ngày giờ hiện tại
SELECT NOW();              -- ngày + giờ
SELECT CURDATE();          -- chỉ ngày
SELECT CURTIME();          -- chỉ giờ

-- BƯỚC 10: Trích xuất thành phần
SELECT YEAR('2024-03-15');         -- 2024
SELECT MONTH('2024-03-15');        -- 3
SELECT DAY('2024-03-15');          -- 15
SELECT DAYNAME('2024-03-15');      -- Friday
SELECT MONTHNAME('2024-03-15');    -- March
SELECT QUARTER('2024-03-15');      -- 1

-- Từ bảng thực tế
SELECT
    ngay_dat,
    YEAR(ngay_dat) AS nam,
    MONTH(ngay_dat) AS thang,
    DAY(ngay_dat) AS ngay
FROM don_hang;

-- BƯỚC 11: Tính toán ngày
-- Cộng thêm ngày
SELECT DATE_ADD('2024-01-01', INTERVAL 30 DAY);    -- 2024-01-31
SELECT DATE_ADD('2024-01-01', INTERVAL 3 MONTH);   -- 2024-04-01

-- Trừ ngày
SELECT DATE_SUB(CURDATE(), INTERVAL 7 DAY) AS 7_ngay_truoc;
SELECT DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AS 1_nam_truoc;

-- Khoảng cách
SELECT DATEDIFF(CURDATE(), '2024-01-01') AS so_ngay_da_qua;

-- Bao nhiêu ngày từ khi tạo tài khoản
SELECT
    ho_ten,
    ngay_tao,
    DATEDIFF(NOW(), ngay_tao) AS so_ngay_da_tao
FROM khach_hang
ORDER BY so_ngay_da_tao DESC;

-- BƯỚC 12: Định dạng ngày tháng
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y') AS ngay_vn;
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i') AS ngay_gio_vn;
SELECT DATE_FORMAT(NOW(), 'Hôm nay là %W, ngày %d tháng %m năm %Y') AS thong_tin;

-- Định dạng ngày trong bảng
SELECT
    ho_ten,
    DATE_FORMAT(ngay_tao, '%d/%m/%Y') AS ngay_tham_gia
FROM khach_hang;

-- BƯỚC 13: Hàm NULL
SELECT IFNULL(NULL, 'Giá trị mặc định');
SELECT IFNULL(so_dien_thoai, 'Chưa cập nhật') AS sdt FROM khach_hang;

SELECT COALESCE(NULL, NULL, 'Giá trị thứ 3');
SELECT COALESCE(so_dien_thoai, email, 'Không có liên hệ') AS lien_he
FROM khach_hang;

-- BƯỚC 14: Tổng hợp thực tế
SELECT
    CONCAT('KH', LPAD(id, 4, '0')) AS ma_kh,
    ho_ten,
    IFNULL(so_dien_thoai, 'N/A') AS sdt,
    DATE_FORMAT(ngay_tao, '%d/%m/%Y') AS ngay_tham_gia,
    DATEDIFF(NOW(), ngay_tao) AS so_ngay
FROM khach_hang
ORDER BY ngay_tao;

-- ============================================================
-- BÀI TẬP:
-- 1. Tạo cột "ten_viet_tat": lấy 2 ký tự đầu của từng từ trong tên
-- 2. Lấy đơn hàng trong tháng 1 năm 2024
-- 3. Tính số ngày từ ngày nhập đến nay của từng sản phẩm
-- 4. Hiển thị email dạng: "***@gmail.com" (ẩn phần trước @)
-- ============================================================

-- Giải bài tập
-- 2.
SELECT * FROM don_hang
WHERE YEAR(ngay_dat) = 2024 AND MONTH(ngay_dat) = 1;

-- 3.
SELECT ten, ngay_nhap, DATEDIFF(CURDATE(), ngay_nhap) AS so_ngay_co
FROM san_pham WHERE ngay_nhap IS NOT NULL;

-- 4.
SELECT
    ho_ten,
    CONCAT('***', SUBSTRING(email, LOCATE('@', email))) AS email_an
FROM khach_hang;
