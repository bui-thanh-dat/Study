# Ngày 2: Kiểu Dữ Liệu trong MySQL

## Tổng quan các kiểu dữ liệu

### Kiểu số (Numeric)
| Kiểu | Dung lượng | Phạm vi | Dùng khi nào |
|------|-----------|---------|--------------|
| `TINYINT` | 1 byte | -128 đến 127 | Tuổi, trạng thái (0/1) |
| `SMALLINT` | 2 bytes | -32,768 đến 32,767 | Năm học, mã nhỏ |
| `INT` | 4 bytes | -2.1 tỷ đến 2.1 tỷ | ID, số lượng thông thường |
| `BIGINT` | 8 bytes | Rất lớn | ID lớn, timestamp |
| `DECIMAL(p,s)` | Tùy | Chính xác | Giá tiền, tỷ lệ phần trăm |
| `FLOAT` | 4 bytes | Gần đúng | Tọa độ, đo lường |

```sql
-- Ví dụ
so_luong INT
gia DECIMAL(10, 2)   -- tối đa 10 chữ số, 2 số sau dấu phẩy
chieu_cao FLOAT
```

### Kiểu chuỗi (String)
| Kiểu | Mô tả | Dùng khi nào |
|------|-------|--------------|
| `CHAR(n)` | Chuỗi cố định n ký tự | Mã bưu chính, mã quốc gia |
| `VARCHAR(n)` | Chuỗi tối đa n ký tự | Tên, email, địa chỉ |
| `TEXT` | Chuỗi dài | Mô tả, nội dung bài viết |
| `LONGTEXT` | Chuỗi rất dài | Bài viết dài, logs |

```sql
-- Ví dụ
ten VARCHAR(100)
email VARCHAR(255)
mo_ta TEXT
noi_dung LONGTEXT
ma_nuoc CHAR(2)      -- VN, US, JP
```

### Kiểu ngày giờ (Date/Time)
| Kiểu | Format | Ví dụ |
|------|--------|-------|
| `DATE` | YYYY-MM-DD | 2024-03-15 |
| `TIME` | HH:MM:SS | 14:30:00 |
| `DATETIME` | YYYY-MM-DD HH:MM:SS | 2024-03-15 14:30:00 |
| `TIMESTAMP` | YYYY-MM-DD HH:MM:SS | Tự cập nhật khi sửa |
| `YEAR` | YYYY | 2024 |

```sql
-- Ví dụ
ngay_sinh DATE
gio_lam_viec TIME
ngay_tao DATETIME
cap_nhat_luc TIMESTAMP DEFAULT CURRENT_TIMESTAMP
nam_tot_nghiep YEAR
```

### Kiểu boolean
```sql
-- MySQL không có kiểu BOOLEAN riêng, dùng TINYINT(1)
is_active TINYINT(1) DEFAULT 1   -- 1 = true, 0 = false
```

## Ràng buộc (Constraints)
```sql
ten VARCHAR(100) NOT NULL          -- bắt buộc phải có giá trị
email VARCHAR(255) UNIQUE          -- không được trùng lặp
tuoi INT DEFAULT 18                -- giá trị mặc định
id INT PRIMARY KEY AUTO_INCREMENT  -- khóa chính, tự tăng
```

## Ví dụ thiết kế bảng thực tế
```sql
-- Bảng khách hàng
CREATE TABLE khach_hang (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten     VARCHAR(100) NOT NULL,
    email      VARCHAR(255) UNIQUE NOT NULL,
    so_dien_thoai CHAR(10),
    ngay_sinh  DATE,
    gioi_tinh  TINYINT(1),          -- 1: Nam, 0: Nữ
    so_du      DECIMAL(15, 2) DEFAULT 0.00,
    ngay_tao   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Bài tập thực hành
1. Thiết kế bảng `san_pham` với các cột: id, ten, gia, so_luong, mo_ta, ngay_nhap
2. Chọn kiểu dữ liệu phù hợp cho từng cột
3. Thiết kế bảng `nhan_vien` với ít nhất 8 cột

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
