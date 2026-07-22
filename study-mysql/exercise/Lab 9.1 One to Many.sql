CREATE DATABASE IF NOT EXISTS book_shop;
USE book_shop;

CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(150) NOT NULL
);

CREATE TABLE papers (
	student_id INT,
    title VARCHAR(150),
    grade INT
);
INSERT INTO students (first_name) 
VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) 
VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT * FROM students;
SELECT * FROM papers;
-- ket qua 1
SELECT first_name, title, grade 
FROM students LEFT JOIN papers 
ON students.id = papers.student_id
AND grade >= 70;

-- ket qua 2
SELECT first_name,
	IFNULL(title, 'MISSING') AS title, 
    IFNULL(grade, 0) AS grade 
FROM students LEFT JOIN papers 
ON students.id = papers.student_id
AND grade >= 70;

-- ket qua 3
SELECT
    first_name,
    AVG(IFNULL(grade, 0)) AS average
FROM students
LEFT JOIN papers
ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

-- ket qua 4
SELECT first_name,
	AVG(IFNULL(grade, 0)) AS average,
    CASE 
		WHEN AVG(IFNULL(grade,0)) >= 75 THEN 'PASSING'
		ELSE 'FAILING'
    END AS passing_status
FROM students LEFT JOIN papers 
ON students.id = papers.student_id
GROUP BY students.id, first_name
ORDER BY average DESC;