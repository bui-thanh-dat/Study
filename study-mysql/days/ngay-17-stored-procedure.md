# Ngày 17: Stored Procedure - Thủ Tục Lưu Trữ

## Stored Procedure là gì?
**Stored Procedure** là một tập hợp câu lệnh SQL được đặt tên và lưu trong database, có thể gọi lại nhiều lần.

### Lợi ích:
- **Tái sử dụng:** viết 1 lần, gọi nhiều lần
- **Hiệu suất:** compiled sẵn, chạy nhanh hơn
- **Bảo mật:** không cần truy cập trực tiếp bảng
- **Giảm traffic:** chỉ gửi tên procedure thay vì toàn bộ SQL

---

## Cú pháp cơ bản

```sql
DELIMITER //

CREATE PROCEDURE ten_procedure(tham_so)
BEGIN
    -- Các câu lệnh SQL
END //

DELIMITER ;

-- Gọi procedure
CALL ten_procedure(gia_tri);
```

> **DELIMITER:** MySQL dùng `;` để kết thúc câu lệnh. Khi viết procedure có nhiều `;` bên trong, cần đổi delimiter tạm thời.

---

## Procedure không có tham số

```sql
DELIMITER //

CREATE PROCEDURE xem_tat_ca_san_pham()
BEGIN
    SELECT sp.ten, sp.gia, sp.so_luong, dm.ten AS danh_muc
    FROM san_pham sp
    JOIN danh_muc dm ON sp.danh_muc_id = dm.id
    ORDER BY dm.ten, sp.ten;
END //

DELIMITER ;

-- Gọi
CALL xem_tat_ca_san_pham();
```

---

## Tham số IN, OUT, INOUT

```sql
-- IN: truyền giá trị vào (mặc định)
-- OUT: nhận giá trị ra
-- INOUT: vừa vào vừa ra

DELIMITER //

-- Procedure với IN
CREATE PROCEDURE lay_san_pham_theo_danh_muc(IN p_danh_muc_id INT)
BEGIN
    SELECT ten, gia, so_luong
    FROM san_pham
    WHERE danh_muc_id = p_danh_muc_id
    ORDER BY gia;
END //

-- Procedure với OUT
CREATE PROCEDURE dem_san_pham(IN p_danh_muc_id INT, OUT p_so_luong INT)
BEGIN
    SELECT COUNT(*) INTO p_so_luong
    FROM san_pham
    WHERE danh_muc_id = p_danh_muc_id;
END //

-- Procedure với INOUT
CREATE PROCEDURE tang_gia(INOUT p_gia DECIMAL(15,2), IN p_phan_tram INT)
BEGIN
    SET p_gia = p_gia * (1 + p_phan_tram / 100);
END //

DELIMITER ;

-- Gọi IN procedure
CALL lay_san_pham_theo_danh_muc(1);

-- Gọi OUT procedure
CALL dem_san_pham(1, @so_luong);
SELECT @so_luong AS ket_qua;

-- Gọi INOUT procedure
SET @gia = 1000000;
CALL tang_gia(@gia, 10);
SELECT @gia AS gia_moi;   -- 1100000
```

---

## Biến cục bộ và điều kiện

```sql
DELIMITER //

CREATE PROCEDURE thong_ke_don_hang(IN p_khach_hang_id INT)
BEGIN
    -- Khai báo biến
    DECLARE v_so_don INT;
    DECLARE v_tong_tien DECIMAL(15, 2);
    DECLARE v_xep_loai VARCHAR(20);

    -- Tính toán
    SELECT COUNT(*), COALESCE(SUM(tong_tien), 0)
    INTO v_so_don, v_tong_tien
    FROM don_hang
    WHERE khach_hang_id = p_khach_hang_id;

    -- Điều kiện IF
    IF v_tong_tien >= 50000000 THEN
        SET v_xep_loai = 'VIP Gold';
    ELSEIF v_tong_tien >= 20000000 THEN
        SET v_xep_loai = 'VIP Silver';
    ELSEIF v_so_don > 0 THEN
        SET v_xep_loai = 'Thường';
    ELSE
        SET v_xep_loai = 'Chưa mua';
    END IF;

    -- Trả kết quả
    SELECT v_so_don AS so_don, v_tong_tien AS tong_chi_tieu, v_xep_loai AS xep_loai;
END //

DELIMITER ;

CALL thong_ke_don_hang(1);
```

---

## LOOP và CURSOR

```sql
DELIMITER //

-- WHILE loop
CREATE PROCEDURE tao_du_lieu_mau()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        INSERT INTO danh_muc (ten) VALUES (CONCAT('Danh mục ', i));
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;
```

---

## Quản lý Stored Procedure

```sql
-- Xem danh sách procedure
SHOW PROCEDURE STATUS WHERE Db = 'shop';

-- Xem nội dung procedure
SHOW CREATE PROCEDURE thong_ke_don_hang;

-- Xóa procedure
DROP PROCEDURE IF EXISTS ten_procedure;
```

---

## Thực hành tổng hợp

```sql
USE shop;

DELIMITER //

-- Procedure đặt hàng hoàn chỉnh
CREATE PROCEDURE dat_hang(
    IN p_khach_hang_id INT,
    IN p_san_pham_id INT,
    IN p_so_luong INT,
    OUT p_ma_don INT,
    OUT p_thong_bao VARCHAR(200)
)
BEGIN
    DECLARE v_gia DECIMAL(15, 2);
    DECLARE v_ton_kho INT;

    -- Lấy giá và tồn kho
    SELECT gia, so_luong INTO v_gia, v_ton_kho
    FROM san_pham WHERE id = p_san_pham_id;

    -- Kiểm tra tồn kho
    IF v_ton_kho < p_so_luong THEN
        SET p_ma_don = 0;
        SET p_thong_bao = 'Không đủ hàng trong kho';
    ELSE
        START TRANSACTION;

        -- Tạo đơn hàng
        INSERT INTO don_hang (khach_hang_id, tong_tien)
        VALUES (p_khach_hang_id, v_gia * p_so_luong);

        SET p_ma_don = LAST_INSERT_ID();

        -- Thêm chi tiết
        INSERT INTO chi_tiet_don_hang (don_hang_id, san_pham_id, so_luong, don_gia)
        VALUES (p_ma_don, p_san_pham_id, p_so_luong, v_gia);

        -- Giảm tồn kho
        UPDATE san_pham SET so_luong = so_luong - p_so_luong
        WHERE id = p_san_pham_id;

        COMMIT;
        SET p_thong_bao = CONCAT('Đặt hàng thành công! Mã đơn: ', p_ma_don);
    END IF;
END //

DELIMITER ;

-- Gọi procedure
CALL dat_hang(1, 1, 1, @ma_don, @thong_bao);
SELECT @ma_don, @thong_bao;
```

---

## Bài tập thực hành
1. Tạo procedure `them_sinh_vien(ho_ten, email, lop)` để thêm sinh viên mới
2. Tạo procedure `lay_bang_diem(ma_sv)` trả về bảng điểm của sinh viên
3. Tạo procedure `tinh_dtb(ma_sv, OUT dtb)` tính điểm trung bình
4. Tạo procedure `xep_loai_hoc_luc(ma_sv)` trả về xếp loại (Giỏi/Khá/Trung bình/Yếu)

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
