-- ============================================================
-- NGÀY 6: WHERE Nâng Cao - LIKE, IN, BETWEEN, IS NULL
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: LIKE
-- ==============================

-- BƯỚC 1: % = nhiều ký tự bất kỳ

-- Sản phẩm bắt đầu bằng "Laptop"
SELECT ten, gia FROM san_pham WHERE ten LIKE 'Laptop%';

-- Sản phẩm kết thúc bằng "kg"
SELECT ten FROM san_pham WHERE ten LIKE '%kg';

-- Sản phẩm có chữ "Pro" ở đâu đó
SELECT ten, gia FROM san_pham WHERE ten LIKE '%Pro%';

-- Tìm email gmail
SELECT ho_ten, email FROM khach_hang WHERE email LIKE '%@email.com';

-- BƯỚC 2: _ = đúng 1 ký tự
-- Email bắt đầu bằng 2 ký tự bất kỳ, sau đó là ".nguyen"
SELECT ho_ten, email FROM khach_hang WHERE email LIKE '__.nguyen%';

-- BƯỚC 3: NOT LIKE
SELECT ten FROM san_pham WHERE ten NOT LIKE '%Samsung%';

-- ==============================
-- PHẦN 2: IN
-- ==============================

-- BƯỚC 4: IN với số
-- Sản phẩm thuộc danh mục 1, 3, 4
SELECT ten, danh_muc_id FROM san_pham
WHERE danh_muc_id IN (1, 3, 4);

-- Tương đương với:
SELECT ten, danh_muc_id FROM san_pham
WHERE danh_muc_id = 1 OR danh_muc_id = 3 OR danh_muc_id = 4;

-- BƯỚC 5: IN với chuỗi
SELECT ho_ten, dia_chi FROM khach_hang
WHERE dia_chi IN ('Hà Nội', 'TP.HCM', 'Đà Nẵng');

-- BƯỚC 6: NOT IN
SELECT ten, danh_muc_id FROM san_pham
WHERE danh_muc_id NOT IN (1, 2);

-- ==============================
-- PHẦN 3: BETWEEN
-- ==============================

-- BƯỚC 7: BETWEEN với số
-- Sản phẩm giá từ 100k đến 1 triệu
SELECT ten, gia FROM san_pham
WHERE gia BETWEEN 100000 AND 1000000
ORDER BY gia;

-- Tương đương với:
SELECT ten, gia FROM san_pham
WHERE gia >= 100000 AND gia <= 1000000
ORDER BY gia;

-- BƯỚC 8: BETWEEN với ngày
SELECT ten, ngay_nhap FROM san_pham
WHERE ngay_nhap BETWEEN '2024-01-01' AND '2024-01-31';

-- BƯỚC 9: NOT BETWEEN
SELECT ten, gia FROM san_pham
WHERE gia NOT BETWEEN 100000 AND 1000000;

-- ==============================
-- PHẦN 4: IS NULL / IS NOT NULL
-- ==============================

-- BƯỚC 10: Tìm bản ghi NULL
-- Khách hàng chưa có số điện thoại
SELECT ho_ten, email, so_dien_thoai FROM khach_hang
WHERE so_dien_thoai IS NULL;

-- Sản phẩm chưa có ngày nhập
SELECT ten FROM san_pham WHERE ngay_nhap IS NULL;

-- BƯỚC 11: Tìm bản ghi không NULL
SELECT ho_ten, so_dien_thoai FROM khach_hang
WHERE so_dien_thoai IS NOT NULL;

-- BƯỚC 12: Sai cú pháp (sẽ không hoạt động đúng!)
-- ĐỪNG dùng = NULL
-- SELECT * FROM khach_hang WHERE so_dien_thoai = NULL;   -- LUÔN không có kết quả
-- SELECT * FROM khach_hang WHERE so_dien_thoai != NULL;  -- LUÔN không có kết quả

-- ==============================
-- PHẦN 5: KẾT HỢP
-- ==============================

-- BƯỚC 13: Kết hợp nhiều điều kiện
-- Sản phẩm điện tử, giá từ 1 triệu đến 30 triệu, còn hàng
SELECT ten, gia, so_luong
FROM san_pham
WHERE danh_muc_id = 1
  AND gia BETWEEN 1000000 AND 30000000
  AND so_luong > 0
ORDER BY gia;

-- Tìm sản phẩm "Sách" hoặc "Thực phẩm" dưới 200k
SELECT ten, gia, danh_muc_id FROM san_pham
WHERE danh_muc_id IN (3, 4)
  AND gia < 200000;

-- BƯỚC 14: Tìm kiếm thực tế
-- Giả sử user gõ tìm kiếm "phone"
SELECT ten, gia FROM san_pham
WHERE ten LIKE '%phone%' OR ten LIKE '%Phone%';

-- ============================================================
-- BÀI TẬP:
-- 1. Tìm sản phẩm tên có chứa "a" (không phân biệt hoa thường)
-- 2. Tìm khách hàng ở Hà Nội hoặc Đà Nẵng có email (IS NOT NULL)
-- 3. Tìm sản phẩm tồn kho từ 50 đến 200 cái, thuộc danh mục 1 hoặc 2
-- 4. Tìm đơn hàng trạng thái "da_giao" hoặc "dang_giao"
-- ============================================================

-- Giải bài tập
-- 1.
SELECT ten FROM san_pham WHERE ten LIKE '%a%';

-- 2.
SELECT ho_ten, dia_chi, email FROM khach_hang
WHERE dia_chi IN ('Hà Nội', 'Đà Nẵng')
  AND email IS NOT NULL;

-- 3.
SELECT ten, so_luong, danh_muc_id FROM san_pham
WHERE so_luong BETWEEN 50 AND 200
  AND danh_muc_id IN (1, 2);

-- 4.
SELECT id, trang_thai, tong_tien FROM don_hang
WHERE trang_thai IN ('da_giao', 'dang_giao');
