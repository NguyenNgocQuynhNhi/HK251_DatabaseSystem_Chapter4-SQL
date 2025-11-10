GO
CREATE TABLE BOOK_LOANS_Cau6 (
    Book_id INT,
    Branch_id INT,
    Card_no INT,
    Date_out DATE,
    Due_date DATE
);

INSERT INTO BOOK_LOANS_Cau6 (Book_id, Branch_id, Card_no, Date_out, Due_date) VALUES
(1, 1, 101, '2025-10-20', '2025-11-03'),
(5, 2, 101, '2025-10-20', '2025-11-03'),
(10, 1, 102, '2025-10-21', '2025-11-04'),
(1, 3, 102, '2025-10-21', '2025-11-04'),
(20, 2, 103, '2025-10-22', '2025-11-05'),
(5, 1, 103, '2025-10-22', '2025-11-05'),
(1, 3, 101, '2025-10-23', '2025-11-06'),
(20, 3, 104, '2025-10-23', '2025-11-06');

SELECT * FROM BOOK_LOANS_Cau6;  -- for test

GO
CREATE PROCEDURE CountBooksByReader_Cau6 
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Card_no, COUNT(DISTINCT Book_id) AS Number_of_Books_Borrowed
    FROM BOOK_LOANS_Cau6 
    WHERE Date_out >= '2025-10-01' AND Date_out <= '2025-12-31'
    GROUP BY Card_no
    HAVING COUNT(DISTINCT Book_id) > 2
    ORDER BY Number_of_Books_Borrowed DESC;
END;