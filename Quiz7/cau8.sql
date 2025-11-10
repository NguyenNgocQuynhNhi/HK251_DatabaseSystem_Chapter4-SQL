GO
CREATE TABLE tbBOOK_LOANS (
    Book_id INT NOT NULL,
    Card_no INT NOT NULL,
    Date_out DATE,
    Return_date DATE,
    PRIMARY KEY (Book_id, Card_no)
);

GO
CREATE TRIGGER t_Book_Loans_Ins
ON tbBOOK_LOANS
FOR INSERT
AS
BEGIN
    IF (EXISTS (SELECT * FROM inserted as i, tbBOOK_LOANS as tb
                WHERE tb.card_no = i.card_no and tb.book_id != i.book_id and tb.return_date is null))
    BEGIN
        RAISERROR('Nguoi doc chua tra sach nen khong muon tiep duoc', 16, 1);
        ROLLBACK;
    END
END;

GO
INSERT INTO tbBOOK_LOANS (Book_id, Card_no, Date_out, Return_date)
VALUES (101, 2001, '2025-10-01', '2025-10-01');

INSERT INTO tbBOOK_LOANS (Book_id, Card_no, Date_out, Return_date)
VALUES (102, 2002, '2025-10-03', '2025-10-03');

INSERT INTO tbBOOK_LOANS (Book_id, Card_no, Date_out)
VALUES (103, 2001, '2025-10-20');

INSERT INTO tbBOOK_LOANS (Book_id, Card_no, Date_out)
VALUES (104, 2001, '2025-10-25');

INSERT INTO tbBOOK_LOANS (Book_id, Card_no, Date_out)
VALUES (102, 2002, '2025-10-25');

SELECT * FROM tbBOOK_LOANS;