# Ngày 18: TRIGGER - Tự Động Hóa

## Trigger là gì?
**Trigger** là đoạn code tự động chạy khi có sự kiện xảy ra trên bảng (INSERT, UPDATE, DELETE).

### Các loại Trigger:
| Thời điểm | Sự kiện | Mô tả |
|-----------|---------|-------|
| `BEFORE` | `INSERT` | Chạy trước khi thêm |
| `AFTER` | `INSERT` | Chạy sau khi thêm |
| `BEFORE` | `UPDATE` | Chạy trước khi sửa |
| `AFTER` | `UPDATE` | Chạy sau khi sửa |
| `BEFORE` | `DELETE` | Chạy trước khi xóa |
| `AFTER` | `DELETE` | Chạy sau khi xóa |

---

## Cú pháp

```sql
DELIMITER //

CREATE TRIGGER ten_trigger
BEFORE|AFTER INSERT|UPDATE|DELETE ON ten_bang
FOR EACH ROW
BEGIN
    -- Code xử lý
    -- NEW.cot: giá trị mới (INSERT, UPDATE)
    -- OLD.cot: giá trị cũ (UPDATE, DELETE)
END //

DELIMITER ;
```

---

## AFTER INSERT - Tự động ghi log

```sql
-- Bảng log
CREATE TABLE log_don_hang (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    don_hang_id INT,
    hanh_dong   VARCHAR(50),
    thoi_gian   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ghi_chu     TEXT
);

DELIMITER //

-- Tự động ghi log khi có đơn hàng mới
CREATE TRIGGER after_insert_don_hang
AFTER INSERT ON don_hang
FOR EACH ROW
BEGIN
    INSERT INTO log_don_hang (don_hang_id, hanh_dong, ghi_chu)
    VALUES (NEW.id, 'TAO_MOI', CONCAT('Đơn hàng mới: ', NEW.tong_tien, ' VNĐ'));
END //

DELIMITER ;

-- Test: thêm đơn hàng → trigger tự chạy
INSERT INTO don_hang (khach_hang_id, tong_tien) VALUES (2, 500000);
SELECT * FROM log_don_hang;
```

---

## BEFORE UPDATE - Kiểm tra trước khi cập nhật

```sql
DELIMITER //

-- Không cho phép giảm giá quá 50%
CREATE TRIGGER before_update_gia
BEFORE UPDATE ON san_pham
FOR EACH ROW
BEGIN
    IF NEW.gia < OLD.gia * 0.5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không được giảm giá quá 50%!';
    END IF;
END //

-- Tự động cập nhật timestamp khi sửa
CREATE TRIGGER before_update_san_pham
BEFORE UPDATE ON san_pham
FOR EACH ROW
BEGIN
    SET NEW.cap_nhat_luc = NOW();
END //

DELIMITER ;

-- Test trigger kiểm tra giá
UPDATE san_pham SET gia = 1000 WHERE id = 1;  -- LỖI nếu giá gốc > 2000
```

---

## AFTER DELETE - Backup trước khi xóa

```sql
-- Bảng lưu trữ sản phẩm đã xóa
CREATE TABLE san_pham_da_xoa (
    id           INT,
    ten          VARCHAR(200),
    gia          DECIMAL(15, 2),
    ngay_xoa     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_delete_san_pham
AFTER DELETE ON san_pham
FOR EACH ROW
BEGIN
    INSERT INTO san_pham_da_xoa (id, ten, gia)
    VALUES (OLD.id, OLD.ten, OLD.gia);
END //

DELIMITER ;

-- Test
DELETE FROM san_pham WHERE id = 10;
SELECT * FROM san_pham_da_xoa;
```

---

## BEFORE INSERT - Chuẩn hóa dữ liệu

```sql
DELIMITER //

-- Tự động format email thành chữ thường
CREATE TRIGGER before_insert_khach_hang
BEFORE INSERT ON khach_hang
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(TRIM(NEW.email));
    SET NEW.ho_ten = TRIM(NEW.ho_ten);
END //

-- Tương tự cho UPDATE
CREATE TRIGGER before_update_khach_hang
BEFORE UPDATE ON khach_hang
FOR EACH ROW
BEGIN
    IF NEW.email IS NOT NULL THEN
        SET NEW.email = LOWER(TRIM(NEW.email));
    END IF;
END //

DELIMITER ;
```

---

## Ứng dụng: Tự động cập nhật tồn kho

```sql
DELIMITER //

-- Khi thêm chi tiết đơn hàng → giảm tồn kho tự động
CREATE TRIGGER after_insert_chi_tiet
AFTER INSERT ON chi_tiet_don_hang
FOR EACH ROW
BEGIN
    UPDATE san_pham
    SET so_luong = so_luong - NEW.so_luong
    WHERE id = NEW.san_pham_id;
END //

-- Khi xóa chi tiết đơn hàng → hoàn lại tồn kho
CREATE TRIGGER after_delete_chi_tiet
AFTER DELETE ON chi_tiet_don_hang
FOR EACH ROW
BEGIN
    UPDATE san_pham
    SET so_luong = so_luong + OLD.so_luong
    WHERE id = OLD.san_pham_id;
END //

DELIMITER ;
```

---

## Quản lý Trigger

```sql
-- Xem danh sách trigger
SHOW TRIGGERS;
SHOW TRIGGERS FROM shop;

-- Xem trigger cụ thể
SHOW CREATE TRIGGER after_insert_don_hang;

-- Xóa trigger
DROP TRIGGER IF EXISTS after_insert_don_hang;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Tạo bảng lịch sử thay đổi giá
CREATE TABLE lich_su_gia (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    san_pham_id INT,
    gia_cu      DECIMAL(15, 2),
    gia_moi     DECIMAL(15, 2),
    nguoi_sua   VARCHAR(100) DEFAULT USER(),
    thoi_gian   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Trigger ghi lịch sử khi giá thay đổi
DELIMITER //

CREATE TRIGGER after_update_gia
AFTER UPDATE ON san_pham
FOR EACH ROW
BEGIN
    IF NEW.gia <> OLD.gia THEN
        INSERT INTO lich_su_gia (san_pham_id, gia_cu, gia_moi)
        VALUES (NEW.id, OLD.gia, NEW.gia);
    END IF;
END //

DELIMITER ;

-- Test
UPDATE san_pham SET gia = 26000000 WHERE id = 1;
SELECT * FROM lich_su_gia;
```

---

## Bài tập thực hành
1. Tạo trigger tự động viết hoa chữ cái đầu tên sinh viên khi INSERT
2. Tạo trigger ghi log mỗi khi xóa sinh viên
3. Tạo trigger kiểm tra điểm nhập vào phải từ 0-10
4. Tạo trigger tự động cập nhật trạng thái học lực khi điểm thay đổi

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
