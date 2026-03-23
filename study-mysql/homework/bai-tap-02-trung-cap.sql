-- ============================================================
-- BÀI TẬP 02: TRUNG CẤP
-- Chủ đề: Quản lý nhà hàng (tiếp theo)
-- Kiến thức: Aggregate, GROUP BY, HAVING, JOIN, Subquery, CASE WHEN
-- ============================================================
-- Yêu cầu: Đã chạy SETUP ở bai-tap-01-co-ban.sql trước
-- ============================================================

USE nha_hang;

-- ============================================================
-- BÀI TẬP
-- ============================================================

-- BÀI 6: Hàm tổng hợp
-- -------------------------------------------------------

-- 6.1 Đếm tổng số món ăn đang còn bán
-- Viết SQL ở đây:


-- 6.2 Tính giá trung bình, giá thấp nhất và cao nhất của toàn bộ món ăn
-- Viết SQL ở đây:


-- 6.3 Tính tổng tiền của hóa đơn số 4
--     (tổng = SUM(so_luong * don_gia) từ chi_tiet_hoa_don)
-- Viết SQL ở đây:


-- 6.4 Đếm số khách hàng có điểm tích lũy > 0
-- Viết SQL ở đây:


-- BÀI 7: GROUP BY và HAVING
-- -------------------------------------------------------

-- 7.1 Thống kê số món ăn theo từng danh mục (hiển thị danh_muc_id và số lượng)
-- Viết SQL ở đây:


-- 7.2 Tính tổng tiền từng hóa đơn (hoa_don_id, tong_tien)
--     Sắp xếp tổng tiền giảm dần
-- Viết SQL ở đây:


-- 7.3 Tìm các danh mục có hơn 3 món ăn đang còn bán
-- Gợi ý: GROUP BY + HAVING + WHERE
-- Viết SQL ở đây:


-- 7.4 Thống kê số hóa đơn theo trạng thái
-- Viết SQL ở đây:


-- BÀI 8: JOIN
-- -------------------------------------------------------

-- 8.1 Liệt kê tên món ăn kèm tên danh mục của nó
-- Gợi ý: JOIN mon_an với danh_muc_mon
-- Viết SQL ở đây:


-- 8.2 Xem chi tiết hóa đơn số 4: tên món, số lượng, đơn giá, thành tiền
-- Gợi ý: JOIN chi_tiet_hoa_don với mon_an
-- Viết SQL ở đây:


-- 8.3 Liệt kê toàn bộ hóa đơn kèm thông tin: số bàn, tên khách hàng, trạng thái
-- Gợi ý: JOIN hoa_don với ban_an và khach_hang
-- Viết SQL ở đây:


-- 8.4 Tìm các danh mục KHÔNG có món ăn nào (dùng LEFT JOIN)
-- Viết SQL ở đây:


-- 8.5 (Khó hơn) Liệt kê tên khách hàng và tổng số tiền họ đã chi tiêu
--     Chỉ tính các hóa đơn đã thanh_toan, sắp xếp theo chi tiêu giảm dần
-- Gợi ý: JOIN khach_hang → hoa_don → chi_tiet_hoa_don, GROUP BY khach_hang
-- Viết SQL ở đây:


-- BÀI 9: Subquery
-- -------------------------------------------------------

-- 9.1 Tìm các món ăn có giá cao hơn giá trung bình của toàn bộ món ăn
-- Viết SQL ở đây:


-- 9.2 Tìm khách hàng chưa có hóa đơn nào
-- Gợi ý: dùng NOT IN hoặc NOT EXISTS
-- Viết SQL ở đây:


-- 9.3 Tìm hóa đơn có tổng tiền cao nhất
--     (dùng subquery để tính tổng từng hóa đơn, rồi lấy max)
-- Viết SQL ở đây:


-- 9.4 Liệt kê các món ăn chưa được gọi trong bất kỳ hóa đơn nào
-- Viết SQL ở đây:


