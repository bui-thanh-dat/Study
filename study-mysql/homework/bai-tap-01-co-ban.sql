-- ============================================================
-- BÀI TẬP 01: CƠ BẢN
-- Chủ đề: Quản lý nhà hàng
-- Kiến thức: SELECT, INSERT, UPDATE, DELETE, WHERE, ORDER BY, LIMIT
-- ============================================================

-- ============================================================
-- SETUP - Chạy phần này trước khi làm bài
-- ============================================================

DROP DATABASE IF EXISTS nha_hang;
CREATE DATABASE nha_hang CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nha_hang;

CREATE TABLE danh_muc_mon (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    ten      VARCHAR(100) NOT NULL,
    mo_ta    TEXT
);

CREATE TABLE mon_an (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    ten          VARCHAR(150) NOT NULL,
    gia          DECIMAL(10,0) NOT NULL,
    danh_muc_id  INT,
    con_ban      BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (danh_muc_id) REFERENCES danh_muc_mon(id)
);

CREATE TABLE ban_an (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    so_ban    VARCHAR(10) NOT NULL UNIQUE,
    suc_chua  INT NOT NULL COMMENT 'Số người tối đa',
    tang      INT DEFAULT 1
);

CREATE TABLE khach_hang (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten   VARCHAR(100) NOT NULL,
    sdt      VARCHAR(15),
    email    VARCHAR(100),
    diem     INT DEFAULT 0 COMMENT 'Điểm tích lũy'
);

CREATE TABLE hoa_don (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    ban_id          INT,
    khach_hang_id   INT,
    thoi_gian       DATETIME DEFAULT NOW(),
    trang_thai      ENUM('dang_an','thanh_toan','huy') DEFAULT 'dang_an',
    ghi_chu         TEXT,
    FOREIGN KEY (ban_id) REFERENCES ban_an(id),
    FOREIGN KEY (khach_hang_id) REFERENCES khach_hang(id)
);

CREATE TABLE chi_tiet_hoa_don (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    hoa_don_id  INT,
    mon_an_id   INT,
    so_luong    INT NOT NULL DEFAULT 1,
    don_gia     DECIMAL(10,0) NOT NULL,
    ghi_chu     VARCHAR(200),
    FOREIGN KEY (hoa_don_id) REFERENCES hoa_don(id),
    FOREIGN KEY (mon_an_id) REFERENCES mon_an(id)
);

-- Dữ liệu mẫu
INSERT INTO danh_muc_mon (ten, mo_ta) VALUES
    ('Khai vị',    'Các món ăn trước bữa chính'),
    ('Món chính',  'Cơm, bún, phở, mì...'),
    ('Tráng miệng','Bánh, kem, hoa quả'),
    ('Đồ uống',    'Nước ngọt, sinh tố, cà phê');

INSERT INTO mon_an (ten, gia, danh_muc_id, con_ban) VALUES
    ('Gỏi cuốn tôm thịt',     45000,  1, TRUE),
    ('Chả giò chiên',          40000,  1, TRUE),
    ('Súp cua',                55000,  1, TRUE),
    ('Phở bò tái chín',        75000,  2, TRUE),
    ('Bún bò Huế',             70000,  2, TRUE),
    ('Cơm tấm sườn bì chả',    65000,  2, TRUE),
    ('Cơm gà Hội An',          80000,  2, TRUE),
    ('Mì Quảng',               60000,  2, TRUE),
    ('Bánh flan caramel',      35000,  3, TRUE),
    ('Chè khúc bạch',          45000,  3, TRUE),
    ('Kem dừa',                30000,  3, TRUE),
    ('Nước cam ép',            35000,  4, TRUE),
    ('Cà phê sữa đá',          30000,  4, TRUE),
    ('Sinh tố bơ',             45000,  4, TRUE),
    ('Trà đào',                40000,  4, FALSE);

INSERT INTO ban_an (so_ban, suc_chua, tang) VALUES
    ('B01', 2, 1), ('B02', 4, 1), ('B03', 4, 1),
    ('B04', 6, 1), ('B05', 8, 1),
    ('B06', 4, 2), ('B07', 6, 2), ('B08', 8, 2),
    ('B09', 2, 2), ('B10', 10, 2);

