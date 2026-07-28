USE book_data;

SELECT * FROM books 
ORDER BY pages DESC
LIMIT 1;

SELECT * FROM books 
ORDER BY released_year DESC
LIMIT 3;

SELECT title, author_lname FROM books 
WHERE author_lname LIKE '% %';

SELECT  title, released_year,stock_quantity FROM books 
ORDER BY stock_quantity ASC 
LIMIT 3;

SELECT title, author_lname FROM books 
ORDER BY author_lname, title;
	

