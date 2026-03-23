-- ============================================================
-- NGÀY 14: INDEX - Tối Ưu Hiệu Suất
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: PHÂN TÍCH TRƯỚC KHI TẠO INDEX
-- ==============================

-- BƯỚC 1: Xem index hiện có
SHOW INDEX FROM san_pham;
SHOW INDEX FROM khach_hang;
SHOW INDEX FROM don_hang;

-- BƯỚC 2: EXPLAIN - phân tích query trước khi tạo index
EXPLAIN SELECT * FROM san_pham WHERE ten = 'iPhone 15 Pro';
-- Chú ý: type=ALL (quét toàn bộ), key=NULL (không dùng index)

EXPLAIN SELECT * FROM san_pham WHERE danh_muc_id = 1;
EXPLAIN SELECT * FROM khach_hang WHERE email = 'an.nguyen@email.com';

-- ==============================
-- PHẦN 2: TẠO INDEX
-- ==============================

-- BƯỚC 3: Tạo Regular Index
CREATE INDEX idx_sp_ten ON san_pham(ten);

-- Xem kết quả
SHOW INDEX FROM san_pham;

-- EXPLAIN lại sau khi tạo index
EXPLAIN SELECT * FROM san_pham WHERE ten = 'iPhone 15 Pro';
-- Chú ý: type=ref, key=idx_sp_ten (đang dùng index!)

-- BƯỚC 4: Tạo index cho Foreign Key (thường nên có)
CREATE INDEX idx_sp_danhmuc ON san_pham(danh_muc_id);
CREATE INDEX idx_dh_khach ON don_hang(khach_hang_id);
CREATE INDEX idx_ct_donhang ON chi_tiet_don_hang(don_hang_id);
CREATE INDEX idx_ct_sanpham ON chi_tiet_don_hang(san_pham_id);

-- EXPLAIN query JOIN
EXPLAIN
SELECT sp.ten, dm.ten
FROM san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
WHERE dm.ten = 'Điện tử';

-- BƯỚC 5: Tạo Unique Index
CREATE UNIQUE INDEX idx_kh_email ON khach_hang(email);
-- Thử insert email trùng → sẽ báo lỗi
-- INSERT INTO khach_hang (ho_ten, email) VALUES ('Test', 'an.nguyen@email.com');

-- BƯỚC 6: Tạo Composite Index (nhiều cột)
-- Khi thường query: WHERE danh_muc_id = ? AND gia < ?
CREATE INDEX idx_sp_danhmuc_gia ON san_pham(danh_muc_id, gia);

EXPLAIN SELECT ten, gia FROM san_pham
WHERE danh_muc_id = 1 AND gia < 1000000;

-- ==============================
-- PHẦN 3: XEM VÀ QUẢN LÝ INDEX
-- ==============================

-- BƯỚC 7: Xem tất cả index của bảng
SHOW INDEX FROM san_pham;
-- Đọc kết quả:
-- Key_name: tên index
-- Column_name: cột
-- Non_unique: 0=unique, 1=không unique
-- Seq_in_index: thứ tự trong composite index

-- BƯỚC 8: Xem qua INFORMATION_SCHEMA
SELECT
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE,
    INDEX_TYPE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'hoc_mysql'
  AND TABLE_NAME = 'san_pham'
ORDER BY INDEX_NAME, SEQ_IN_INDEX;

-- BƯỚC 9: Xóa index
DROP INDEX idx_sp_ten ON san_pham;

-- Kiểm tra
SHOW INDEX FROM san_pham;

-- Tạo lại
CREATE INDEX idx_sp_ten ON san_pham(ten);

-- ==============================
-- PHẦN 4: INDEX VÀ ORDER BY
-- ==============================

-- BƯỚC 10: Index giúp ORDER BY nhanh hơn
CREATE INDEX idx_sp_gia ON san_pham(gia);
CREATE INDEX idx_dh_ngay ON don_hang(ngay_dat);

-- Query sắp xếp nhanh hơn
EXPLAIN SELECT ten, gia FROM san_pham ORDER BY gia DESC LIMIT 10;
EXPLAIN SELECT * FROM don_hang ORDER BY ngay_dat DESC LIMIT 5;

-- ==============================
-- PHẦN 5: KHI NÀO INDEX KHÔNG HOẠT ĐỘNG
-- ==============================

-- BƯỚC 11: Index KHÔNG hiệu quả khi
-- Dùng function trên cột có index
EXPLAIN SELECT * FROM san_pham WHERE YEAR(ngay_nhap) = 2024;
-- → MySQL không dùng index vì phải tính YEAR() cho từng dòng

-- Thay bằng:
EXPLAIN SELECT * FROM san_pham
WHERE ngay_nhap BETWEEN '2024-01-01' AND '2024-12-31';
-- → Dùng được index

-- LIKE với % ở đầu
EXPLAIN SELECT * FROM san_pham WHERE ten LIKE '%iPhone%';  -- không dùng index
EXPLAIN SELECT * FROM san_pham WHERE ten LIKE 'iPhone%';   -- dùng được index

-- ============================================================
-- BÀI TẬP:
-- 1. Chạy EXPLAIN trên bảng khach_hang với WHERE dia_chi = 'Hà Nội'
--    Ghi lại type và key
-- 2. Tạo index cho cột dia_chi
-- 3. Chạy lại EXPLAIN và so sánh kết quả
-- 4. Tạo composite index cho (trang_thai, ngay_dat) trong bảng don_hang
--    Rồi EXPLAIN query: WHERE trang_thai = 'da_giao' ORDER BY ngay_dat DESC
-- ============================================================

-- Giải bài tập
-- 1.
EXPLAIN SELECT * FROM khach_hang WHERE dia_chi = 'Hà Nội';

-- 2.
CREATE INDEX idx_kh_diachi ON khach_hang(dia_chi);

-- 3.
EXPLAIN SELECT * FROM khach_hang WHERE dia_chi = 'Hà Nội';

-- 4.
CREATE INDEX idx_dh_trangthai_ngay ON don_hang(trang_thai, ngay_dat);
EXPLAIN SELECT * FROM don_hang
WHERE trang_thai = 'da_giao' ORDER BY ngay_dat DESC;
