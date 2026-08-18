-- ============================================================
-- BÀI TẬP 00: SƠ CẤP
-- Kiến thức: CREATE DATABASE, CREATE TABLE, kiểu dữ liệu,
--            PRIMARY KEY, FOREIGN KEY, ALTER TABLE, INSERT
-- ============================================================
-- Làm file này TRƯỚC khi làm các bài tập khác
-- ============================================================


-- ============================================================
-- PHẦN 1: TẠO DATABASE
-- ============================================================

-- BÀI 1.1
-- Tạo một database tên `truong_hoc` với charset utf8mb4
-- Viết SQL ở đây:


-- BÀI 1.2
-- Chọn database `truong_hoc` để làm việc
-- Viết SQL ở đây:


-- BÀI 1.3
-- Kiểm tra đang dùng database nào (hint: SELECT DATABASE())
-- Viết SQL ở đây:


-- ============================================================
-- PHẦN 2: TẠO TABLE
-- ============================================================

-- BÀI 2.1
-- Tạo bảng `khoa` với các cột:
--   id      INT, khóa chính, tự tăng
--   ten     VARCHAR(100), không được NULL
--   ma_khoa VARCHAR(10),  duy nhất (UNIQUE), không được NULL
--   mo_ta   TEXT,         có thể NULL
-- Viết SQL ở đây:


-- BÀI 2.2
-- Tạo bảng `giang_vien` với các cột:
--   id        INT, khóa chính, tự tăng
--   ho_ten    VARCHAR(100), không được NULL
--   email     VARCHAR(100), duy nhất
--   luong     DECIMAL(10,0), mặc định 0
--   khoa_id   INT, khóa ngoại tham chiếu đến khoa(id)
-- Viết SQL ở đây:


-- BÀI 2.3
-- Tạo bảng `sinh_vien` với các cột:
--   id          INT, khóa chính, tự tăng
--   ho_ten      VARCHAR(100), không được NULL
--   ngay_sinh   DATE
--   gioi_tinh   ENUM('Nam','Nữ','Khác')
--   email       VARCHAR(100)
--   khoa_id     INT, khóa ngoại tham chiếu đến khoa(id)
--   nam_nhap_hoc YEAR, mặc định năm hiện tại (YEAR(NOW()))
-- Viết SQL ở đây:


-- BÀI 2.4
-- Tạo bảng `mon_hoc` với các cột:
--   id          INT, khóa chính, tự tăng
--   ten         VARCHAR(150), không được NULL
--   ma_mon      VARCHAR(10), duy nhất, không được NULL
--   so_tin_chi  INT, mặc định 3, kiểm tra giá trị từ 1 đến 5 (CHECK)
--   khoa_id     INT, khóa ngoại tham chiếu đến khoa(id)
-- Viết SQL ở đây:


-- BÀI 2.5
-- Tạo bảng `diem` với các cột:
--   id            INT, khóa chính, tự tăng
--   sinh_vien_id  INT, khóa ngoại → sinh_vien(id)
--   mon_hoc_id    INT, khóa ngoại → mon_hoc(id)
--   diem_so       DECIMAL(4,2), CHECK diem_so >= 0 AND diem_so <= 10
--   ngay_thi      DATE
-- Gợi ý: nên thêm UNIQUE(sinh_vien_id, mon_hoc_id) để tránh nhập điểm trùng
-- Viết SQL ở đây:


-- ============================================================
-- PHẦN 3: ALTER TABLE (sửa cấu trúc bảng)
-- ============================================================

-- BÀI 3.1
-- Thêm cột `so_dien_thoai VARCHAR(15)` vào bảng `sinh_vien`
-- Viết SQL ở đây:


-- BÀI 3.2
-- Thêm cột `ngay_tao DATETIME DEFAULT NOW()` vào bảng `sinh_vien`
-- Viết SQL ở đây:


-- BÀI 3.3
-- Đổi tên cột `luong` thành `muc_luong` trong bảng `giang_vien`
-- Gợi ý: ALTER TABLE ... RENAME COLUMN ... TO ...
-- Viết SQL ở đây:


