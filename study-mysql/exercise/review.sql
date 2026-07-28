CREATE DATABASE cua_hang_online;
USE cua_hang_online;

CREATE TABLE san_pham (
	id INT PRIMARY KEY AUTO_INCREMENT,
    ten_sp VARCHAR(200) NOT NULL,
    gia DECIMAL(12,2) NOT NULL,
    so_luong INT DEFAULT 0,
    danh_muc ENUM('Dien tu', 'Thoi trang', 'Gia dung'),
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- add 1 product
INSERT INTO san_pham (ten_sp, gia, so_luong, danh_muc)
VALUES ('iPhone 15', 25990000, 50, 'Dien tu');

-- add >2 products 
INSERT INTO san_pham (ten_sp, gia, so_luong, danh_muc)
VALUES 
	('AirPods Pro', 6490000, 100, 'Dien tu'),
    ('Ao thun', 299000, 200, 'Thoi trang');
    
-- Take all products
SELECT * FROM san_pham;

--  conditional selection 
SELECT ten_sp, gia FROM san_pham
WHERE gia > 1000000 AND danh_muc = 'Dien tu';

-- Sap xep va gioi han
SELECT * FROM san_pham 
ORDER BY gia DESC LIMIT 5;

-- increase price iP15 to 10% 
UPDATE san_pham
SET gia = gia * 1.10
WHERE ten_sp = 'iPhone 15';

DELETE FROM san_pham WHERE so_luong = 0;

SELECT kh.ten_khach_hang, dh.ngay_dat, dh.tong_tien
FROM don_hang dh
INNER JOIN khach_hang kh ON dh.khach_hang_id = kh.id
ORDER BY dh.ngay_dat DESC; 

-- Find customer never order 
SELECT kh.ten_khach_hang
FROM khach_hang kh
LEFT JOIN don_hang dh ON kh.id = dh.khach_hang_id
WHERE dh.id IS NULL;