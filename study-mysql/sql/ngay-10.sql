-- ============================================================
-- NGÀY 10: INNER JOIN - Kết Hợp Bảng
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: INNER JOIN CƠ BẢN
-- ==============================

-- BƯỚC 1: Xem dữ liệu hai bảng riêng
SELECT * FROM san_pham;
SELECT * FROM danh_muc;

-- BƯỚC 2: JOIN hai bảng (chỉ bản ghi khớp cả 2)
SELECT sp.ten, sp.gia, dm.ten AS danh_muc
FROM san_pham sp
INNER JOIN danh_muc dm ON sp.danh_muc_id = dm.id;

-- Viết tắt: JOIN = INNER JOIN
SELECT sp.ten, sp.gia, dm.ten AS danh_muc
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id;

-- BƯỚC 3: Chọn cột từ nhiều bảng
SELECT
    sp.id AS ma_sp,
    dm.ten AS danh_muc,
    sp.ten AS ten_sp,
    sp.gia,
    sp.so_luong
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
ORDER BY dm.ten, sp.ten;

-- BƯỚC 4: JOIN với WHERE
-- Chỉ sản phẩm "Điện tử"
SELECT sp.ten, sp.gia
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE dm.ten = 'Điện tử'
ORDER BY sp.gia DESC;

-- ==============================
-- PHẦN 2: JOIN 3 BẢNG
-- ==============================

-- BƯỚC 5: Đơn hàng + Khách hàng
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    kh.email,
    dh.tong_tien,
    dh.trang_thai,
    dh.ngay_dat
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
ORDER BY dh.ngay_dat DESC;

-- BƯỚC 6: Chi tiết đơn hàng (3 bảng)
SELECT
    dh.id AS ma_don,
    kh.ho_ten AS khach_hang,
    sp.ten AS san_pham,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien
FROM chi_tiet_don_hang ct
JOIN don_hang dh ON ct.don_hang_id = dh.id
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
JOIN san_pham sp ON ct.san_pham_id = sp.id
ORDER BY dh.id, sp.ten;

-- ==============================
-- PHẦN 3: JOIN VỚI GROUP BY
-- ==============================

-- BƯỚC 7: Số đơn hàng và tổng chi tiêu của mỗi khách
SELECT
    kh.ho_ten,
    COUNT(dh.id) AS so_don,
    COALESCE(SUM(dh.tong_tien), 0) AS tong_chi_tieu
FROM khach_hang kh
JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
ORDER BY tong_chi_tieu DESC;

-- BƯỚC 8: Doanh thu theo danh mục sản phẩm
SELECT
    dm.ten AS danh_muc,
    COUNT(DISTINCT ct.don_hang_id) AS so_don,
    SUM(ct.so_luong) AS da_ban,
    SUM(ct.so_luong * ct.don_gia) AS doanh_thu
FROM danh_muc dm
JOIN san_pham sp ON dm.id = sp.danh_muc_id
JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY dm.id, dm.ten
ORDER BY doanh_thu DESC;

-- BƯỚC 9: Chi tiết từng đơn hàng cụ thể
SELECT
    sp.ten AS san_pham,
    dm.ten AS danh_muc,
    ct.so_luong,
    ct.don_gia,
    ct.so_luong * ct.don_gia AS thanh_tien
FROM chi_tiet_don_hang ct
JOIN san_pham sp ON ct.san_pham_id = sp.id
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE ct.don_hang_id = 1;

-- BƯỚC 10: Sản phẩm bán chạy nhất
SELECT
    sp.ten,
    SUM(ct.so_luong) AS da_ban
FROM san_pham sp
JOIN chi_tiet_don_hang ct ON sp.id = ct.san_pham_id
GROUP BY sp.id, sp.ten
ORDER BY da_ban DESC
LIMIT 5;

-- ============================================================
-- BÀI TẬP:
-- 1. Hiển thị tất cả đơn hàng kèm tên khách hàng và số sản phẩm trong đơn
-- 2. Tính tổng giá trị từng đơn hàng dựa trên chi tiết (không dùng tong_tien)
-- 3. Danh mục nào có tổng tồn kho nhiều nhất?
-- 4. Khách hàng nào chi tiêu nhiều nhất, bao nhiêu đơn?
-- ============================================================

-- Giải bài tập
-- 1.
SELECT
    dh.id AS ma_don,
    kh.ho_ten,
    COUNT(ct.id) AS so_san_pham,
    dh.trang_thai
FROM don_hang dh
JOIN khach_hang kh ON dh.khach_hang_id = kh.id
JOIN chi_tiet_don_hang ct ON dh.id = ct.don_hang_id
GROUP BY dh.id, kh.ho_ten, dh.trang_thai;

-- 2.
SELECT
    ct.don_hang_id AS ma_don,
    SUM(ct.so_luong * ct.don_gia) AS tong_tu_chi_tiet
FROM chi_tiet_don_hang ct
GROUP BY ct.don_hang_id;

-- 3.
SELECT dm.ten, SUM(sp.so_luong) AS tong_ton_kho
FROM danh_muc dm
JOIN san_pham sp ON dm.id = sp.danh_muc_id
GROUP BY dm.id, dm.ten
ORDER BY tong_ton_kho DESC LIMIT 1;

-- 4.
SELECT kh.ho_ten, COUNT(dh.id) AS so_don, SUM(dh.tong_tien) AS tong_chi_tieu
FROM khach_hang kh
JOIN don_hang dh ON kh.id = dh.khach_hang_id
GROUP BY kh.id, kh.ho_ten
ORDER BY tong_chi_tieu DESC LIMIT 1;
