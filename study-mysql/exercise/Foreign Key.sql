CREATE DATABASE IF NOT EXISTS lab_fk;
USE lab_fk;

CREATE TABLE khachhang (
	ma_kh INT PRIMARY KEY AUTO_INCREMENT,
    ten_kh VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE donhang (
	ma_dh INT PRIMARY KEY AUTO_INCREMENT,
	ngay_dat DATE NOT NULL,
    tong_tien DECIMAL(10,2) DEFAULT 0,
    ma_kh INT,
    CONSTRAINT fk_donhang_khachhang
		FOREIGN KEY (ma_kh) REFERENCES khachhang(ma_kh)
); 
-- CACH 2 
 -- ALTER TABLE donhang 
--  ADD CONSTRAINT fk_donhang_khachhang
--  FOREIGN KEY (ma_kh) REFERENCES khachhang(ma_kh); donhang

-- XOA FOREIGNKEY
ALTER TABLE donhang DROP FOREIGN KEY fk_donhang_khachhang;
INSERT INTO khachhang (ten_kh, email) VALUES
('Nguyen Van An', 'an@gmail.com'),
('Tran Thi Binh', 'binh@gmail.com');

-- 1. Hợp lệ
INSERT INTO donhang (ngay_dat, tong_tien, ma_kh)
VALUES ('2026-07-20', 500000, 1);

-- 2. LỖI 1452 — khách 99 không tồn tại
INSERT INTO donhang (ngay_dat, tong_tien, ma_kh)
VALUES ('2026-07-20', 300000, 99);

-- 3. LỖI 1451 — khách 1 đang có đơn hàng
DELETE FROM khachhang WHERE ma_kh = 1;

-- 4. Hợp lệ — NULL được chấp nhận (đơn hàng khách vãng lai)
INSERT INTO donhang (ngay_dat, tong_tien, ma_kh)
VALUES ('2026-07-21', 150000, NULL);

ALTER TABLE donhang 
ADD CONSTRAINT fk_donhang_khachhang
FOREIGN KEY (ma_kh) REFERENCES khachhang(ma_kh)
ON DELETE CASCADE 
ON UPDATE CASCADE;

DELETE FROM khachang WHERE ma_kh = 1; -- lan nay khong loi 
SELECT * FROM donhang; -- don cua khach 1 da bien mat 
 