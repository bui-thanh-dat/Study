-- ============================================================
-- NGÀY 9: GROUP BY và HAVING
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: GROUP BY CƠ BẢN
-- ==============================

-- BƯỚC 1: Đếm sản phẩm theo danh mục
SELECT danh_muc_id, COUNT(*) AS so_san_pham
FROM san_pham
GROUP BY danh_muc_id;

-- BƯỚC 2: Tổng tồn kho theo danh mục
SELECT danh_muc_id, SUM(so_luong) AS tong_ton_kho
FROM san_pham
GROUP BY danh_muc_id;

-- BƯỚC 3: Nhiều hàm tổng hợp
SELECT
    danh_muc_id,
    COUNT(*) AS so_sp,
    SUM(so_luong) AS tong_ton,
    ROUND(AVG(gia), 0) AS gia_tb,
    MIN(gia) AS gia_thap,
    MAX(gia) AS gia_cao
FROM san_pham
GROUP BY danh_muc_id
ORDER BY danh_muc_id;

-- BƯỚC 4: GROUP BY chuỗi
SELECT dia_chi, COUNT(*) AS so_khach
FROM khach_hang
GROUP BY dia_chi;

-- BƯỚC 5: GROUP BY với ORDER BY
SELECT danh_muc_id, COUNT(*) AS so_sp
FROM san_pham
GROUP BY danh_muc_id
ORDER BY so_sp DESC;

-- ==============================
-- PHẦN 2: HAVING
-- ==============================

-- BƯỚC 6: WHERE vs HAVING
-- WHERE: lọc TỪNG BẢN GHI trước khi nhóm
-- HAVING: lọc NHÓM sau khi GROUP BY

-- Lỗi! Không dùng WHERE với hàm tổng hợp:
-- SELECT danh_muc_id FROM san_pham WHERE COUNT(*) > 1 GROUP BY danh_muc_id; -- LỖI

-- Đúng: dùng HAVING
SELECT danh_muc_id, COUNT(*) AS so_sp
FROM san_pham
GROUP BY danh_muc_id
HAVING so_sp > 1;

-- BƯỚC 7: HAVING với điều kiện phức tạp
-- Danh mục có giá trung bình > 1 triệu
SELECT danh_muc_id, ROUND(AVG(gia), 0) AS gia_tb
FROM san_pham
GROUP BY danh_muc_id
HAVING gia_tb > 1000000
ORDER BY gia_tb DESC;

-- Danh mục có tổng giá trị tồn kho > 5 triệu
SELECT danh_muc_id, SUM(gia * so_luong) AS gia_tri_kho
FROM san_pham
GROUP BY danh_muc_id
HAVING gia_tri_kho > 5000000;

-- ==============================
-- PHẦN 3: WHERE + GROUP BY + HAVING
-- ==============================

-- BƯỚC 8: Kết hợp cả 3
-- WHERE lọc trước → nhóm → HAVING lọc sau
SELECT danh_muc_id, COUNT(*) AS so_sp_con_hang
FROM san_pham
WHERE so_luong > 0          -- chỉ xét sp còn hàng
GROUP BY danh_muc_id
HAVING so_sp_con_hang >= 2  -- nhóm phải có >= 2 sp
ORDER BY so_sp_con_hang DESC;

-- BƯỚC 9: GROUP BY theo nhiều cột
SELECT trang_thai, YEAR(ngay_dat) AS nam, COUNT(*) AS so_don
FROM don_hang
GROUP BY trang_thai, YEAR(ngay_dat)
ORDER BY nam, trang_thai;

-- ==============================
-- PHẦN 4: GROUP_CONCAT
-- ==============================

-- BƯỚC 10: Nối tên sản phẩm trong cùng danh mục
SELECT
    danh_muc_id,
    COUNT(*) AS so_sp,
    GROUP_CONCAT(ten ORDER BY ten SEPARATOR ' | ') AS danh_sach
FROM san_pham
GROUP BY danh_muc_id;

-- ==============================
-- PHẦN 5: ROLLUP - Tổng cộng
-- ==============================

-- BƯỚC 11: WITH ROLLUP - thêm dòng tổng
SELECT
    danh_muc_id,
    SUM(so_luong) AS tong_ton_kho
FROM san_pham
GROUP BY danh_muc_id WITH ROLLUP;
-- Dòng cuối có danh_muc_id = NULL là tổng cộng

-- ============================================================
-- BÀI TẬP:
-- 1. Đếm số khách hàng theo tỉnh thành, hiển thị tỉnh có >= 2 khách
-- 2. Thống kê đơn hàng: số đơn và tổng tiền theo trạng thái
-- 3. Tìm danh mục có sản phẩm giá cao nhất > 5 triệu
-- 4. GROUP_CONCAT: liệt kê tên khách hàng theo tỉnh thành
-- ============================================================

-- Giải bài tập
-- 1.
SELECT
    COALESCE(dia_chi, 'Chưa cập nhật') AS tinh_thanh,
    COUNT(*) AS so_khach
FROM khach_hang
GROUP BY dia_chi
HAVING so_khach >= 1
ORDER BY so_khach DESC;

-- 2.
SELECT
    trang_thai,
    COUNT(*) AS so_don,
    SUM(tong_tien) AS tong_tien
FROM don_hang
GROUP BY trang_thai;

-- 3.
SELECT danh_muc_id, MAX(gia) AS gia_cao_nhat
FROM san_pham
GROUP BY danh_muc_id
HAVING gia_cao_nhat > 5000000;

-- 4.
SELECT
    COALESCE(dia_chi, 'Chưa cập nhật') AS tinh,
    GROUP_CONCAT(ho_ten ORDER BY ho_ten SEPARATOR ', ') AS danh_sach_khach
FROM khach_hang
GROUP BY dia_chi;
