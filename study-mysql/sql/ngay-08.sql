-- ============================================================
-- NGÀY 8: Hàm Tổng Hợp - COUNT, SUM, AVG, MAX, MIN
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: COUNT
-- ==============================

-- BƯỚC 1: Đếm tất cả bản ghi
SELECT COUNT(*) AS tong_san_pham FROM san_pham;
SELECT COUNT(*) AS tong_khach_hang FROM khach_hang;
SELECT COUNT(*) AS tong_don_hang FROM don_hang;

-- BƯỚC 2: Đếm bản ghi không NULL
-- COUNT(*) đếm cả NULL, COUNT(cot) bỏ qua NULL
SELECT
    COUNT(*) AS tong_tat_ca,
    COUNT(so_dien_thoai) AS co_sdt,
    COUNT(*) - COUNT(so_dien_thoai) AS chua_co_sdt
FROM khach_hang;

-- BƯỚC 3: Đếm giá trị duy nhất
SELECT COUNT(DISTINCT danh_muc_id) AS so_danh_muc_co_sp
FROM san_pham;

SELECT COUNT(DISTINCT dia_chi) AS so_tinh_thanh
FROM khach_hang;

-- ==============================
-- PHẦN 2: SUM
-- ==============================

-- BƯỚC 4: Tổng cơ bản
SELECT SUM(so_luong) AS tong_ton_kho FROM san_pham;
SELECT SUM(tong_tien) AS tong_doanh_thu FROM don_hang;

-- BƯỚC 5: Tổng giá trị (kết hợp tính toán)
SELECT SUM(gia * so_luong) AS tong_gia_tri_kho FROM san_pham;

-- BƯỚC 6: SUM với điều kiện
SELECT SUM(so_luong) AS ton_kho_dien_tu
FROM san_pham WHERE danh_muc_id = 1;

-- ==============================
-- PHẦN 3: AVG
-- ==============================

-- BƯỚC 7: Giá trung bình
SELECT AVG(gia) AS gia_trung_binh FROM san_pham;
SELECT ROUND(AVG(gia), 0) AS gia_tb_lam_tron FROM san_pham;

-- Giá trung bình từng danh mục
SELECT danh_muc_id, ROUND(AVG(gia), 0) AS gia_tb
FROM san_pham
GROUP BY danh_muc_id;

-- ==============================
-- PHẦN 4: MAX và MIN
-- ==============================

-- BƯỚC 8: Giá cao nhất và thấp nhất
SELECT
    MAX(gia) AS dat_nhat,
    MIN(gia) AS re_nhat,
    MAX(gia) - MIN(gia) AS khoang_gia
FROM san_pham;

-- Ngày nhập gần nhất
SELECT
    MAX(ngay_nhap) AS nhap_moi_nhat,
    MIN(ngay_nhap) AS nhap_cu_nhat
FROM san_pham;

-- ==============================
-- PHẦN 5: KẾT HỢP NHIỀU HÀM
-- ==============================

-- BƯỚC 9: Báo cáo tổng quan
SELECT
    COUNT(*) AS tong_san_pham,
    COUNT(DISTINCT danh_muc_id) AS so_danh_muc,
    SUM(so_luong) AS tong_ton_kho,
    SUM(gia * so_luong) AS tong_gia_tri,
    ROUND(AVG(gia), 0) AS gia_trung_binh,
    MAX(gia) AS dat_nhat,
    MIN(gia) AS re_nhat
FROM san_pham;

-- BƯỚC 10: Hàm tổng hợp với WHERE
-- Chỉ thống kê sản phẩm còn hàng
SELECT
    COUNT(*) AS so_san_pham_con_hang,
    SUM(so_luong) AS tong_ton_kho,
    ROUND(AVG(gia), 0) AS gia_tb
FROM san_pham
WHERE so_luong > 0;

-- ==============================
-- PHẦN 6: THỐNG KÊ THEO NHÓM (preview GROUP BY)
-- ==============================

-- BƯỚC 11: Thống kê theo danh mục
SELECT
    danh_muc_id,
    COUNT(*) AS so_sp,
    SUM(so_luong) AS tong_ton,
    ROUND(AVG(gia), 0) AS gia_tb,
    MAX(gia) AS cao_nhat,
    MIN(gia) AS thap_nhat
FROM san_pham
GROUP BY danh_muc_id
ORDER BY danh_muc_id;

-- BƯỚC 12: Thống kê đơn hàng theo trạng thái
SELECT
    trang_thai,
    COUNT(*) AS so_don,
    SUM(tong_tien) AS tong_tien
FROM don_hang
GROUP BY trang_thai;

-- ============================================================
-- BÀI TẬP:
-- 1. Tổng số đơn hàng và tổng doanh thu đơn hàng "da_giao"
-- 2. Giá trung bình sản phẩm từng danh mục (làm tròn 0 chữ số thập phân)
-- 3. Sản phẩm có tồn kho cao nhất và thấp nhất là bao nhiêu?
-- 4. Tính tổng giá trị hàng tồn kho chỉ của sản phẩm điện tử (danh_muc_id=1)
-- ============================================================

-- Giải bài tập
-- 1.
SELECT COUNT(*) AS so_don, SUM(tong_tien) AS doanh_thu
FROM don_hang WHERE trang_thai = 'da_giao';

-- 2. (Đã làm ở BƯỚC 7)

-- 3.
SELECT MAX(so_luong) AS nhieu_nhat, MIN(so_luong) AS it_nhat FROM san_pham;

-- 4.
SELECT SUM(gia * so_luong) AS gia_tri_dien_tu
FROM san_pham WHERE danh_muc_id = 1;
