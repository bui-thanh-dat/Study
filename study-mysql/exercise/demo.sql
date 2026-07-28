CREATE DATABASE IF NOT EXISTS Demo;
USE Demo;
CREATE TABLE QuanLy (
	id INT, 
	name_goods VARCHAR(200),
    price DECIMAL(12,2)
);

INSERT INTO QuanLy(id,name_goods, price)
VALUES(1,"PHONE",2000.00);