-- BÀI 3.4
-- Thay đổi kiểu dữ liệu cột `mo_ta` trong bảng `khoa` từ TEXT thành VARCHAR(500)
-- Gợi ý: ALTER TABLE ... MODIFY COLUMN ...
-- Viết SQL ở đây:


-- BÀI 3.5
-- Thêm cột `trang_thai ENUM('dang_hoc','bao_luu','da_tot_nghiep') DEFAULT 'dang_hoc'`
-- vào bảng `sinh_vien`
-- Viết SQL ở đây:


-- ============================================================
-- PHẦN 4: INSERT DATA
-- ============================================================

-- BÀI 4.1
-- Thêm 3 khoa sau vào bảng `khoa`:
--   | ten                          | ma_khoa | mo_ta                            |
--   |------------------------------|---------|----------------------------------|
--   | Công nghệ thông tin          | CNTT    | Khoa đào tạo kỹ sư phần mềm      |
--   | Kinh tế                      | KT      | Khoa kinh tế và quản trị kinh doanh |
--   | Ngoại ngữ                    | NN      | Khoa tiếng Anh, Nhật, Hàn        |
-- Viết SQL ở đây (INSERT nhiều dòng 1 lần):


-- BÀI 4.2
-- Thêm 4 giảng viên:
--   | ho_ten             | email                  | muc_luong | khoa_id |
--   |--------------------|------------------------|-----------|---------|
--   | Nguyễn Thanh Tùng  | tung@truong.edu.vn     | 15000000  | 1       |
--   | Trần Thị Mai       | mai@truong.edu.vn      | 12000000  | 1       |
--   | Lê Văn Hòa         | hoa@truong.edu.vn      | 13000000  | 2       |
--   | Phạm Minh Châu     | chau@truong.edu.vn     | 11000000  | 3       |
-- Viết SQL ở đây:


-- BÀI 4.3
-- Thêm 5 sinh viên:
--   | ho_ten           | ngay_sinh  | gioi_tinh | email               | khoa_id | nam_nhap_hoc |
--   |------------------|------------|-----------|---------------------|---------|--------------|
--   | Đỗ Quang Khải    | 2003-05-15 | Nam       | khai@sv.edu.vn      | 1       | 2022         |
--   | Ngô Thị Hương    | 2003-08-20 | Nữ        | huong@sv.edu.vn     | 1       | 2022         |
--   | Bùi Văn Long     | 2002-12-01 | Nam       | long@sv.edu.vn      | 2       | 2021         |
--   | Đinh Thu Trang   | 2004-03-10 | Nữ        | trang@sv.edu.vn     | 3       | 2023         |
--   | Vũ Đức Mạnh      | 2003-07-25 | Nam       | NULL                | 1       | 2022         |
-- Viết SQL ở đây:


-- BÀI 4.4
-- Thêm 4 môn học:
--   | ten                         | ma_mon | so_tin_chi | khoa_id |
--   |-----------------------------|--------|------------|---------|
--   | Lập trình Python            | LTP    | 3          | 1       |
--   | Cơ sở dữ liệu               | CSDB   | 4          | 1       |
--   | Kinh tế vi mô               | KTVM   | 3          | 2       |
--   | Tiếng Anh cơ bản            | TAC    | 2          | 3       |
-- Viết SQL ở đây:


-- BÀI 4.5
-- Thêm điểm thi cho các sinh viên:
--   | sinh_vien_id | mon_hoc_id | diem_so | ngay_thi   |
--   |--------------|------------|---------|------------|
--   | 1            | 1          | 8.5     | 2023-06-15 |
--   | 1            | 2          | 7.0     | 2023-06-18 |
--   | 2            | 1          | 9.0     | 2023-06-15 |
--   | 2            | 2          | 8.0     | 2023-06-18 |
--   | 3            | 3          | 6.5     | 2023-06-20 |
--   | 4            | 4          | 9.5     | 2023-06-22 |
--   | 5            | 1          | 5.0     | 2023-06-15 |
-- Viết SQL ở đây:


