# Ngày 14: Index - Tối Ưu Hiệu Suất

## Index là gì?
**Index** (chỉ mục) là cấu trúc dữ liệu giúp MySQL tìm kiếm dữ liệu **nhanh hơn**, tương tự mục lục của cuốn sách.

- **Không có index:** MySQL quét toàn bộ bảng (full table scan)
- **Có index:** MySQL đi thẳng đến vị trí dữ liệu

### Đánh đổi:
- **Ưu điểm:** SELECT nhanh hơn nhiều
- **Nhược điểm:** INSERT/UPDATE/DELETE chậm hơn một chút, tốn thêm dung lượng

---

## Các loại Index

### PRIMARY KEY Index (tự động)
```sql
-- Khi tạo PRIMARY KEY, index được tạo tự động
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- index được tạo tự động
    ...
);
```

### UNIQUE Index
```sql
-- Đảm bảo giá trị duy nhất + tốc độ tìm kiếm
CREATE UNIQUE INDEX idx_email ON khach_hang(email);

-- Hoặc khi tạo bảng
CREATE TABLE users (
    email VARCHAR(255) UNIQUE
);
```

### REGULAR Index (INDEX / KEY)
```sql
-- Tăng tốc tìm kiếm, không bắt buộc duy nhất
CREATE INDEX idx_ten ON san_pham(ten);
CREATE INDEX idx_danh_muc ON san_pham(danh_muc_id);
```

### Composite Index (Index nhiều cột)
```sql
-- Hữu ích khi thường tìm kiếm theo nhiều cột cùng lúc
CREATE INDEX idx_danh_muc_gia ON san_pham(danh_muc_id, gia);

-- Hiệu quả với: WHERE danh_muc_id = 1 AND gia < 500000
-- Không hiệu quả với: WHERE gia < 500000 (không có danh_muc_id)
```

### FULLTEXT Index (tìm kiếm văn bản)
```sql
-- Dùng cho tìm kiếm trong TEXT, VARCHAR dài
CREATE FULLTEXT INDEX idx_mo_ta ON san_pham(ten, mo_ta);

-- Dùng với MATCH...AGAINST thay vì LIKE
SELECT * FROM san_pham
WHERE MATCH(ten, mo_ta) AGAINST ('điện thoại thông minh' IN NATURAL LANGUAGE MODE);
```

---

## Quản lý Index

```sql
-- Xem index của bảng
SHOW INDEX FROM san_pham;

-- Tạo index
CREATE INDEX idx_ten ON san_pham(ten);
ALTER TABLE san_pham ADD INDEX idx_ngay_nhap (ngay_nhap);

-- Xóa index
DROP INDEX idx_ten ON san_pham;
ALTER TABLE san_pham DROP INDEX idx_ngay_nhap;
```

---

## EXPLAIN - Phân tích câu truy vấn

`EXPLAIN` cho biết MySQL thực thi query như thế nào.

```sql
EXPLAIN SELECT * FROM san_pham WHERE ten = 'iPhone 15 Pro';
```

**Kết quả EXPLAIN cần chú ý:**

| Cột | Ý nghĩa |
|-----|---------|
| `type` | Loại quét (ALL=tệ, ref/range=tốt, const=rất tốt) |
| `key` | Index đang dùng (NULL = không dùng index nào) |
| `rows` | Số hàng ước tính phải quét |
| `Extra` | Thông tin thêm |

```sql
-- Trước khi tạo index
EXPLAIN SELECT * FROM san_pham WHERE ten = 'iPhone 15 Pro';
-- type: ALL, key: NULL, rows: 7 (quét toàn bộ bảng)

-- Tạo index
CREATE INDEX idx_ten ON san_pham(ten);

-- Sau khi tạo index
EXPLAIN SELECT * FROM san_pham WHERE ten = 'iPhone 15 Pro';
-- type: ref, key: idx_ten, rows: 1 (dùng index, nhanh hơn)
```

---

## Khi nào nên tạo Index?

### NÊN tạo index cho:
- Cột dùng trong `WHERE` thường xuyên
- Cột dùng trong `JOIN` (Foreign Key)
- Cột dùng trong `ORDER BY`
- Cột có nhiều giá trị khác nhau (high cardinality)

### KHÔNG nên tạo index cho:
- Bảng nhỏ (< 1000 dòng)
- Cột có ít giá trị khác nhau (VD: giới_tính chỉ có 2 giá trị)
- Cột ít khi dùng trong WHERE
- Bảng được INSERT/UPDATE rất nhiều

---

## Thực hành

```sql
USE shop;

-- 1. Xem index hiện tại
SHOW INDEX FROM san_pham;
SHOW INDEX FROM khach_hang;

-- 2. Phân tích query trước khi tạo index
EXPLAIN SELECT * FROM san_pham WHERE danh_muc_id = 1;
-- Quan sát: type, key, rows

-- 3. Tạo index
CREATE INDEX idx_sp_danhmuc ON san_pham(danh_muc_id);
CREATE INDEX idx_sp_gia ON san_pham(gia);
CREATE INDEX idx_kh_diachi ON khach_hang(dia_chi);

-- 4. Phân tích lại sau khi tạo index
EXPLAIN SELECT * FROM san_pham WHERE danh_muc_id = 1;
-- Quan sát sự thay đổi

-- 5. Composite index cho query phổ biến
CREATE INDEX idx_sp_danhmuc_gia ON san_pham(danh_muc_id, gia);

EXPLAIN SELECT * FROM san_pham WHERE danh_muc_id = 1 AND gia < 1000000;

-- 6. Xem tất cả index đã tạo
SHOW INDEX FROM san_pham;
```

---

## Bài tập thực hành
1. Chạy `EXPLAIN` trên bảng `sinh_vien` trước khi tạo index
2. Tạo index cho cột `lop` và `ma_sv`
3. Chạy `EXPLAIN` lại và so sánh kết quả
4. Tạo composite index cho cột thường tìm kiếm cùng nhau

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
