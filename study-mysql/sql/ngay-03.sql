-- ============================================================
-- NGÀY 3: Tạo Database và Table (DDL)
-- ============================================================
-- Chú ý: Chạy từng BƯỚC, đọc kết quả trước khi tiếp

-- BƯỚC 1: Tạo database
CREATE DATABASE IF NOT EXISTS hoc_mysql
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Xác nhận đã tạo
SHOW DATABASES LIKE 'hoc_mysql';

-- BƯỚC 2: Chọn database để làm việc
USE hoc_mysql;

-- Kiểm tra đang ở database nào
SELECT DATABASE();

-- BƯỚC 3: Tạo bảng danh mục sản phẩm
CREATE TABLE IF NOT EXISTS danh_muc (
    id    INT PRIMARY KEY AUTO_INCREMENT,
    ten   VARCHAR(100) NOT NULL,
    mo_ta TEXT
);

-- BƯỚC 4: Tạo bảng sản phẩm
CREATE TABLE IF NOT EXISTS san_pham (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    danh_muc_id INT,
    ten         VARCHAR(200) NOT NULL,
    gia         DECIMAL(15, 2) NOT NULL DEFAULT 0,
    so_luong    INT DEFAULT 0,
    mo_ta       TEXT,
    ngay_nhap   DATE,
    ngay_tao    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (danh_muc_id) REFERENCES danh_muc(id)
);

-- BƯỚC 5: Tạo bảng khách hàng
CREATE TABLE IF NOT EXISTS khach_hang (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten        VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    so_dien_thoai VARCHAR(15),
    dia_chi       TEXT,
    ngay_tao      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BƯỚC 6: Xem kết quả
SHOW TABLES;
DESC danh_muc;
DESC san_pham;
DESC khach_hang;

-- BƯỚC 7: Thực hành ALTER TABLE
-- Thêm cột
ALTER TABLE khach_hang ADD COLUMN ngay_sinh DATE;
ALTER TABLE san_pham ADD COLUMN hinh_anh VARCHAR(500) AFTER mo_ta;

-- Xem sau khi thêm cột
DESC khach_hang;

-- Sửa kiểu dữ liệu
ALTER TABLE khach_hang MODIFY COLUMN so_dien_thoai VARCHAR(20);

-- Xóa cột vừa thêm (nếu muốn)
-- ALTER TABLE khach_hang DROP COLUMN ngay_sinh;

-- BƯỚC 8: Tạo thêm bảng đơn hàng
CREATE TABLE IF NOT EXISTS don_hang (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    khach_hang_id INT NOT NULL,
    tong_tien     DECIMAL(15, 2) DEFAULT 0,
    trang_thai    VARCHAR(50) DEFAULT 'cho_xu_ly',
    ngay_dat      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(id)
);

CREATE TABLE IF NOT EXISTS chi_tiet_don_hang (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    don_hang_id INT NOT NULL,
    san_pham_id INT NOT NULL,
    so_luong    INT NOT NULL DEFAULT 1,
    don_gia     DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (don_hang_id) REFERENCES don_hang(id),
    FOREIGN KEY (san_pham_id) REFERENCES san_pham(id)
);

-- Xem toàn bộ bảng đã tạo
SHOW TABLES;

-- ============================================================
-- BÀI TẬP:
-- 1. Tạo thêm bảng "nhan_vien" với các cột phù hợp
-- 2. Thêm cột "ghi_chu" vào bảng don_hang
-- 3. Đổi tên cột "ten" thành "ten_danh_muc" trong bảng danh_muc
-- ============================================================

-- Giải bài tập
CREATE TABLE IF NOT EXISTS nhan_vien (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten   VARCHAR(100) NOT NULL,
    email    VARCHAR(255) UNIQUE,
    luong    DECIMAL(12, 2),
    ngay_vao DATE
);

ALTER TABLE don_hang ADD COLUMN ghi_chu TEXT;
-- ALTER TABLE danh_muc CHANGE ten ten_danh_muc VARCHAR(100) NOT NULL;
