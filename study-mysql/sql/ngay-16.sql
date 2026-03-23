-- ============================================================
-- NGÀY 16: VIEW - Bảng Ảo
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: TẠO VIEW CƠ BẢN
-- ==============================

-- BƯỚC 1: Bài toán - query phức tạp phải viết lại nhiều lần
-- Thay vì viết lại query này mỗi lần:
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    kh.email,
    dh.ngay_dat,
    dh.tong_tien,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id;

-- BƯỚC 2: Lưu thành VIEW
CREATE OR REPLACE VIEW v_don_hang_chi_tiet AS
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    kh.email,
    dh.ngay_dat,
    dh.tong_tien,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id;

-- BƯỚC 3: Dùng view như bảng thường
SELECT * FROM v_don_hang_chi_tiet;

-- Lọc trên view
SELECT * FROM v_don_hang_chi_tiet WHERE trang_thai = 'da_giao';

-- Sắp xếp
SELECT * FROM v_don_hang_chi_tiet ORDER BY tong_tien DESC;

-- ==============================
-- PHẦN 2: TẠO NHIỀU VIEW HỮU ÍCH
-- ==============================

-- BƯỚC 4: View thống kê danh mục
CREATE OR REPLACE VIEW v_thong_ke_danh_muc AS
SELECT
    dm.id,
    dm.ten AS danh_muc,
    COUNT(sp.id) AS so_san_pham,
    COALESCE(SUM(sp.so_luong), 0) AS tong_ton_kho,
    COALESCE(ROUND(AVG(sp.gia), 0), 0) AS gia_trung_binh,
    COALESCE(SUM(sp.gia * sp.so_luong), 0) AS gia_tri_ton_kho
FROM danh_muc dm
LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten;

SELECT * FROM v_thong_ke_danh_muc ORDER BY gia_tri_ton_kho DESC;
SELECT * FROM v_thong_ke_danh_muc WHERE so_san_pham = 0;

-- BƯỚC 5: View khách hàng VIP
CREATE OR REPLACE VIEW v_khach_hang_vip AS
SELECT
    kh.id,
    kh.ho_ten,
    kh.email,
    COUNT(dh.id) AS so_don,
    SUM(dh.tong_tien) AS tong_chi_tieu,
    MAX(dh.ngay_dat) AS lan_mua_cuoi,
    CASE
        WHEN SUM(dh.tong_tien) >= 50000000 THEN 'VIP Gold'
        WHEN SUM(dh.tong_tien) >= 20000000 THEN 'VIP Silver'
        ELSE 'Thường'
    END AS hang_khach
FROM khach_hang kh
JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten, kh.email;

SELECT * FROM v_khach_hang_vip ORDER BY tong_chi_tieu DESC;

-- BƯỚC 6: View chi tiết đơn hàng đầy đủ
CREATE OR REPLACE VIEW v_chi_tiet_don_hang AS
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    dm.ten AS danh_muc,
    sp.ten AS san_pham,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien,
    dh.trang_thai,
    dh.ngay_dat
FROM chi_tiet_don_hang ct
JOIN don_hang dh ON ct.don_hang_id = dh.id
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
JOIN san_pham sp ON ct.san_pham_id = sp.id
JOIN danh_muc dm ON sp.danh_muc_id = dm.id;

SELECT * FROM v_chi_tiet_don_hang ORDER BY ma_don, san_pham;

-- ==============================
-- PHẦN 3: TRUY VẤN TRÊN VIEW
-- ==============================

-- BƯỚC 7: Dùng view trong query phức tạp
-- Đơn hàng của từng khách theo danh mục
SELECT khach_hang, danh_muc, SUM(thanh_tien) AS tong
FROM v_chi_tiet_don_hang
GROUP BY khach_hang, danh_muc
ORDER BY khach_hang, tong DESC;

-- Danh mục bán chạy
SELECT danh_muc, SUM(so_luong) AS da_ban, SUM(thanh_tien) AS doanh_thu
FROM v_chi_tiet_don_hang
GROUP BY danh_muc
ORDER BY da_ban DESC;

-- ==============================
-- PHẦN 4: QUẢN LÝ VIEW
-- ==============================

-- BƯỚC 8: Xem danh sách view
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Xem định nghĩa view
SHOW CREATE VIEW v_don_hang_chi_tiet\G

-- BƯỚC 9: Sửa view
CREATE OR REPLACE VIEW v_don_hang_chi_tiet AS
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    kh.so_dien_thoai,    -- thêm cột mới
    dh.ngay_dat,
    dh.tong_tien,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id;

SELECT * FROM v_don_hang_chi_tiet;

-- BƯỚC 10: Xóa view
DROP VIEW IF EXISTS v_thong_ke_danh_muc;

-- Tạo lại
CREATE VIEW v_thong_ke_danh_muc AS
SELECT dm.ten AS danh_muc, COUNT(sp.id) AS so_san_pham
FROM danh_muc dm LEFT JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten;

SELECT * FROM v_thong_ke_danh_muc;

-- ============================================================
-- BÀI TẬP:
-- 1. Tạo view v_san_pham_con_hang chỉ hiển thị sản phẩm có so_luong > 0
-- 2. Tạo view v_bao_cao_thang tổng hợp doanh thu theo tháng/năm
-- 3. Dùng v_khach_hang_vip để tìm khách chi tiêu nhiều nhất
-- 4. Tạo view v_san_pham_day_du (tên, danh mục, giá, tồn kho, số lần bán)
-- ============================================================

-- Giải bài tập
-- 1.
CREATE OR REPLACE VIEW v_san_pham_con_hang AS
SELECT sp.ten, dm.ten AS danh_muc, sp.gia, sp.so_luong
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE sp.so_luong > 0
ORDER BY sp.ten;

SELECT * FROM v_san_pham_con_hang;

-- 2.
CREATE OR REPLACE VIEW v_bao_cao_thang AS
SELECT
    YEAR(ngay_dat) AS nam,
    MONTH(ngay_dat) AS thang,
    COUNT(*) AS so_don,
    SUM(tong_tien) AS doanh_thu
FROM don_hang
GROUP BY YEAR(ngay_dat), MONTH(ngay_dat)
ORDER BY nam DESC, thang DESC;

SELECT * FROM v_bao_cao_thang;

-- 3.
SELECT * FROM v_khach_hang_vip ORDER BY tong_chi_tieu DESC LIMIT 1;
