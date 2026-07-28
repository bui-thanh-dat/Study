CREATE DATABASE book_shop;
USE book_shop;

CREATE TABLE Reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE Series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    released_year YEAR,
    genre VARCHAR(100)
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating FLOAT,
    series_id INT,
    reviewer_id INT,

    CONSTRAINT fk_reviews_series
        FOREIGN KEY (series_id)
        REFERENCES Series(id),

    CONSTRAINT fk_reviews_reviewers
        FOREIGN KEY (reviewer_id)
        REFERENCES Reviewers(id)
);

INSERT INTO Series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ('Breaking Bad', 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ('Fargo', 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');

INSERT INTO Reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');

INSERT INTO Reviews (series_id, reviewer_id, rating) 
VALUES
    (1,1,8.0),
    (1,2,7.5),
    (1,3,8.5),
    (1,4,7.7),
    (1,5,8.9),
    (2,1,8.1),
    (2,4,6.0),
    (2,3,8.0),
    (2,6,8.4),
    (2,5,9.9),
    (3,1,7.0),
    (3,6,7.5),
    (3,4,8.0),
    (3,3,7.1),
    (3,5,8.0),
    (4,1,7.5),(4,3,8.0),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.0),(6,4,8.0),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

SELECT * FROM Reviewers;
SELECT * FROM Series;
SELECT * FROM Reviews;

SELECT title, rating
FROM Series
JOIN Reviews
ON Series.id = Reviews.series_id;

SELECT
    title,
    ROUND(AVG(rating),2) AS avg_rating
FROM Series
JOIN Reviews
ON Series.id = Reviews.series_id
GROUP BY Series.id, title;


SELECT genre, 
	ROUND(AVG(rating),2) AS avg_rating
FROM Series
JOIN Reviews
ON Series.id = Reviews.series_id
GROUP BY genre;

 -- Yêu cầu 7: Viết truy vấn giá trị rating của mỗi người review trong bảng reviewers
SELECT first_name, last_name , rating
FROM Reviewers
JOIN Reviews
ON Reviewers.id = Reviews.reviewer_id;

-- Yêu cầu 8: Viết truy vấn để tìm những series chưa được review trong bảng series

SELECT title AS unreviewed_series
FROM Series 
LEFT JOIN Reviews
ON Reviews.series_id = Series.id
WHERE Reviews.series_id IS NULL;

-- Yêu cầu 9: Viết truy vấn để thống kê số review của mỗi người reviewers

SELECT first_name,
	last_name, 
	COUNT(rating) AS COUNT,
    IFNULL(MIN(rating),0) AS MIN,
    IFNULL(MAX(rating),0) AS MAX,
    IFNULL(ROUND(AVG(rating),2), 0) AS AVERAGE,
    IF( COUNT(rating)> 0, 'ACTIVE','UNACTIVE') AS STATUS_
FROM Reviewers
LEFT JOIN Reviews
ON  Reviewers.id = Reviews.reviewer_id
GROUP BY Reviewers.id ,first_name, last_name;

-- Yêu cầu 10: Viết truy vấn để join ba bảng reviewers, reviews, series

SELECT title, rating,
	CONCAT(first_name, ' ', last_name) AS reviewer
FROM Reviews
JOIN Reviewers
ON Reviews.reviewer_id = Reviewers.id
JOIN Series
ON Reviews.series_id = Series.id
ORDER BY title;