-- BÀI 10: CASE WHEN
-- -------------------------------------------------------

-- 10.1 Phân loại món ăn theo giá:
--      < 40.000      → 'Bình dân'
--      40.000-70.000 → 'Trung bình'
--      > 70.000      → 'Cao cấp'
-- Viết SQL ở đây:


-- 10.2 Xếp hạng khách hàng theo điểm tích lũy:
--      >= 400  → 'Vàng'
--      >= 200  → 'Bạc'
--      >= 100  → 'Đồng'
--      < 100   → 'Thường'
-- Hiển thị: tên khách hàng, điểm, hạng
-- Viết SQL ở đây:


-- 10.3 Thống kê theo danh mục: tên danh mục, số món đang bán, số món đã ngừng bán
-- Gợi ý: dùng CASE WHEN bên trong SUM() hoặc COUNT()
--        SUM(CASE WHEN con_ban = TRUE THEN 1 ELSE 0 END)
-- Viết SQL ở đây:


-- BÀI 11: Tổng hợp (bài tự do)
-- -------------------------------------------------------

-- 11.1 Báo cáo doanh thu theo bàn: số bàn, tầng, số hóa đơn đã thanh toán, tổng doanh thu
-- Viết SQL ở đây:


-- 11.2 Top 3 món ăn được gọi nhiều nhất (tính tổng số_luong trong chi_tiet_hoa_don)
-- Viết SQL ở đây:


-- 11.3 Tìm khách hàng "trung thành" nhất: gọi nhiều hóa đơn đã thanh toán nhất
-- Viết SQL ở đây:


