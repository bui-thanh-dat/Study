USE cat_app; 

CREATE TABLE unique_cats (
	cat_id int NOT NULL,
    name_cat varchar(100),
    age int,
    PRIMARY KEY(cat_id)
);

INSERT INTO unique_cats(cat_id, name_cat, age)
VALUES 
	(1, 'Fred', 23),
	(2, 'Louise', 3),
	(3, 'James', 3);
    
CREATE TABLE unique_cats2 (
	cat_id int NOT NULL AUTO_INCREMENT,
    name_cats varchar(100),
    age int,
     PRIMARY KEY (cat_id) 
);
INSERT INTO unique_cats2(name_cats, age)
VALUES 
('Skippy', 4),
('Jiff', 3),
('Jiff', 3),
('Jiff', 3),
('Skippy', 4);

CREATE TABLE employees(
	id INT NOT NULL AUTO_INCREMENT,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    middle_name varchar(255),
    age INT NOT NULL,
    current_status varchar(255) NOT NULL DEFAULT 'employed',
    PRIMARY KEY (id)
);

INSERT INTO employees(first_name, last_name, age)
VALUES ('Dora', 'Smith', 58);

CREATE TABLE cats(
	cat_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name_cats VARCHAR(100),
    breed VARCHAR(100), 
    age INT
);

INSERT INTO cats(name_cats, breed, age)
VALUES 
('Ringo', 'Tabby', 4),
('Cindy', 'Maine Coon', 10),
('Dumbledore', 'Maine Coon', 11),
('Egg', 'Persian', 4),
('Misty', 'Persian', 4),
('George Michael', 'Ragdoll', 9),
('Jackson', 'Sphynx', 7);

SELECT cat_id FROM cats; 
SELECT name_cats,breed FROM cats;
SELECT name_cats,age FROM cats;
SELECT cat_id AS id FROM cats;
SELECT name_cats AS cat_name, breed AS kitty_breed FROM cats;

-- UPDATE - DELETE
UPDATE cats
SET name_cats = 'Jack'
WHERE name_cats = 'Jackson';

UPDATE cats
SET name_cats = 'Bitish Shorthair'
WHERE name_cats = 'Ringo';

UPDATE cats
SET age = 12
WHERE breed = 'Maine Coon';

-- DELETE FROM cats WHERE age = 4;

DELETE FROM cats 
WHERE cat_id = age; 

DELETE FROM cats; 

