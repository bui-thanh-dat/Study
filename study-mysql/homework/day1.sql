CREATE DATABASE quan_ly;
USE quan_ly;

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

RENAME TABLE khach_hang TO customer; 

ALTER TABLE customer 
ADD dia_chi VARCHAR (15);

SELECT * FROM customer;

ALTER TABLE customer
RENAME COLUMN dia_chi TO address;

ALTER TABLE customer
MODIFY COLUMN address VARCHAR(100);

ALTER TABLE customer
MODIFY address VARCHAR(100)
AFTER email;

ALTER TABLE customer
MODIFY so_du VARCHAR(100)
FIRST;

ALTER TABLE customer
DROP COLUMN email;
