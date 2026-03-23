-- ============================================================
-- NGÀY 12: Subquery (Truy Vấn Lồng Nhau)
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: SUBQUERY TRONG WHERE
-- ==============================

-- BƯỚC 1: Subquery trả về 1 giá trị (scalar)
-- Sản phẩm đắt hơn giá trung bình
SELECT ten, gia
FROM san_pham
WHERE gia > (SELECT AVG(gia) FROM san_pham)
ORDER BY gia;

-- So sánh: giá trung bình là bao nhiêu?
SELECT ROUND(AVG(gia), 0) AS gia_trung_binh FROM san_pham;

-- BƯỚC 2: Subquery với MAX/MIN
-- Sản phẩm đắt nhất
SELECT ten, gia FROM san_pham
WHERE gia = (SELECT MAX(gia) FROM san_pham);

-- Sản phẩm rẻ nhất trong danh mục Điện tử (id=1)
SELECT ten, gia FROM san_pham
WHERE danh_muc_id = 1
  AND gia = (SELECT MIN(gia) FROM san_pham WHERE danh_muc_id = 1);

-- BƯỚC 3: Subquery với IN
-- Sản phẩm thuộc danh mục có chứa chữ "trang"
SELECT ten, danh_muc_id FROM san_pham
WHERE danh_muc_id IN (
    SELECT id FROM danh_muc WHERE ten LIKE '%trang%'
);

-- Khách hàng đã đặt đơn hàng > 5 triệu
SELECT ho_ten, email FROM khach_hang
WHERE id IN (
    SELECT DISTINCT khach_hang_id FROM don_hang WHERE tong_tien > 5000000
);

-- ==============================
-- PHẦN 2: SUBQUERY TRONG FROM
-- ==============================

-- BƯỚC 4: Subquery tạo bảng tạm (phải đặt alias)
SELECT danh_muc_id, so_sp
FROM (
    SELECT danh_muc_id, COUNT(*) AS so_sp
    FROM san_pham
    GROUP BY danh_muc_id
) AS thong_ke
WHERE so_sp > 2;

-- BƯỚC 5: Subquery từ JOIN
SELECT kh_chi_tieu.ho_ten, kh_chi_tieu.tong
FROM (
    SELECT kh.ho_ten, SUM(dh.tong_tien) AS tong
    FROM khach_hang kh
    JOIN don_hang dh ON kh.id = dh.khach_hang_id
    GROUP BY kh.id, kh.ho_ten
) AS kh_chi_tieu
WHERE kh_chi_tieu.tong > 10000000;

-- ==============================
-- PHẦN 3: SUBQUERY TRONG SELECT
-- ==============================

-- BƯỚC 6: Subquery trả về 1 giá trị cho mỗi dòng (correlated subquery)
-- Hiển thị tên danh mục cho mỗi sản phẩm
SELECT
    ten AS san_pham,
    gia,
    (SELECT ten FROM danh_muc WHERE id = san_pham.danh_muc_id) AS danh_muc
FROM san_pham
ORDER BY danh_muc;

-- Số đơn hàng của mỗi khách
SELECT
    ho_ten,
    (SELECT COUNT(*) FROM don_hang WHERE khach_hang_id = kh.id) AS so_don
FROM khach_hang kh;

-- ==============================
-- PHẦN 4: EXISTS / NOT EXISTS
-- ==============================

-- BƯỚC 7: EXISTS - trả về TRUE nếu subquery có kết quả
-- Khách hàng đã từng đặt hàng
SELECT ho_ten, email
FROM khach_hang kh
WHERE EXISTS (
    SELECT 1 FROM don_hang dh WHERE dh.khach_hang_id = kh.id
);

-- BƯỚC 8: NOT EXISTS - khách chưa đặt hàng
SELECT ho_ten, email
FROM khach_hang kh
WHERE NOT EXISTS (
    SELECT 1 FROM don_hang dh WHERE dh.khach_hang_id = kh.id
);

-- BƯỚC 9: Sản phẩm chưa từng được đặt mua
SELECT ten, gia
FROM san_pham sp
WHERE NOT EXISTS (
    SELECT 1 FROM chi_tiet_don_hang ct WHERE ct.san_pham_id = sp.id
);

-- ==============================
-- PHẦN 5: SUBQUERY NÂNG CAO
-- ==============================

-- BƯỚC 10: Sản phẩm đắt hơn giá trung bình của danh mục của nó
SELECT sp.ten, sp.gia, sp.danh_muc_id
FROM san_pham sp
WHERE sp.gia > (
    SELECT AVG(sp2.gia)
    FROM san_pham sp2
    WHERE sp2.danh_muc_id = sp.danh_muc_id
)
ORDER BY sp.danh_muc_id, sp.gia DESC;

-- BƯỚC 11: So sánh Subquery vs JOIN (cùng kết quả)
-- Dùng subquery
SELECT ten FROM san_pham
WHERE danh_muc_id IN (SELECT id FROM danh_muc WHERE ten = 'Điện tử');

-- Dùng JOIN (thường nhanh hơn)
SELECT sp.ten FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE dm.ten = 'Điện tử';

-- ============================================================
-- BÀI TẬP:
-- 1. Tìm sản phẩm rẻ hơn giá trung bình toàn bộ sản phẩm
-- 2. Tìm danh mục có nhiều sản phẩm nhất (dùng subquery)
-- 3. Hiển thị mỗi khách hàng kèm số tiền đơn hàng gần nhất
-- 4. Tìm sản phẩm trong cùng danh mục với sản phẩm id=1
-- ============================================================

-- Giải bài tập
-- 1.
SELECT ten, gia FROM san_pham
WHERE gia < (SELECT AVG(gia) FROM san_pham)
ORDER BY gia DESC;

-- 2.
SELECT ten FROM danh_muc
WHERE id = (
    SELECT danh_muc_id FROM san_pham
    GROUP BY danh_muc_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- 3.
SELECT
    ho_ten,
    (SELECT tong_tien FROM don_hang WHERE khach_hang_id = kh.id
     ORDER BY ngay_dat DESC LIMIT 1) AS don_hang_cuoi
FROM khach_hang kh;

-- 4.
SELECT ten, gia FROM san_pham
WHERE danh_muc_id = (SELECT danh_muc_id FROM san_pham WHERE id = 1)
  AND id <> 1;
