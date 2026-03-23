-- ============================================================
-- NGÀY 18: TRIGGER - Tự Động Hóa
-- ============================================================

USE hoc_mysql;

-- ==============================
-- PHẦN 1: AFTER INSERT TRIGGER
-- ==============================

-- BƯỚC 1: Tạo bảng log
CREATE TABLE IF NOT EXISTS activity_log (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    bang        VARCHAR(50),
    hanh_dong   VARCHAR(20),
    ban_ghi_id  INT,
    mo_ta       TEXT,
    thoi_gian   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BƯỚC 2: Trigger ghi log khi có đơn hàng mới
DELIMITER //

CREATE TRIGGER after_insert_don_hang
AFTER INSERT ON don_hang
FOR EACH ROW
BEGIN
    INSERT INTO activity_log (bang, hanh_dong, ban_ghi_id, mo_ta)
    VALUES (
        'don_hang',
        'INSERT',
        NEW.id,
        CONCAT('Đơn mới: KH#', NEW.khach_hang_id, ' - ', FORMAT(NEW.tong_tien, 0), ' VNĐ')
    );
END //

DELIMITER ;

-- Test trigger
INSERT INTO don_hang (khach_hang_id, tong_tien, trang_thai)
VALUES (2, 350000, 'cho_xu_ly');

-- Kiểm tra log
SELECT * FROM activity_log;

-- ==============================
-- PHẦN 2: BEFORE INSERT TRIGGER - CHUẨN HÓA DỮ LIỆU
-- ==============================

-- BƯỚC 3: Tự động format dữ liệu khi INSERT
DELIMITER //

CREATE TRIGGER before_insert_khach_hang
BEFORE INSERT ON khach_hang
FOR EACH ROW
BEGIN
    -- Loại bỏ khoảng trắng và chuyển về chữ thường
    SET NEW.email = LOWER(TRIM(NEW.email));

    -- Loại bỏ khoảng trắng tên
    SET NEW.ho_ten = TRIM(NEW.ho_ten);

    -- Chuẩn hóa số điện thoại (xóa dấu cách)
    IF NEW.so_dien_thoai IS NOT NULL THEN
        SET NEW.so_dien_thoai = REPLACE(NEW.so_dien_thoai, ' ', '');
    END IF;
END //

DELIMITER ;

-- Test: thêm với email chữ hoa, có khoảng trắng
INSERT INTO khach_hang (ho_ten, email, so_dien_thoai)
VALUES ('  Bùi Thị Giang  ', '  GIANG.BUI@EMAIL.COM  ', '0987 654 321');

SELECT ho_ten, email, so_dien_thoai FROM khach_hang
WHERE email LIKE '%giang%';
-- Kết quả: email và tên đã được chuẩn hóa tự động

-- ==============================
-- PHẦN 3: BEFORE UPDATE - KIỂM TRA DỮ LIỆU
-- ==============================

-- BƯỚC 4: Không cho giảm giá quá 50%
DELIMITER //

CREATE TRIGGER before_update_gia_san_pham
BEFORE UPDATE ON san_pham
FOR EACH ROW
BEGIN
    -- Nếu giá mới < 50% giá cũ → báo lỗi
    IF NEW.gia < OLD.gia * 0.5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không được giảm giá quá 50%!';
    END IF;

    -- Không cho phép số lượng âm
    IF NEW.so_luong < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng tồn kho không được âm!';
    END IF;
END //

DELIMITER ;

-- Test: giảm giá bình thường (OK)
SELECT ten, gia FROM san_pham WHERE id = 5;
UPDATE san_pham SET gia = gia * 0.8 WHERE id = 5;  -- giảm 20% → OK
SELECT ten, gia FROM san_pham WHERE id = 5;

-- Test: giảm giá quá nhiều (LỖI)
UPDATE san_pham SET gia = 10 WHERE id = 5;  -- → LỖI trigger

-- ==============================
-- PHẦN 4: AFTER UPDATE - GHI LỊCH SỬ
-- ==============================

-- BƯỚC 5: Ghi lịch sử thay đổi giá
CREATE TABLE IF NOT EXISTS lich_su_gia (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    san_pham_id INT,
    gia_cu      DECIMAL(15, 2),
    gia_moi     DECIMAL(15, 2),
    chenh_lech  DECIMAL(15, 2),
    thoi_gian   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_update_san_pham
AFTER UPDATE ON san_pham
FOR EACH ROW
BEGIN
    -- Chỉ ghi log khi giá thay đổi
    IF NEW.gia <> OLD.gia THEN
        INSERT INTO lich_su_gia (san_pham_id, gia_cu, gia_moi, chenh_lech)
        VALUES (NEW.id, OLD.gia, NEW.gia, NEW.gia - OLD.gia);
    END IF;
END //

DELIMITER ;

-- Test
SELECT ten, gia FROM san_pham WHERE id = 1;
UPDATE san_pham SET gia = gia * 1.05 WHERE id = 1;  -- tăng 5%
UPDATE san_pham SET gia = gia * 0.97 WHERE id = 1;  -- giảm 3%

SELECT * FROM lich_su_gia;

-- ==============================
-- PHẦN 5: AFTER DELETE - BACKUP
-- ==============================

-- BƯỚC 6: Lưu sản phẩm trước khi xóa
CREATE TABLE IF NOT EXISTS san_pham_da_xoa (
    id          INT,
    ten         VARCHAR(200),
    gia         DECIMAL(15, 2),
    so_luong    INT,
    ngay_xoa    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_delete_san_pham
AFTER DELETE ON san_pham
FOR EACH ROW
BEGIN
    INSERT INTO san_pham_da_xoa (id, ten, gia, so_luong)
    VALUES (OLD.id, OLD.ten, OLD.gia, OLD.so_luong);

    -- Ghi log
    INSERT INTO activity_log (bang, hanh_dong, ban_ghi_id, mo_ta)
    VALUES ('san_pham', 'DELETE', OLD.id, CONCAT('Đã xóa: ', OLD.ten));
END //

DELIMITER ;

-- Test: thêm 1 sản phẩm tạm rồi xóa
INSERT INTO san_pham (danh_muc_id, ten, gia, so_luong)
VALUES (1, 'Sản phẩm test xóa', 99000, 1);

SET @id_test = LAST_INSERT_ID();
SELECT * FROM san_pham WHERE id = @id_test;

DELETE FROM san_pham WHERE id = @id_test;

-- Kiểm tra backup
SELECT * FROM san_pham_da_xoa;
SELECT * FROM activity_log WHERE bang = 'san_pham';

-- ==============================
-- PHẦN 6: QUẢN LÝ TRIGGER
-- ==============================

-- BƯỚC 7: Xem danh sách trigger
SHOW TRIGGERS FROM hoc_mysql;
SHOW TRIGGERS FROM hoc_mysql LIKE '%san_pham%';

-- Xóa trigger
DROP TRIGGER IF EXISTS after_insert_don_hang;

-- Kiểm tra
SHOW TRIGGERS FROM hoc_mysql;

-- ============================================================
-- BÀI TẬP:
-- 1. Tạo trigger BEFORE INSERT trên don_hang để kiểm tra khach_hang_id tồn tại
-- 2. Tạo trigger AFTER UPDATE trên don_hang ghi log khi trạng thái thay đổi
-- 3. Tạo trigger tự động cộng tồn kho khi chi tiết đơn hàng bị xóa (hoàn trả)
-- ============================================================

-- Giải bài tập 3
DELIMITER //

CREATE TRIGGER after_delete_chi_tiet_don_hang
AFTER DELETE ON chi_tiet_don_hang
FOR EACH ROW
BEGIN
    -- Hoàn trả tồn kho khi xóa chi tiết đơn hàng
    UPDATE san_pham
    SET so_luong = so_luong + OLD.so_luong
    WHERE id = OLD.san_pham_id;

    -- Ghi log
    INSERT INTO activity_log (bang, hanh_dong, ban_ghi_id, mo_ta)
    VALUES (
        'chi_tiet_don_hang',
        'DELETE',
        OLD.id,
        CONCAT('Hoàn ', OLD.so_luong, ' SP#', OLD.san_pham_id, ' vào kho')
    );
END //

DELIMITER ;

-- Test
SELECT ten, so_luong FROM san_pham WHERE id = 1;
SELECT * FROM chi_tiet_don_hang WHERE don_hang_id = 1;

DELETE FROM chi_tiet_don_hang WHERE don_hang_id = 1;

SELECT ten, so_luong FROM san_pham WHERE id = 1;  -- so_luong đã tăng
SELECT * FROM activity_log ORDER BY id DESC LIMIT 3;
