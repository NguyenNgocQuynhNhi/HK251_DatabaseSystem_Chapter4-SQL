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

-- Cách 1: Dùng CTE (Common Table Expressions) - Dễ đọc nhất
-- Bước 1: Tạo "Bảng điểm"
WITH Scoreboard AS (
    SELECT 
        Branch_id, 
        Card_no, 
        COUNT(DISTINCT Book_id) AS CountBooks
    FROM BOOK_LOANS
    GROUP BY Branch_id, Card_no
),

-- Bước 2: Tìm "Điểm cao nhất" cho mỗi chi nhánh
MaxScores AS (
    SELECT 
        Branch_id, 
        MAX(CountBooks) AS MaxCount
    FROM Scoreboard
    GROUP BY Branch_id
)

-- Bước 3: Ghép 2 bảng đó lại để tìm người thắng cuộc
SELECT 
    S.Branch_id, 
    S.Card_no, 
    S.CountBooks
FROM Scoreboard AS S
JOIN MaxScores AS M 
    ON S.Branch_id = M.Branch_id 
   AND S.CountBooks = M.MaxCount;

-- Cách 2: Dùng Hàm cửa sổ (Window Functions) - Hiệu quả nhất
WITH RankedScores AS (
    SELECT 
        Branch_id, 
        Card_no, 
        COUNT(DISTINCT Book_id) AS CountBooks,
        -- Xếp hạng độc giả TRONG TỪNG CHI NHÁNH (PARTITION BY)
        DENSE_RANK() OVER(PARTITION BY Branch_id 
                          ORDER BY COUNT(DISTINCT Book_id) DESC) AS Rank
    FROM BOOK_LOANS
    GROUP BY Branch_id, Card_no
)

-- Bây giờ chỉ cần chọn tất cả những ai có Rank = 1
SELECT 
    Branch_id, 
    Card_no, 
    CountBooks
FROM RankedScores
WHERE Rank = 1;