-- BÀI 4.6
-- Thêm 1 sinh viên bằng cách CHỈ cung cấp ho_ten và khoa_id (các cột khác để mặc định/NULL)
-- Sinh viên: Hoàng Anh Đức, khoa CNTT (id=1)
-- Mục đích: quan sát giá trị mặc định được tự động gán như thế nào
-- Viết SQL ở đây:


-- Kiểm tra: SELECT * FROM sinh_vien WHERE ho_ten = 'Hoàng Anh Đức';


-- ============================================================
-- PHẦN 5: XEM & KIỂM TRA
-- ============================================================

-- BÀI 5.1
-- Xem cấu trúc bảng `sinh_vien` (dùng DESCRIBE hoặc DESC)
-- Viết SQL ở đây:


-- BÀI 5.2
-- Xem toàn bộ dữ liệu trong bảng `khoa`
-- Viết SQL ở đây:


-- BÀI 5.3
-- Xem toàn bộ dữ liệu trong bảng `sinh_vien`
-- Viết SQL ở đây:


-- BÀI 5.4
-- Xem danh sách tất cả các bảng trong database `truong_hoc`
-- Gợi ý: SHOW TABLES;
-- Viết SQL ở đây:


-- BÀI 5.5 (Thử nghiệm)
-- Thử INSERT một điểm vi phạm ràng buộc CHECK (điểm = 11)
-- Quan sát lỗi MySQL báo gì
-- INSERT INTO diem (sinh_vien_id, mon_hoc_id, diem_so, ngay_thi) VALUES (1, 3, 11, '2023-06-25');


-- ============================================================
-- PHẦN 6: DROP & CLEANUP (làm sau cùng)
-- ============================================================

-- BÀI 6.1
-- Xóa bảng `diem` (phải xóa trước vì có FOREIGN KEY)
-- Viết SQL ở đây:


-- BÀI 6.2
-- Xóa toàn bộ database `truong_hoc`
-- LƯU Ý: Câu lệnh này không thể hoàn tác!
-- Viết SQL ở đây:


-- ============================================================
-- GỢI Ý ĐÁP ÁN
-- ============================================================
/*

-- 1.1
CREATE DATABASE truong_hoc CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 1.2
USE truong_hoc;

-- 1.3
SELECT DATABASE();

-- 2.1
CREATE TABLE khoa (
    id      INT PRIMARY KEY AUTO_INCREMENT,
    ten     VARCHAR(100) NOT NULL,
    ma_khoa VARCHAR(10)  NOT NULL UNIQUE,
    mo_ta   TEXT
);

-- 2.2
CREATE TABLE giang_vien (
    id      INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten  VARCHAR(100) NOT NULL,
    email   VARCHAR(100) UNIQUE,
    luong   DECIMAL(10,0) DEFAULT 0,
    khoa_id INT,
    FOREIGN KEY (khoa_id) REFERENCES khoa(id)
);

-- 2.3
CREATE TABLE sinh_vien (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten       VARCHAR(100) NOT NULL,
    ngay_sinh    DATE,
    gioi_tinh    ENUM('Nam','Nữ','Khác'),
    email        VARCHAR(100),
    khoa_id      INT,
    nam_nhap_hoc YEAR DEFAULT (YEAR(NOW())),
    FOREIGN KEY (khoa_id) REFERENCES khoa(id)
);

-- 2.4
CREATE TABLE mon_hoc (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    ten        VARCHAR(150) NOT NULL,
    ma_mon     VARCHAR(10)  NOT NULL UNIQUE,
    so_tin_chi INT DEFAULT 3 CHECK (so_tin_chi BETWEEN 1 AND 5),
    khoa_id    INT,
    FOREIGN KEY (khoa_id) REFERENCES khoa(id)
);

-- 2.5
CREATE TABLE diem (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    sinh_vien_id INT NOT NULL,
    mon_hoc_id   INT NOT NULL,
    diem_so      DECIMAL(4,2) CHECK (diem_so >= 0 AND diem_so <= 10),
    ngay_thi     DATE,
    UNIQUE (sinh_vien_id, mon_hoc_id),
    FOREIGN KEY (sinh_vien_id) REFERENCES sinh_vien(id),
    FOREIGN KEY (mon_hoc_id)   REFERENCES mon_hoc(id)
);

-- 3.1
ALTER TABLE sinh_vien ADD COLUMN so_dien_thoai VARCHAR(15);

-- 3.2
ALTER TABLE sinh_vien ADD COLUMN ngay_tao DATETIME DEFAULT NOW();

-- 3.3
ALTER TABLE giang_vien RENAME COLUMN luong TO muc_luong;

-- 3.4
ALTER TABLE khoa MODIFY COLUMN mo_ta VARCHAR(500);

-- 3.5
ALTER TABLE sinh_vien
ADD COLUMN trang_thai ENUM('dang_hoc','bao_luu','da_tot_nghiep') DEFAULT 'dang_hoc';

-- 4.1
INSERT INTO khoa (ten, ma_khoa, mo_ta) VALUES
    ('Công nghệ thông tin', 'CNTT', 'Khoa đào tạo kỹ sư phần mềm'),
    ('Kinh tế',             'KT',   'Khoa kinh tế và quản trị kinh doanh'),
    ('Ngoại ngữ',           'NN',   'Khoa tiếng Anh, Nhật, Hàn');

-- 4.2
INSERT INTO giang_vien (ho_ten, email, muc_luong, khoa_id) VALUES
    ('Nguyễn Thanh Tùng', 'tung@truong.edu.vn',  15000000, 1),
    ('Trần Thị Mai',       'mai@truong.edu.vn',   12000000, 1),
    ('Lê Văn Hòa',         'hoa@truong.edu.vn',   13000000, 2),
    ('Phạm Minh Châu',     'chau@truong.edu.vn',  11000000, 3);

-- 4.3
INSERT INTO sinh_vien (ho_ten, ngay_sinh, gioi_tinh, email, khoa_id, nam_nhap_hoc) VALUES
    ('Đỗ Quang Khải',  '2003-05-15', 'Nam', 'khai@sv.edu.vn',  1, 2022),
    ('Ngô Thị Hương',  '2003-08-20', 'Nữ',  'huong@sv.edu.vn', 1, 2022),
    ('Bùi Văn Long',   '2002-12-01', 'Nam', 'long@sv.edu.vn',  2, 2021),
    ('Đinh Thu Trang', '2004-03-10', 'Nữ',  'trang@sv.edu.vn', 3, 2023),
    ('Vũ Đức Mạnh',    '2003-07-25', 'Nam', NULL,              1, 2022);

-- 4.4
INSERT INTO mon_hoc (ten, ma_mon, so_tin_chi, khoa_id) VALUES
    ('Lập trình Python',  'LTP',  3, 1),
    ('Cơ sở dữ liệu',     'CSDB', 4, 1),
    ('Kinh tế vi mô',     'KTVM', 3, 2),
    ('Tiếng Anh cơ bản',  'TAC',  2, 3);

-- 4.5
INSERT INTO diem (sinh_vien_id, mon_hoc_id, diem_so, ngay_thi) VALUES
    (1, 1, 8.5, '2023-06-15'),
    (1, 2, 7.0, '2023-06-18'),
    (2, 1, 9.0, '2023-06-15'),
    (2, 2, 8.0, '2023-06-18'),
    (3, 3, 6.5, '2023-06-20'),
    (4, 4, 9.5, '2023-06-22'),
    (5, 1, 5.0, '2023-06-15');

-- 4.6
INSERT INTO sinh_vien (ho_ten, khoa_id) VALUES ('Hoàng Anh Đức', 1);

-- 5.1
DESC sinh_vien;

-- 5.2
SELECT * FROM khoa;

-- 5.3
SELECT * FROM sinh_vien;

-- 5.4
SHOW TABLES;

-- 6.1
DROP TABLE diem;

-- 6.2
DROP DATABASE truong_hoc;

*/
