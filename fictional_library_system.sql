CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Table for authors
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Table for genres
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(50)
);

-- Table for books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    GenreID INT,
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);


-- Insert authors
INSERT INTO Authors (FirstName, LastName) VALUES ('George', 'Orwell');
INSERT INTO Authors (FirstName, LastName) VALUES ('J.K.', 'Rowling');
INSERT INTO Authors (FirstName, LastName) VALUES ('J.R.R.', 'Tolkien');

-- Insert genres
INSERT INTO Genres (GenreName) VALUES ('Dystopian');
INSERT INTO Genres (GenreName) VALUES ('Fantasy');
INSERT INTO Genres (GenreName) VALUES ('Science Fiction');

-- Insert books
INSERT INTO Books (Title, AuthorID, GenreID, PublishedYear) VALUES ('1984', 1, 1, 1949);
INSERT INTO Books (Title, AuthorID, GenreID, PublishedYear) VALUES ('Harry Potter and the Philosopher\'s Stone', 2, 2, 1997);
INSERT INTO Books (Title, AuthorID, GenreID, PublishedYear) VALUES ('The Hobbit', 3, 2, 1937);


-- List all books with their authors and genres
SELECT 
    b.Title,
    CONCAT(a.FirstName, ' ', a.LastName) AS Author,
    g.GenreName,
    b.PublishedYear
FROM 
    Books b
JOIN 
    Authors a ON b.AuthorID = a.AuthorID
JOIN 
    Genres g ON b.GenreID = g.GenreID;

-- Find all books by a specific author
SELECT 
    Title 
FROM 
    Books 
WHERE 
    AuthorID = (SELECT AuthorID FROM Authors WHERE LastName = 'Rowling');

-- Count the number of books in each genre
SELECT 
    g.GenreName, 
    COUNT(b.BookID) AS NumberOfBooks
FROM 
    Genres g
LEFT JOIN 
    Books b ON g.GenreID = b.GenreID
GROUP BY 
    g.GenreName;

-- Update a book's published year
UPDATE 
    Books 
SET 
    PublishedYear = 2024 
WHERE 
    Title = 'The Hobbit';

-- Delete a book
DELETE FROM 
    Books 
WHERE 
    Title = '1984';
