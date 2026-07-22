
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

INSERT INTO customers (customer_id, first_name, last_name)
VALUES
(1, 'Fred', 'Fish'),
(2, 'Larry', 'Lobster'),
(3, 'Bubble', 'Bass');

DROP TABLE transactions;
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL (5,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

ALTER TABLE transactions 
DROP FOREIGN KEY transactions_ibfk_1;

SELECT * FROM transactions;