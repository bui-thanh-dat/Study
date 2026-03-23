# Ngày 7: UPDATE và DELETE - Cập Nhật và Xóa Dữ Liệu

## UPDATE - Cập nhật dữ liệu

### Cú pháp
```sql
UPDATE ten_bang
SET cot1 = gia_tri1, cot2 = gia_tri2
WHERE dieu_kien;
```

> **CẢNH BÁO:** Luôn dùng `WHERE`! Nếu quên, toàn bộ bảng sẽ bị cập nhật.

---

### Cập nhật cơ bản
```sql
-- Cập nhật 1 cột
UPDATE san_pham SET gia = 25000000 WHERE id = 1;

-- Cập nhật nhiều cột cùng lúc
UPDATE san_pham
SET gia = 25000000, so_luong = 45
WHERE id = 1;

-- Cập nhật dựa trên giá trị hiện tại
UPDATE san_pham SET so_luong = so_luong - 5 WHERE id = 1;
UPDATE san_pham SET gia = gia * 1.1;    -- tăng giá 10% TẤT CẢ sản phẩm
```

### Cập nhật với điều kiện phức tạp
```sql
-- Giảm giá 20% cho sản phẩm danh mục 1 có giá > 10 triệu
UPDATE san_pham
SET gia = gia * 0.8
WHERE danh_muc_id = 1 AND gia > 10000000;

-- Cập nhật nhiều bản ghi dựa trên danh sách
UPDATE san_pham
SET so_luong = so_luong + 100
WHERE id IN (1, 2, 3);

-- Cập nhật với CASE WHEN (điều kiện phân nhánh)
UPDATE san_pham
SET gia = CASE
    WHEN danh_muc_id = 1 THEN gia * 0.9   -- giảm 10% cho điện tử
    WHEN danh_muc_id = 2 THEN gia * 0.85  -- giảm 15% cho thời trang
    ELSE gia                               -- giữ nguyên
END;
```

### Cập nhật với JOIN
```sql
-- Cập nhật bảng A dựa trên điều kiện từ bảng B
UPDATE san_pham sp
JOIN danh_muc dm ON sp.danh_muc_id = dm.id
SET sp.so_luong = 0
WHERE dm.ten = 'Thực phẩm';
```

---

## DELETE - Xóa dữ liệu

### Cú pháp
```sql
DELETE FROM ten_bang WHERE dieu_kien;
```

> **CẢNH BÁO:** Luôn dùng `WHERE`! Nếu quên, toàn bộ dữ liệu trong bảng sẽ bị xóa.

---

### Xóa cơ bản
```sql
-- Xóa theo ID
DELETE FROM san_pham WHERE id = 10;

-- Xóa nhiều bản ghi
DELETE FROM san_pham WHERE danh_muc_id = 3;

-- Xóa theo điều kiện phức tạp
DELETE FROM san_pham
WHERE so_luong = 0 AND ngay_nhap < '2023-01-01';

-- Xóa theo danh sách
DELETE FROM san_pham WHERE id IN (5, 6, 7);
```

### Xóa có giới hạn
```sql
-- Chỉ xóa tối đa 3 bản ghi
DELETE FROM san_pham
WHERE so_luong = 0
LIMIT 3;
```

### DELETE vs TRUNCATE vs DROP

| Lệnh | Xóa dữ liệu | Xóa cấu trúc | Rollback được | Auto increment reset |
|------|------------|--------------|--------------|---------------------|
| `DELETE` | Có | Không | Có | Không |
| `TRUNCATE` | Có (toàn bộ) | Không | Không | Có |
| `DROP` | Có | Có | Không | — |

```sql
DELETE FROM san_pham;          -- xóa từng dòng, có thể rollback
TRUNCATE TABLE san_pham;       -- xóa nhanh toàn bộ, reset auto_increment
DROP TABLE san_pham;           -- xóa cả bảng
```

---

## Kỹ thuật an toàn

### Luôn SELECT trước khi DELETE/UPDATE
```sql
-- Bước 1: Kiểm tra trước
SELECT * FROM san_pham WHERE so_luong = 0;

-- Bước 2: Nếu đúng thì mới xóa
DELETE FROM san_pham WHERE so_luong = 0;
```

### Dùng Transaction để an toàn
```sql
START TRANSACTION;

UPDATE san_pham SET gia = gia * 0.9 WHERE danh_muc_id = 1;

-- Kiểm tra kết quả
SELECT ten, gia FROM san_pham WHERE danh_muc_id = 1;

-- Nếu OK
COMMIT;

-- Nếu sai → hoàn tác
ROLLBACK;
```

---

## Thực hành tổng hợp

```sql
USE shop;

-- 1. Cập nhật giá điện thoại iPhone tăng 5%
UPDATE san_pham SET gia = gia * 1.05 WHERE ten LIKE '%iPhone%';

-- 2. Thêm tồn kho cho sản phẩm sách
UPDATE san_pham SET so_luong = so_luong + 50 WHERE danh_muc_id = 4;

-- 3. Cập nhật địa chỉ khách hàng
UPDATE khach_hang
SET dia_chi = 'Quận 1, TP.HCM'
WHERE email = 'binh@email.com';

-- 4. Xóa sản phẩm hết hàng
-- Kiểm tra trước
SELECT * FROM san_pham WHERE so_luong = 0;
-- Rồi xóa
DELETE FROM san_pham WHERE so_luong = 0;
```

---

## Bài tập thực hành
1. Cập nhật điểm của 1 sinh viên cụ thể
2. Cập nhật số tín chỉ của tất cả môn học tăng thêm 1
3. Xóa sinh viên có ID cụ thể (SELECT trước để kiểm tra)
4. Thử UPDATE không có WHERE → quan sát điều gì xảy ra (dùng ROLLBACK)

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
