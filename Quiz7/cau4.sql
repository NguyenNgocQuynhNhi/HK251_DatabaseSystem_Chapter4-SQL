GO
CREATE TABLE BOOK_LOANS (
    Book_id INT NOT NULL,
    Branch_id INT NOT NULL,
    Card_no INT NOT NULL,
    Date_out DATE,
    Due_date DATE,
    PRIMARY KEY (Book_id, Branch_id, Card_no)
);

INSERT INTO BOOK_LOANS (Book_id, Branch_id, Card_no, Date_out, Due_date) VALUES
(1000, 1, 101, '2025-09-20', '2025-10-03'),
(1001, 2, 102, '2025-09-20', '2025-10-03'),
(1002, 3, 103, '2025-09-20', '2025-10-03'),
(1000, 1, 102, '2025-09-20', '2025-10-03'),
(1001, 2, 103, '2025-09-20', '2025-10-03'),
(1002, 3, 101, '2025-09-20', '2025-10-03'),
(1000, 1, 103, '2025-10-20', '2025-11-03'),
(1001, 2, 101, '2025-10-20', '2025-11-03'),
(1002, 3, 102, '2025-10-20', '2025-11-03'),
(2000, 1, 101, '2025-10-20', '2025-11-03');
SELECT * FROM BOOK_LOANS;

GO
CREATE PROCEDURE GetTopReaders
AS
BEGIN
    SELECT distinct B1.Branch_id, B1.Card_no, COUNT(DISTINCT Book_id)
    FROM BOOK_LOANS B1 
    GROUP BY B1.Branch_id, B1.Card_no 
    HAVING COUNT(DISTINCT Book_id) =
        (
            SELECT MAX(CountBooks)
            FROM (SELECT Count(Distinct Book_id) AS CountBooks 
                FROM BOOK_LOANS B2 
                WHERE B1.Branch_id = B2.Branch_id 
                GROUP BY B2.Branch_id, B2.Card_no) as T1
        );
END;

EXEC GetTopReaders;