-- ============================================================
-- GỢI Ý ĐÁP ÁN
-- ============================================================
/*

-- 6.1
SELECT COUNT(*) AS tong_mon FROM mon_an WHERE con_ban = TRUE;

-- 6.2
SELECT AVG(gia) AS gia_tb, MIN(gia) AS gia_thap_nhat, MAX(gia) AS gia_cao_nhat FROM mon_an;

-- 6.3
SELECT SUM(so_luong * don_gia) AS tong_tien FROM chi_tiet_hoa_don WHERE hoa_don_id = 4;

-- 6.4
SELECT COUNT(*) FROM khach_hang WHERE diem > 0;

-- 7.1
SELECT danh_muc_id, COUNT(*) AS so_mon FROM mon_an GROUP BY danh_muc_id;

-- 7.2
SELECT hoa_don_id, SUM(so_luong * don_gia) AS tong_tien
FROM chi_tiet_hoa_don
GROUP BY hoa_don_id
ORDER BY tong_tien DESC;

-- 7.3
SELECT danh_muc_id, COUNT(*) AS so_mon
FROM mon_an
WHERE con_ban = TRUE
GROUP BY danh_muc_id
HAVING so_mon > 3;

-- 7.4
SELECT trang_thai, COUNT(*) AS so_hoa_don FROM hoa_don GROUP BY trang_thai;

-- 8.1
SELECT m.ten AS mon_an, dm.ten AS danh_muc
FROM mon_an m
JOIN danh_muc_mon dm ON m.danh_muc_id = dm.id;

-- 8.2
SELECT m.ten, ct.so_luong, ct.don_gia, ct.so_luong * ct.don_gia AS thanh_tien
FROM chi_tiet_hoa_don ct
JOIN mon_an m ON ct.mon_an_id = m.id
WHERE ct.hoa_don_id = 4;

-- 8.3
SELECT h.id, b.so_ban, kh.ho_ten, h.trang_thai, h.thoi_gian
FROM hoa_don h
JOIN ban_an b ON h.ban_id = b.id
JOIN khach_hang kh ON h.khach_hang_id = kh.id;

-- 8.4
SELECT dm.ten
FROM danh_muc_mon dm
LEFT JOIN mon_an m ON dm.id = m.danh_muc_id
WHERE m.id IS NULL;

-- 8.5
SELECT kh.ho_ten, SUM(ct.so_luong * ct.don_gia) AS tong_chi_tieu
FROM khach_hang kh
JOIN hoa_don h ON kh.id = h.khach_hang_id
JOIN chi_tiet_hoa_don ct ON h.id = ct.hoa_don_id
WHERE h.trang_thai = 'thanh_toan'
GROUP BY kh.id, kh.ho_ten
ORDER BY tong_chi_tieu DESC;

-- 9.1
SELECT ten, gia FROM mon_an WHERE gia > (SELECT AVG(gia) FROM mon_an);

-- 9.2
SELECT ho_ten FROM khach_hang WHERE id NOT IN (SELECT DISTINCT khach_hang_id FROM hoa_don);
-- Hoặc dùng NOT EXISTS:
SELECT ho_ten FROM khach_hang kh
WHERE NOT EXISTS (SELECT 1 FROM hoa_don h WHERE h.khach_hang_id = kh.id);

-- 9.3
SELECT hoa_don_id, tong_tien
FROM (
    SELECT hoa_don_id, SUM(so_luong * don_gia) AS tong_tien
    FROM chi_tiet_hoa_don GROUP BY hoa_don_id
) AS tong
WHERE tong_tien = (
    SELECT MAX(tong) FROM (
        SELECT SUM(so_luong * don_gia) AS tong FROM chi_tiet_hoa_don GROUP BY hoa_don_id
    ) AS t
);

-- 9.4
SELECT ten FROM mon_an WHERE id NOT IN (SELECT DISTINCT mon_an_id FROM chi_tiet_hoa_don);

-- 10.1
SELECT ten, gia,
    CASE
        WHEN gia < 40000  THEN 'Bình dân'
        WHEN gia <= 70000 THEN 'Trung bình'
        ELSE 'Cao cấp'
    END AS phan_loai
FROM mon_an ORDER BY gia;

-- 10.2
SELECT ho_ten, diem,
    CASE
        WHEN diem >= 400 THEN 'Vàng'
        WHEN diem >= 200 THEN 'Bạc'
        WHEN diem >= 100 THEN 'Đồng'
        ELSE 'Thường'
    END AS hang
FROM khach_hang ORDER BY diem DESC;

-- 10.3
SELECT dm.ten,
    SUM(CASE WHEN m.con_ban = TRUE  THEN 1 ELSE 0 END) AS dang_ban,
    SUM(CASE WHEN m.con_ban = FALSE THEN 1 ELSE 0 END) AS ngung_ban
FROM danh_muc_mon dm
LEFT JOIN mon_an m ON dm.id = m.danh_muc_id
GROUP BY dm.id, dm.ten;

-- 11.1
SELECT b.so_ban, b.tang, COUNT(h.id) AS so_hoa_don,
    COALESCE(SUM(ct.so_luong * ct.don_gia), 0) AS doanh_thu
FROM ban_an b
LEFT JOIN hoa_don h ON b.id = h.ban_id AND h.trang_thai = 'thanh_toan'
LEFT JOIN chi_tiet_hoa_don ct ON h.id = ct.hoa_don_id
GROUP BY b.id, b.so_ban, b.tang
ORDER BY doanh_thu DESC;

-- 11.2
SELECT m.ten, SUM(ct.so_luong) AS tong_goi
FROM chi_tiet_hoa_don ct
JOIN mon_an m ON ct.mon_an_id = m.id
GROUP BY m.id, m.ten
ORDER BY tong_goi DESC
LIMIT 3;

-- 11.3
SELECT kh.ho_ten, COUNT(h.id) AS so_lan_den
FROM khach_hang kh
JOIN hoa_don h ON kh.id = h.khach_hang_id
WHERE h.trang_thai = 'thanh_toan'
GROUP BY kh.id, kh.ho_ten
ORDER BY so_lan_den DESC
LIMIT 1;

*/
