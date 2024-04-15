USE twhitmar_cs355sp23;

-- List the top rated books by their average review score with descending score
DROP VIEW IF EXISTS top_rating;
CREATE OR REPLACE VIEW top_rating AS
	SELECT Title, Author_Name AS Author, AVG(Rating) AS Average_Rating 
    FROM BD_Review 
    GROUP BY Title, Author_Name
    ORDER BY AVG(Rating) DESC;

-- List the average review of each book. If a book has no review display null
DROP VIEW IF EXISTS ratings_View;
CREATE OR REPLACE VIEW ratings_View AS
	SELECT b.Title, b.Author_name AS Author, AVG(rating) AS Average_Rating 
	FROM BD_Book AS b 
    LEFT JOIN BD_Review AS r
    ON b.Title LIKE r.Title AND b.Author_Name LIKE r.Author_Name
    GROUP BY b.Title, b.Author_name;

-- List the total awards each Author has won for all of their books combined
-- Only list Author with at least one award
DROP VIEW IF EXISTS total_Awards;
CREATE OR REPLACE VIEW total_Awards AS 
	SELECT a.Author_name, SUM(FN_NUMAWARDS(a.Title,a.Author_name)) AS 'Total awards'
	FROM BD_Book AS a 
	GROUP BY Author_name
    HAVING `Total awards` > 0
	ORDER BY `Total awards` DESC;
    
-- List the average review for each Author
-- only List Author with at least one review
DROP VIEW IF EXISTS average_review;
CREATE VIEW average_review AS
	SELECT A.Name AS Author, AVG(R.Rating) AS AverageReview
	FROM BD_Author A
	JOIN BD_Book B ON A.Name = B.Author_Name
	JOIN BD_Review R ON B.Title = R.Title AND B.Author_Name = R.Author_Name
	GROUP BY A.Name
	HAVING COUNT(R.Rating) >= 1
    ORDER BY AverageReview DESC;

-- List all books that have no reviews or awards    
DROP VIEW IF EXISTS no_Reviews_Awards;
CREATE OR REPLACE VIEW no_Reviews_Awards AS
	(SELECT title, Author_Name FROM BD_Book)
    EXCEPT
    (SELECT title, Author_name FROM BD_Review)
    EXCEPT
    (SELECT title, Author_name FROM BD_Award);

-- List the total awards each book has won
-- only include books that have won an award    
DROP VIEW IF EXISTS book_TotalAwards;
CREATE OR REPLACE VIEW book_TotalAwards AS
	SELECT Title, Author_name, COUNT(name) AS Total_awards
    FROM BD_Award
    GROUP BY Title, Author_name;
 
 
-- List all books that have won and award and have been reviewed
-- List the total number of awards it has won as well as the average review
DROP VIEW IF EXISTS award_and_Review;
CREATE OR REPLACE VIEW award_and_Review AS
	SELECT DISTINCT b.Title, b.Author_Name, v.Average_Rating, t.Total_awards 
    FROM BD_Book AS b
    JOIN BD_Award AS a 
    ON b.Title LIKE a.Title AND b.Author_Name LIKE a.Author_name
    JOIN BD_Review AS r
    ON b.Title LIKE r.Title AND b.Author_Name LIKE r.Author_Name
    JOIN ratings_View AS v
    ON b.Title LIKE v.Title AND b.Author_Name LIKE v.Author
    JOIN book_TotalAwards AS t
    ON b.Title LIKE t.Title AND b.Author_Name LIKE t.Author_Name;

-- Function that returns the total number of awards a book has won
DROP FUNCTION IF EXISTS fn_NumAwards;
DELIMITER //
CREATE FUNCTION fn_NumAwards (
_title VARCHAR(255), _author VARCHAR(255)
)
RETURNS INT
BEGIN
	DECLARE Awards INT;
    SELECT COUNT(Name) 
    INTO Awards
    FROM BD_Award
    WHERE Author_name LIKE _author AND Title LIKE _title;
    IF Awards IS NULL THEN
		SET Awards = 0;
	END IF;
	RETURN Awards;
END //
DELIMITER ;

-- Function that returns the best reviewed book by and author
DROP FUNCTION IF EXISTS fn_GetBestReviewed;
DELIMITER //
CREATE FUNCTION fn_GetBestReviewed(_authorName VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
    DECLARE bestBook VARCHAR(255);
    
    SELECT R.Title INTO bestBook
    FROM BD_Review R
    WHERE R.Author_Name = _authorName
    GROUP BY R.Title, R.Author_Name
    ORDER BY AVG(R.Rating) DESC
    LIMIT 1;
    
    RETURN bestBook;
END //
DELIMITER ;


-- Procedure that lists out other books written by the author given in the parameter
-- As well as the average review of those books. Displays N/A if no reveiw is found
DROP PROCEDURE IF EXISTS pr_otherBooks;
Delimiter // 
CREATE PROCEDURE pr_otherBooks(_author VARCHAR(255))
BEGIN
	SELECT Title, COALESCE(Average_Rating, 'N/A') AS Average_Rating
    FROM ratings_View
    WHERE Author LIKE _author;
END //
DELIMITER ; 


-- Used to update the publisher Penguin Books to Pengium Random house due to a name change
UPDATE BD_Publisher
SET
	Name = 'Penguin Random House'
WHERE Name IN
	(SELECT Name 
    FROM BD_Publisher
    WHERE Name LIKE 'Penguin Books');
	

-- Lists all books that have an average rating of 4 or greater
SELECT *
FROM BD_Book b 
WHERE EXISTS 
(SELECT Title, Author_Name
FROM top_rating r 
WHERE r.Title LIKE b.Title AND
r.Author LIKE b.Author_Name AND 
r.Average_Rating >= 4); 


-- Lists all Readers in the database that are also Authors
SELECT * FROM BD_Author
WHERE Name IN 
(SELECT Name FROM BD_Reader);

