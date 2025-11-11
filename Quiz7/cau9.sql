GO
CREATE TABLE tbBOOK_LOANS_Cau9 (
    Book_id INT NOT NULL,
    Card_no INT NOT NULL,
    Date_out DATE,
    Return_date DATE,
    PRIMARY KEY (Book_id, Card_no)
);

GO
CREATE VIEW v_NotReturned AS
    SELECT Book_id, Card_no, Date_out, Return_date 
    FROM tbBOOK_LOANS_Cau9
    WHERE Return_date IS NULL WITH CHECK OPTION;

GO
INSERT INTO v_NotReturned VALUES (1, 101, '2025-10-20', '2025-10-30');
INSERT INTO v_NotReturned VALUES (1, 102, NULL, '2025-10-30');
INSERT INTO v_NotReturned VALUES (1, 103, '2025-10-30', NULL);
INSERT INTO v_NotReturned VALUES (1, 104, NULL, NULL);