INSERT INTO khach_hang (ho_ten, sdt, email, diem) VALUES
    ('Nguyễn Văn An',   '0901234567', 'an@email.com',    150),
    ('Trần Thị Bình',   '0912345678', 'binh@email.com',  320),
    ('Lê Hoàng Nam',    '0923456789', NULL,               80),
    ('Phạm Thu Hà',     '0934567890', 'ha@email.com',    500),
    ('Hoàng Minh Tuấn', '0945678901', NULL,               0),
    ('Vũ Thị Lan',      '0956789012', 'lan@email.com',   210);

INSERT INTO hoa_don (ban_id, khach_hang_id, thoi_gian, trang_thai) VALUES
    (1, 1, '2024-03-01 11:30:00', 'thanh_toan'),
    (2, 2, '2024-03-01 12:00:00', 'thanh_toan'),
    (3, 3, '2024-03-02 12:30:00', 'thanh_toan'),
    (4, 4, '2024-03-02 18:00:00', 'thanh_toan'),
    (5, 1, '2024-03-03 19:00:00', 'thanh_toan'),
    (2, 2, '2024-03-05 12:00:00', 'dang_an'),
    (6, 5, '2024-03-05 13:00:00', 'dang_an'),
    (7, 6, '2024-03-05 13:30:00', 'huy');

INSERT INTO chi_tiet_hoa_don (hoa_don_id, mon_an_id, so_luong, don_gia) VALUES
    (1, 1,  2, 45000), (1, 4,  2, 75000), (1, 12, 2, 35000),
    (2, 3,  3, 55000), (2, 6,  3, 65000), (2, 13, 3, 30000),
    (3, 2,  2, 40000), (3, 5,  2, 70000),
    (4, 1,  4, 45000), (4, 7,  4, 80000), (4, 9,  4, 35000), (4, 14, 4, 45000),
    (5, 4,  2, 75000), (5, 8,  2, 60000), (5, 11, 2, 30000),
    (6, 6,  2, 65000), (6, 13, 2, 30000),
    (7, 4,  1, 75000), (7, 12, 1, 35000);

-- ============================================================
-- BÀI TẬP
-- ============================================================

-- BÀI 1: SELECT cơ bản
-- -------------------------------------------------------

-- 1.1 Hiển thị toàn bộ danh sách món ăn (tên, giá, còn bán hay không)
-- Viết SQL ở đây:


-- 1.2 Liệt kê các món ăn đang còn bán (con_ban = TRUE), sắp xếp theo giá tăng dần
-- Viết SQL ở đây:


-- 1.3 Lấy 5 món đắt nhất đang còn bán
-- Viết SQL ở đây:


-- 1.4 Tìm tất cả khách hàng chưa có email (email IS NULL)
-- Viết SQL ở đây:


-- 1.5 Tìm các bàn ở tầng 2 có sức chứa từ 6 người trở lên
-- Viết SQL ở đây:


-- BÀI 2: WHERE nâng cao
-- -------------------------------------------------------

-- 2.1 Tìm món ăn có giá từ 40.000 đến 70.000 đồng
-- Viết SQL ở đây:


-- 2.2 Tìm khách hàng có tên bắt đầu bằng "Nguyễn" hoặc "Trần"
-- Gợi ý: dùng LIKE hoặc IN... Hmm, thật ra phải dùng LIKE ở đây
-- Viết SQL ở đây:


-- 2.3 Tìm các hóa đơn có trạng thái là 'dang_an' hoặc 'huy'
-- Gợi ý: dùng IN
-- Viết SQL ở đây:


-- 2.4 Liệt kê khách hàng có điểm tích lũy từ 100 đến 400
-- Viết SQL ở đây:


-- BÀI 3: INSERT
-- -------------------------------------------------------

-- 3.1 Thêm một danh mục mới tên "Món nướng", mô tả "Các món nướng than hoa"
-- Viết SQL ở đây:


