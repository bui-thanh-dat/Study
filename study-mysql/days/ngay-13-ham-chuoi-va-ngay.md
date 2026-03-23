# Ngày 13: Hàm Chuỗi và Hàm Ngày Tháng

## Hàm Chuỗi (String Functions)

### Xử lý chữ hoa/thường
```sql
SELECT UPPER('hello world');        -- HELLO WORLD
SELECT LOWER('HELLO WORLD');        -- hello world
SELECT UPPER(ho_ten) FROM khach_hang;
```

### Độ dài và cắt chuỗi
```sql
SELECT LENGTH('MySQL');             -- 5 (byte)
SELECT CHAR_LENGTH('MySQL');        -- 5 (ký tự, đúng với UTF-8)
SELECT CHAR_LENGTH(ho_ten) FROM khach_hang;

-- Cắt chuỗi
SELECT LEFT('Hello World', 5);      -- Hello
SELECT RIGHT('Hello World', 5);     -- World
SELECT SUBSTRING('Hello World', 7, 5);  -- World  (vị trí 7, lấy 5 ký tự)
SELECT MID('Hello World', 7, 5);    -- World (tương tự SUBSTRING)
```

### Loại bỏ khoảng trắng
```sql
SELECT TRIM('  hello  ');           -- 'hello'
SELECT LTRIM('  hello  ');          -- 'hello  '
SELECT RTRIM('  hello  ');          -- '  hello'
```

### Nối chuỗi
```sql
SELECT CONCAT('Xin chào', ' ', 'World');         -- Xin chào World
SELECT CONCAT(ho_ten, ' (', email, ')') FROM khach_hang;

-- CONCAT_WS: nối với dấu phân cách
SELECT CONCAT_WS(', ', 'Hà Nội', 'TP.HCM', 'Đà Nẵng');  -- Hà Nội, TP.HCM, Đà Nẵng
```

### Tìm và thay thế
```sql
SELECT LOCATE('World', 'Hello World');      -- 7 (vị trí bắt đầu)
SELECT INSTR('Hello World', 'World');       -- 7

SELECT REPLACE('Hello World', 'World', 'MySQL');  -- Hello MySQL
UPDATE san_pham SET ten = REPLACE(ten, 'iphone', 'iPhone');
```

### Định dạng chuỗi
```sql
SELECT LPAD('5', 3, '0');    -- 005 (thêm '0' vào trái, tổng 3 ký tự)
SELECT RPAD('5', 3, '0');    -- 500 (thêm '0' vào phải)

SELECT REPEAT('ha', 3);      -- hahaha

SELECT REVERSE('MySQL');     -- LQSyM
```

---

## Hàm Ngày Tháng (Date Functions)

### Lấy thông tin hiện tại
```sql
SELECT NOW();              -- 2024-03-15 14:30:00  (ngày + giờ)
SELECT CURDATE();          -- 2024-03-15            (chỉ ngày)
SELECT CURTIME();          -- 14:30:00              (chỉ giờ)
SELECT CURRENT_TIMESTAMP;  -- tương tự NOW()
```

### Trích xuất thành phần ngày
```sql
SELECT YEAR('2024-03-15');         -- 2024
SELECT MONTH('2024-03-15');        -- 3
SELECT DAY('2024-03-15');          -- 15
SELECT DAYOFWEEK('2024-03-15');    -- 6 (1=CN, 2=T2, ..., 7=T7)
SELECT DAYNAME('2024-03-15');      -- Friday
SELECT MONTHNAME('2024-03-15');    -- March
SELECT WEEKOFYEAR('2024-03-15');   -- 11 (tuần thứ mấy trong năm)
SELECT QUARTER('2024-03-15');      -- 1 (quý 1)

-- Áp dụng vào bảng
SELECT ho_ten, YEAR(ngay_sinh) AS nam_sinh FROM khach_hang;
SELECT MONTH(ngay_dat) AS thang, COUNT(*) AS so_don
FROM don_hang GROUP BY thang;
```

### Tính toán với ngày
```sql
-- Cộng/trừ ngày
SELECT DATE_ADD('2024-01-01', INTERVAL 30 DAY);    -- 2024-01-31
SELECT DATE_ADD('2024-01-01', INTERVAL 1 MONTH);   -- 2024-02-01
SELECT DATE_ADD('2024-01-01', INTERVAL 1 YEAR);    -- 2025-01-01

SELECT DATE_SUB('2024-03-15', INTERVAL 7 DAY);     -- 2024-03-08

-- Khoảng cách giữa 2 ngày
SELECT DATEDIFF('2024-12-31', '2024-01-01');       -- 365 ngày
SELECT DATEDIFF(NOW(), ngay_tao) AS so_ngay_tu_tao FROM khach_hang;
```

### Định dạng ngày
```sql
SELECT DATE_FORMAT('2024-03-15', '%d/%m/%Y');          -- 15/03/2024
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s');        -- 15/03/2024 14:30:00
SELECT DATE_FORMAT(ngay_dat, '%d/%m/%Y') AS ngay FROM don_hang;

-- Các ký tự format
-- %Y: năm 4 chữ số    %y: năm 2 chữ số
-- %m: tháng (01-12)   %M: tên tháng (January...)
-- %d: ngày (01-31)    %D: ngày + hậu tố (1st, 2nd...)
-- %H: giờ (00-23)     %h: giờ (01-12)
-- %i: phút (00-59)    %s: giây (00-59)
```

---

## Hàm NULL

```sql
-- IFNULL: thay thế NULL bằng giá trị khác
SELECT IFNULL(so_dien_thoai, 'Chưa cập nhật') AS sdt FROM khach_hang;

-- COALESCE: lấy giá trị đầu tiên không NULL trong danh sách
SELECT COALESCE(so_dien_thoai, email, 'Không có thông tin') AS lien_he
FROM khach_hang;

-- NULLIF: trả về NULL nếu 2 giá trị bằng nhau
SELECT NULLIF(so_luong, 0) FROM san_pham;  -- trả NULL nếu so_luong = 0
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Hiển thị thông tin khách hàng đẹp hơn
SELECT
    CONCAT(ho_ten, ' <', email, '>') AS thong_tin,
    IFNULL(so_dien_thoai, 'Chưa có SĐT') AS sdt,
    UPPER(dia_chi) AS tinh_thanh
FROM khach_hang;

-- 2. Phân tích đơn hàng theo tháng
SELECT
    YEAR(ngay_dat) AS nam,
    MONTH(ngay_dat) AS thang,
    COUNT(*) AS so_don,
    SUM(tong_tien) AS doanh_thu
FROM don_hang
GROUP BY YEAR(ngay_dat), MONTH(ngay_dat)
ORDER BY nam, thang;

-- 3. Sản phẩm nhập trong 30 ngày gần nhất
SELECT ten, gia, ngay_nhap
FROM san_pham
WHERE ngay_nhap >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY ngay_nhap DESC;

-- 4. Khách hàng đã đăng ký hơn 30 ngày trước
SELECT ho_ten, ngay_tao, DATEDIFF(NOW(), ngay_tao) AS so_ngay
FROM khach_hang
WHERE DATEDIFF(NOW(), ngay_tao) > 30;
```

---

## Bài tập thực hành
1. Hiển thị tên sinh viên viết hoa, email viết thường
2. Tính tuổi của sinh viên từ ngày sinh
3. Lấy số tháng từ ngày nhập học đến nay
4. Định dạng ngày tháng theo dạng dd/mm/yyyy

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
