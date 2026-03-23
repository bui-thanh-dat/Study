# Ngày 19: Stored Function - Hàm Tự Định Nghĩa

## Stored Function vs Stored Procedure

| | Stored Function | Stored Procedure |
|--|----------------|-----------------|
| **Trả về** | Đúng 1 giá trị (RETURN) | 0 hoặc nhiều kết quả |
| **Gọi bằng** | Dùng trong SELECT, WHERE... | CALL |
| **Dùng trong SQL** | CÓ (như hàm có sẵn) | KHÔNG |
| **Transaction** | Không nên | CÓ |

---

## Cú pháp

```sql
DELIMITER //

CREATE FUNCTION ten_function(tham_so kieu_du_lieu)
RETURNS kieu_tra_ve
DETERMINISTIC  -- hoặc NOT DETERMINISTIC
BEGIN
    DECLARE bien kieu;
    -- xử lý
    RETURN gia_tri;
END //

DELIMITER ;
```

> **DETERMINISTIC:** Cùng đầu vào → cùng đầu ra (dùng cho hàm tính toán thuần túy)
> **NOT DETERMINISTIC:** Đầu ra có thể khác nhau (VD: hàm dùng NOW(), RAND())

---

## Ví dụ cơ bản

```sql
DELIMITER //

-- Hàm định dạng tiền tệ
CREATE FUNCTION dinh_dang_tien(so_tien DECIMAL(15,2))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN CONCAT(FORMAT(so_tien, 0), ' VNĐ');
END //

-- Hàm tính tuổi từ ngày sinh
CREATE FUNCTION tinh_tuoi(ngay_sinh DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, ngay_sinh, CURDATE());
END //

-- Hàm xếp loại học lực
CREATE FUNCTION xep_loai(diem DECIMAL(4,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE ket_qua VARCHAR(20);
    IF diem >= 9 THEN
        SET ket_qua = 'Xuất sắc';
    ELSEIF diem >= 8 THEN
        SET ket_qua = 'Giỏi';
    ELSEIF diem >= 7 THEN
        SET ket_qua = 'Khá';
    ELSEIF diem >= 5 THEN
        SET ket_qua = 'Trung bình';
    ELSE
        SET ket_qua = 'Yếu';
    END IF;
    RETURN ket_qua;
END //

DELIMITER ;
```

---

## Sử dụng Function trong SELECT

```sql
-- Hiển thị giá tiền đẹp hơn
SELECT ten, dinh_dang_tien(gia) AS gia FROM san_pham;

-- Tính tuổi khách hàng
-- SELECT ho_ten, tinh_tuoi(ngay_sinh) AS tuoi FROM khach_hang;

-- Xếp loại điểm
-- SELECT sinh_vien, ten_mon, diem, xep_loai(diem) AS xep_loai FROM bang_diem;
```

---

## Function phức tạp hơn

```sql
DELIMITER //

-- Hàm tính tổng chi tiêu của khách
CREATE FUNCTION tong_chi_tieu(p_khach_hang_id INT)
RETURNS DECIMAL(15, 2)
READS SQL DATA
BEGIN
    DECLARE v_tong DECIMAL(15, 2) DEFAULT 0;
    SELECT COALESCE(SUM(tong_tien), 0) INTO v_tong
    FROM don_hang
    WHERE khach_hang_id = p_khach_hang_id;
    RETURN v_tong;
END //

-- Hàm kiểm tra email hợp lệ
CREATE FUNCTION la_email_hop_le(email VARCHAR(255))
RETURNS TINYINT(1)
DETERMINISTIC
BEGIN
    RETURN email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
END //

-- Hàm lấy tên danh mục
CREATE FUNCTION lay_ten_danh_muc(p_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE v_ten VARCHAR(100);
    SELECT ten INTO v_ten FROM danh_muc WHERE id = p_id;
    RETURN COALESCE(v_ten, 'Không xác định');
END //

DELIMITER ;

-- Sử dụng
SELECT ho_ten, dinh_dang_tien(tong_chi_tieu(id)) AS chi_tieu
FROM khach_hang;

SELECT ten, lay_ten_danh_muc(danh_muc_id) AS danh_muc FROM san_pham;

SELECT 'test@email.com' AS email, la_email_hop_le('test@email.com') AS hop_le;
```

---

## Quản lý Function

```sql
-- Xem danh sách function
SHOW FUNCTION STATUS WHERE Db = 'shop';

-- Xem nội dung function
SHOW CREATE FUNCTION dinh_dang_tien;

-- Xóa function
DROP FUNCTION IF EXISTS dinh_dang_tien;
```

---

## Thực hành tổng hợp

```sql
USE shop;

DELIMITER //

-- Hàm tính phần trăm giảm giá
CREATE FUNCTION phan_tram_giam(gia_goc DECIMAL(15,2), gia_km DECIMAL(15,2))
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    IF gia_goc = 0 THEN RETURN 0; END IF;
    RETURN ROUND((gia_goc - gia_km) / gia_goc * 100, 2);
END //

-- Hàm xếp loại khách hàng
CREATE FUNCTION xep_loai_khach(p_id INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE v_tong DECIMAL(15,2);
    SELECT COALESCE(SUM(tong_tien), 0) INTO v_tong
    FROM don_hang WHERE khach_hang_id = p_id;

    IF v_tong >= 50000000 THEN RETURN 'VIP Gold';
    ELSEIF v_tong >= 20000000 THEN RETURN 'VIP Silver';
    ELSEIF v_tong > 0 THEN RETURN 'Thường';
    ELSE RETURN 'Chưa mua';
    END IF;
END //

DELIMITER ;

-- Sử dụng
SELECT
    ho_ten,
    dinh_dang_tien(tong_chi_tieu(id)) AS chi_tieu,
    xep_loai_khach(id) AS hang_khach
FROM khach_hang;
```

---

## Bài tập thực hành
1. Tạo function `tinh_dtb(ma_sv)` tính điểm trung bình sinh viên
2. Tạo function `xep_loai_hoc_luc(dtb)` trả về Giỏi/Khá/Trung bình/Yếu
3. Tạo function `dem_mon_hoc(ma_sv)` đếm số môn đã học
4. Dùng các function trên trong 1 câu SELECT để tạo bảng xếp loại sinh viên

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
