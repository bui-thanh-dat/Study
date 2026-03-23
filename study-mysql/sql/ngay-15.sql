-- ============================================================
-- NGÀY 15: Transaction và ACID
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: TRANSACTION CƠ BẢN
-- ==============================

-- BƯỚC 1: Xem trạng thái autocommit
SHOW VARIABLES LIKE 'autocommit';  -- mặc định ON

-- BƯỚC 2: Thực hành ROLLBACK - hoàn tác
-- Xem dữ liệu trước
SELECT so_luong FROM san_pham WHERE id = 1;

START TRANSACTION;

-- Thay đổi dữ liệu
UPDATE san_pham SET so_luong = 9999 WHERE id = 1;

-- Xem trong transaction (thấy giá trị mới)
SELECT so_luong FROM san_pham WHERE id = 1;

-- Hoàn tác
ROLLBACK;

-- Xem sau ROLLBACK (quay về cũ)
SELECT so_luong FROM san_pham WHERE id = 1;

-- BƯỚC 3: Thực hành COMMIT - xác nhận
START TRANSACTION;

UPDATE san_pham SET so_luong = so_luong + 5 WHERE id = 1;

-- Kiểm tra
SELECT id, ten, so_luong FROM san_pham WHERE id = 1;

-- Xác nhận
COMMIT;

-- Dữ liệu được lưu vĩnh viễn
SELECT id, ten, so_luong FROM san_pham WHERE id = 1;

-- ==============================
-- PHẦN 2: TÌNH HUỐNG THỰC TẾ
-- ==============================

-- BƯỚC 4: Tình huống - Đặt hàng
-- Kịch bản: Khách hàng đặt 1 chiếc iPhone (id=1)

-- Xem trạng thái trước
SELECT ten, so_luong FROM san_pham WHERE id = 1;
SELECT COUNT(*) AS so_don FROM don_hang;

START TRANSACTION;

-- Bước 4a: Tạo đơn hàng
INSERT INTO don_hang (khach_hang_id, tong_tien, trang_thai)
VALUES (3, 26990000, 'cho_xu_ly');

SET @ma_don_moi = LAST_INSERT_ID();
SELECT @ma_don_moi AS ma_don_vua_tao;

-- Bước 4b: Thêm chi tiết
INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia)
VALUES (@ma_don_moi, 1, 1, 26990000);

-- Bước 4c: Giảm tồn kho
UPDATE san_pham SET so_luong = so_luong - 1 WHERE id = 1;

-- Bước 4d: Kiểm tra tồn kho không âm
SELECT so_luong FROM san_pham WHERE id = 1;
-- Nếu >= 0 thì COMMIT, nếu < 0 thì ROLLBACK

COMMIT;

-- Kiểm tra kết quả
SELECT ten, so_luong FROM san_pham WHERE id = 1;
SELECT * FROM don_hang WHERE id = @ma_don_moi;

-- BƯỚC 5: Tình huống - Tồn kho không đủ
START TRANSACTION;

-- Giả sử cố đặt 9999 cái
UPDATE san_pham SET so_luong = so_luong - 9999 WHERE id = 2;

-- Kiểm tra
SELECT ten, so_luong FROM san_pham WHERE id = 2;
-- so_luong < 0 → không hợp lệ

ROLLBACK;  -- hoàn tác

SELECT ten, so_luong FROM san_pham WHERE id = 2;  -- trở về

-- ==============================
-- PHẦN 3: SAVEPOINT
-- ==============================

-- BƯỚC 6: Thực hành SAVEPOINT
START TRANSACTION;

INSERT INTO danh_muc (ten) VALUES ('Danh mục test A');
SAVEPOINT sau_danh_muc_a;

INSERT INTO danh_muc (ten) VALUES ('Danh mục test B');
SAVEPOINT sau_danh_muc_b;

INSERT INTO danh_muc (ten) VALUES ('Danh mục test C');

-- Xem kết quả
SELECT * FROM danh_muc WHERE ten LIKE 'Danh mục test%';

-- Rollback về sau B (xóa C)
ROLLBACK TO sau_danh_muc_b;

-- Kiểm tra (C biến mất)
SELECT * FROM danh_muc WHERE ten LIKE 'Danh mục test%';

-- Rollback về sau A (xóa B)
ROLLBACK TO sau_danh_muc_a;
SELECT * FROM danh_muc WHERE ten LIKE 'Danh mục test%';

-- Xóa toàn bộ
ROLLBACK;
SELECT * FROM danh_muc WHERE ten LIKE 'Danh mục test%';

-- ==============================
-- PHẦN 4: ISOLATION LEVEL
-- ==============================

-- BƯỚC 7: Xem và thay đổi isolation level
SELECT @@transaction_isolation;

-- Đổi cho session hiện tại
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT @@transaction_isolation;

-- Trở về mặc định
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT @@transaction_isolation;

-- ============================================================
-- BÀI TẬP:
-- 1. Thực hiện transaction chuyển trạng thái đơn hàng id=1 thành "da_giao"
--    và ghi log vào bảng log (tạo bảng log trước)
-- 2. Thực hành: bắt đầu transaction, update dữ liệu, rồi ROLLBACK
--    Quan sát dữ liệu trở về như cũ
-- 3. Tạo SAVEPOINT khi thêm 3 danh mục, rollback về sau danh mục thứ 2
-- ============================================================

-- Giải bài tập 1
CREATE TABLE IF NOT EXISTS log_trang_thai_don (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    don_hang_id INT,
    trang_thai_cu VARCHAR(50),
    trang_thai_moi VARCHAR(50),
    thoi_gian   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

START TRANSACTION;

-- Lấy trạng thái cũ
SELECT trang_thai INTO @trang_thai_cu FROM don_hang WHERE id = 1;

-- Cập nhật
UPDATE don_hang SET trang_thai = 'da_giao' WHERE id = 1;

-- Ghi log
INSERT INTO log_trang_thai_don (don_hang_id, trang_thai_cu, trang_thai_moi)
VALUES (1, @trang_thai_cu, 'da_giao');

COMMIT;

SELECT * FROM don_hang WHERE id = 1;
SELECT * FROM log_trang_thai_don;
