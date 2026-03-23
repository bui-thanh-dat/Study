-- ============================================================
-- NGÀY 5: SELECT - Truy Vấn Dữ Liệu Cơ Bản
-- ============================================================

USE hoc_mysql;

-- BƯỚC 1: SELECT tất cả
SELECT * FROM san_pham;
SELECT * FROM khach_hang;
SELECT * FROM danh_muc;

-- BƯỚC 2: Chọn cột cụ thể
SELECT ten, gia FROM san_pham;
SELECT ho_ten, email, dia_chi FROM khach_hang;

-- BƯỚC 3: Đặt tên hiển thị (alias)
SELECT
    ten        AS ten_san_pham,
    gia        AS don_gia,
    so_luong   AS ton_kho
FROM san_pham;

-- Alias cho bảng
SELECT sp.ten, sp.gia
FROM san_pham sp;

-- BƯỚC 4: WHERE - lọc dữ liệu
-- Sản phẩm giá > 1 triệu
SELECT ten, gia FROM san_pham WHERE gia > 1000000;

-- Sản phẩm giá chính xác 250000
SELECT ten, gia FROM san_pham WHERE gia = 250000;

-- Sản phẩm không phải danh mục 1
SELECT ten, danh_muc_id FROM san_pham WHERE danh_muc_id <> 1;

-- BƯỚC 5: AND, OR, NOT
-- Điện tử (dm 1) giá < 30 triệu
SELECT ten, gia FROM san_pham
WHERE danh_muc_id = 1 AND gia < 30000000;

-- Sách hoặc Thực phẩm
SELECT ten, danh_muc_id FROM san_pham
WHERE danh_muc_id = 3 OR danh_muc_id = 4;

-- Không phải điện tử
SELECT ten, danh_muc_id FROM san_pham
WHERE NOT danh_muc_id = 1;

-- BƯỚC 6: ORDER BY - sắp xếp
-- Sắp xếp theo giá tăng dần
SELECT ten, gia FROM san_pham ORDER BY gia ASC;

-- Sắp xếp theo giá giảm dần
SELECT ten, gia FROM san_pham ORDER BY gia DESC;

-- Sắp xếp theo danh mục, rồi theo giá
SELECT ten, danh_muc_id, gia FROM san_pham
ORDER BY danh_muc_id ASC, gia DESC;

-- BƯỚC 7: LIMIT - giới hạn kết quả
-- 5 sản phẩm đầu tiên
SELECT ten, gia FROM san_pham LIMIT 5;

-- 3 sản phẩm đắt nhất
SELECT ten, gia FROM san_pham ORDER BY gia DESC LIMIT 3;

-- Trang 2 (mỗi trang 3 sản phẩm): bỏ qua 3, lấy 3 tiếp theo
SELECT ten, gia FROM san_pham LIMIT 3 OFFSET 3;

-- BƯỚC 8: DISTINCT - loại bỏ trùng lặp
-- Có những danh mục nào đang có sản phẩm?
SELECT DISTINCT danh_muc_id FROM san_pham;

-- Các tỉnh thành của khách hàng
SELECT DISTINCT dia_chi FROM khach_hang;

-- BƯỚC 9: Tính toán trong SELECT
-- Giá sau khi giảm 10%
SELECT ten, gia, gia * 0.9 AS gia_khuyen_mai FROM san_pham;

-- Giá trị tồn kho
SELECT ten, gia, so_luong, gia * so_luong AS gia_tri_ton_kho
FROM san_pham
ORDER BY gia_tri_ton_kho DESC;

-- BƯỚC 10: Kết hợp nhiều mệnh đề
SELECT
    ten AS san_pham,
    gia AS don_gia,
    so_luong AS ton_kho,
    gia * so_luong AS gia_tri
FROM san_pham
WHERE danh_muc_id = 1
  AND so_luong > 0
ORDER BY gia DESC
LIMIT 3;

-- ============================================================
-- BÀI TẬP:
-- 1. Lấy 5 sản phẩm rẻ nhất (chỉ hiện tên và giá)
-- 2. Tìm khách hàng ở TP.HCM hoặc Hà Nội
-- 3. Hiển thị sản phẩm có tồn kho > 100, sắp xếp theo số lượng giảm dần
-- 4. Tính và hiển thị giá trị hàng tồn kho của từng sản phẩm
-- ============================================================

-- Giải bài tập
-- 1.
SELECT ten, gia FROM san_pham ORDER BY gia ASC LIMIT 5;

-- 2.
SELECT ho_ten, dia_chi FROM khach_hang
WHERE dia_chi = 'TP.HCM' OR dia_chi = 'Hà Nội';

-- 3.
SELECT ten, so_luong FROM san_pham
WHERE so_luong > 100
ORDER BY so_luong DESC;

-- 4.
SELECT ten, gia, so_luong, gia * so_luong AS gia_tri_ton_kho
FROM san_pham
ORDER BY gia_tri_ton_kho DESC;