-- 3.2 Thêm 2 món ăn mới vào danh mục "Món nướng" (lấy id danh mục vừa tạo):
--     - Sườn nướng mật ong: 95.000đ
--     - Mực nướng sa tế:    85.000đ
-- Viết SQL ở đây:


-- 3.3 Thêm một khách hàng mới: Đặng Quốc Huy, SĐT 0967891234, không có email
-- Viết SQL ở đây:


-- BÀI 4: UPDATE
-- -------------------------------------------------------

-- 4.1 Cập nhật giá món "Phở bò tái chín" lên 85.000đ
-- Viết SQL ở đây:


-- 4.2 Đánh dấu món "Trà đào" là còn bán (con_ban = TRUE)
-- Viết SQL ở đây:


-- 4.3 Tặng thêm 50 điểm cho tất cả khách hàng có điểm >= 200
-- Viết SQL ở đây:


-- 4.4 Cập nhật email cho khách hàng "Lê Hoàng Nam" thành 'nam@email.com'
-- Viết SQL ở đây:


-- BÀI 5: DELETE
-- -------------------------------------------------------

-- 5.1 Xóa các hóa đơn có trạng thái 'huy'
--     LƯU Ý: Phải xóa chi_tiet_hoa_don trước do có FOREIGN KEY
-- Bước 1 - Xóa chi tiết:


-- Bước 2 - Xóa hóa đơn:


-- 5.2 Xóa khách hàng "Hoàng Minh Tuấn" (điểm = 0, chưa có hóa đơn nào)
-- Viết SQL ở đây:


-- ============================================================
-- GỢI Ý ĐÁP ÁN (chỉ xem khi đã tự làm)
-- ============================================================
/*

-- 1.1
SELECT ten, gia, con_ban FROM mon_an;

-- 1.2
SELECT ten, gia FROM mon_an WHERE con_ban = TRUE ORDER BY gia ASC;

-- 1.3
SELECT ten, gia FROM mon_an WHERE con_ban = TRUE ORDER BY gia DESC LIMIT 5;

-- 1.4
SELECT ho_ten, sdt FROM khach_hang WHERE email IS NULL;

-- 1.5
SELECT so_ban, suc_chua FROM ban_an WHERE tang = 2 AND suc_chua >= 6;

-- 2.1
SELECT ten, gia FROM mon_an WHERE gia BETWEEN 40000 AND 70000;

-- 2.2
SELECT ho_ten FROM khach_hang WHERE ho_ten LIKE 'Nguyễn%' OR ho_ten LIKE 'Trần%';

-- 2.3
SELECT * FROM hoa_don WHERE trang_thai IN ('dang_an', 'huy');

-- 2.4
SELECT ho_ten, diem FROM khach_hang WHERE diem BETWEEN 100 AND 400;

-- 3.1
INSERT INTO danh_muc_mon (ten, mo_ta) VALUES ('Món nướng', 'Các món nướng than hoa');

-- 3.2
INSERT INTO mon_an (ten, gia, danh_muc_id) VALUES
    ('Sườn nướng mật ong', 95000, 5),
    ('Mực nướng sa tế',    85000, 5);

-- 3.3
INSERT INTO khach_hang (ho_ten, sdt) VALUES ('Đặng Quốc Huy', '0967891234');

-- 4.1
UPDATE mon_an SET gia = 85000 WHERE ten = 'Phở bò tái chín';

-- 4.2
UPDATE mon_an SET con_ban = TRUE WHERE ten = 'Trà đào';

-- 4.3
UPDATE khach_hang SET diem = diem + 50 WHERE diem >= 200;

-- 4.4
UPDATE khach_hang SET email = 'nam@email.com' WHERE ho_ten = 'Lê Hoàng Nam';

-- 5.1
DELETE FROM chi_tiet_hoa_don WHERE hoa_don_id IN (SELECT id FROM hoa_don WHERE trang_thai = 'huy');
DELETE FROM hoa_don WHERE trang_thai = 'huy';

-- 5.2
DELETE FROM khach_hang WHERE ho_ten = 'Hoàng Minh Tuấn';

*/
