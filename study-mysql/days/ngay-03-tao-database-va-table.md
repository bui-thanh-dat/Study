# Ngày 3: Tạo Database và Table (DDL)

## DDL là gì?
**DDL** (Data Definition Language) là nhóm lệnh dùng để **định nghĩa cấu trúc** dữ liệu.
Gồm: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`

---

## DATABASE

### Tạo database
```sql
CREATE DATABASE quan_ly_ban_hang;

-- Nếu chưa tồn tại mới tạo
CREATE DATABASE IF NOT EXISTS quan_ly_ban_hang;

-- Thiết lập encoding tiếng Việt
CREATE DATABASE quan_ly_ban_hang
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
```

### Chọn database để làm việc
```sql
USE quan_ly_ban_hang;
```

### Xem và xóa database
```sql
SHOW DATABASES;           -- xem danh sách tất cả database
SHOW CREATE DATABASE quan_ly_ban_hang;  -- xem lệnh tạo database
DROP DATABASE quan_ly_ban_hang;         -- xóa database (cẩn thận!)
DROP DATABASE IF EXISTS quan_ly_ban_hang;
```

---

## TABLE

### Tạo table
```sql
USE quan_ly_ban_hang;

CREATE TABLE khach_hang (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten        VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE,
    so_dien_thoai VARCHAR(15),
    dia_chi       TEXT,
    ngay_tao      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE san_pham (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    ten       VARCHAR(200) NOT NULL,
    gia       DECIMAL(15, 2) NOT NULL,
    so_luong  INT DEFAULT 0,
    mo_ta     TEXT,
    ngay_nhap DATE
);
```

### Xem thông tin table
```sql
SHOW TABLES;                    -- xem danh sách bảng
DESCRIBE khach_hang;            -- xem cấu trúc bảng
DESC khach_hang;                -- viết tắt
SHOW CREATE TABLE khach_hang;   -- xem lệnh tạo bảng
```

### Chỉnh sửa table (ALTER)
```sql
-- Thêm cột mới
ALTER TABLE khach_hang ADD COLUMN ngay_sinh DATE;

-- Thêm cột vào vị trí cụ thể
ALTER TABLE khach_hang ADD COLUMN tuoi INT AFTER ho_ten;

-- Sửa kiểu dữ liệu cột
ALTER TABLE khach_hang MODIFY COLUMN ho_ten VARCHAR(200);

-- Đổi tên cột
ALTER TABLE khach_hang CHANGE COLUMN ho_ten full_name VARCHAR(200);

-- Xóa cột
ALTER TABLE khach_hang DROP COLUMN tuoi;

-- Đổi tên bảng
ALTER TABLE khach_hang RENAME TO customers;
RENAME TABLE customers TO khach_hang;
```

### Xóa table
```sql
DROP TABLE san_pham;             -- xóa bảng
DROP TABLE IF EXISTS san_pham;   -- xóa nếu tồn tại

TRUNCATE TABLE khach_hang;       -- xóa toàn bộ dữ liệu, giữ cấu trúc
```

---

## Thực hành: Tạo CSDL bán hàng
```sql
-- Bước 1: Tạo database
CREATE DATABASE IF NOT EXISTS shop
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE shop;

-- Bước 2: Tạo bảng danh mục
CREATE TABLE danh_muc (
    id   INT PRIMARY KEY AUTO_INCREMENT,
    ten  VARCHAR(100) NOT NULL,
    mo_ta TEXT
);

-- Bước 3: Tạo bảng sản phẩm
CREATE TABLE san_pham (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    danh_muc_id INT,
    ten         VARCHAR(200) NOT NULL,
    gia         DECIMAL(15, 2) NOT NULL,
    so_luong    INT DEFAULT 0,
    hinh_anh    VARCHAR(500),
    ngay_tao    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (danh_muc_id) REFERENCES danh_muc(id)
);

-- Bước 4: Tạo bảng khách hàng
CREATE TABLE khach_hang (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten        VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    so_dien_thoai VARCHAR(15),
    dia_chi       TEXT,
    ngay_tao      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Kiểm tra
SHOW TABLES;
DESC san_pham;
```

## Bài tập thực hành
1. Tạo database `truong_hoc`
2. Tạo bảng `sinh_vien` (id, ho_ten, ma_sv, email, ngay_sinh, lop)
3. Tạo bảng `mon_hoc` (id, ten, so_tin_chi, mo_ta)
4. Dùng `DESC` để kiểm tra cấu trúc từng bảng

## Ghi chú cá nhân
> _(Ghi lại những điều bạn học được hoặc gặp khó khăn ở đây)_
