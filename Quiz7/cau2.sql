GO
CREATE TABLE Customer (
    SSN     VARCHAR(10),
    PhoneNumber VARCHAR(11),
    PRIMARY KEY (SSN)
);

GO
CREATE TABLE    Phone_Call (
    SSN     VARCHAR(10),
    CallingDate DATE,
    CallingTime TIME(7),
    CalledNum   VARCHAR(11),
    Seconds INT, 
    UnitPrice   INT, 
    Amount      INT, 
    PRIMARY KEY(SSN, CallingDate, CallingTime), 
    FOREIGN KEY(SSN) REFERENCES Customer(SSN)
);

GO
CREATE VIEW V_Calling_History AS 
SELECT SSN, CallingDate, CallingTime, CalledNum, Seconds
FROM    Phone_Call;

GO
CREATE TRIGGER t_Phone_Call_Insert
ON  V_Calling_History
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @p_ssn AS VARCHAR(10),
            @p_callingDate AS DATE, 
            @p_callingTime AS TIME(7), 
            @p_calledNum   AS VARCHAR(11), 
            @p_seconds     AS INT;
    SELECT  @p_ssn = SSN, 
            @p_callingDate = CallingDate, 
            @p_callingTime = CallingTime, 
            @p_seconds = Seconds 
    FROM    inserted;
IF (NOT EXISTS (SELECT * FROM inserted, Customer as C
    WHERE inserted.CalledNum = C.PhoneNumber))
    INSERT INTO Phone_Call VALUES (@p_ssn, @p_callingDate, @p_callingTime, @p_calledNum,
    @p_seconds, 1000, @p_seconds * 1000);
ELSE
    IF (@p_seconds > 60)
        INSERT INTO Phone_Call VALUES (@p_ssn, @p_callingDate, @p_callingTime,
        @p_calledNum, @p_seconds, 1000, (@p_seconds - 60) * 1000);
END;

-- DROP TRIGGER t_Phone_Call_Insert;
-- GO

GO
INSERT INTO Customer VALUES ('1234567890', '0702331331');
INSERT INTO Customer VALUES ('1234567891', '0702332332');
INSERT INTO Customer VALUES ('1234567892', '0702333333');
SELECT * FROM Customer;     -- for test

GO
INSERT INTO V_Calling_History
VALUES ('1234567890', '01-12-2024', '07:30', '0702332332', 12);
INSERT INTO V_Calling_History
VALUES ('1234567891', '02-12-2024', '05:30', '0702331331', 80);
INSERT INTO V_Calling_History
VALUES ('1234567892', '02-12-2024', '05:30', '0902222222', 50);
SELECT * FROM V_Calling_History;    --for test




