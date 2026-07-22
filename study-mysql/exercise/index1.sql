CREATE DATABASE company_db;

USE company_db;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(5,2) 
);

INSERT INTO products (product_id, product_name)
VALUES
(100, 'hamburger' ),
(101, 'fries'),
(102, 'soda'),
(103, 'ice cream');

SELECT * FROM products;

ALTER TABLE products
MODIFY price DECIMAL(5,2) DEFAULT 0;


DROP TABLE transactions;

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL (5,2),
    transaction_date DATETIME DEFAULT NOW()
);

insert into transactions(amount)
values (8.99),(10.99),(12.99);

select * from transactions;

drop table transactions;