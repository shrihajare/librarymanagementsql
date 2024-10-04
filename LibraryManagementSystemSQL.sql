-- Create Authors Table
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT
);

-- Create Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    Genre VARCHAR(50),
    ISBN VARCHAR(20),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Create Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    JoinDate DATE
);

-- Create Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert Sample Authors
INSERT INTO Authors (Name, Bio) VALUES 
('J.K. Rowling', 'British author, best known for the Harry Potter series.'),
('George R.R. Martin', 'American novelist and short story writer, known for A Song of Ice and Fire.');

-- Insert Sample Books
INSERT INTO Books (Title, AuthorID, Genre, ISBN) VALUES 
('Harry Potter and the Sorcerer\'s Stone', 1, 'Fantasy', '978-0-7432-1650-3'),
('A Game of Thrones', 2, 'Fantasy', '978-0-553-10354-0');

-- Insert Sample Members
INSERT INTO Members (Name, JoinDate) VALUES 
('Alice Smith', '2023-01-15'),
('Bob Johnson', '2023-02-20');

-- Insert Sample Transactions
INSERT INTO Transactions (MemberID, BookID, BorrowDate, ReturnDate) VALUES 
(1, 1, '2023-09-01', NULL),  -- Alice borrowed Harry Potter
(2, 2, '2023-09-10', '2023-09-15');  -- Bob borrowed A Game of Thrones and returned it

SELECT B.Title, A.Name AS Author, B.Genre
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID;

SELECT M.Name AS MemberName, B.Title AS BookTitle, T.BorrowDate, T.ReturnDate
FROM Transactions T
JOIN Members M ON T.MemberID = M.MemberID
JOIN Books B ON T.BookID = B.BookID;

SELECT T.TransactionID, B.Title, T.BorrowDate, T.ReturnDate
FROM Transactions T
JOIN Books B ON T.BookID = B.BookID
WHERE T.MemberID = 1;  -- Change to any MemberID to filter by member

SELECT Genre, COUNT(*) AS BookCount
FROM Books
GROUP BY Genre;
