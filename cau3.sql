GO
CREATE TABLE PhoneCall_Cau3 (
    SSN varchar(10),
    CallingDate date,
    CallingTime time(7),
    CalledNum varchar(11),
    Seconds int,
    UnitPrice int,
    Amount int,
    PRIMARY KEY (SSN, CallingDate, CallingTime)
);

INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('1112223330', '2022-11-05', '08:00', '0777666555', 60, 90, 5400);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('1112223330', '2022-11-06', '19:30', '0444333222', 180, 90, 16200);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('9876543210', '2023-01-15', '09:15', '0123456789', 300, 80, 24000);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('9876543210', '2023-01-15', '11:45', '0999888777', 150, 80, 12000);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('1234567890', '2024-03-10', '12:00', '0111222333', 240, 100, 24000);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('9876543210', '2024-05-20', '16:10', '0555666777', 75, 80, 6000);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('1234567890', '2024-10-25', '10:30', '0987654321', 120, 100, 12000);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('1234567890', '2024-10-26', '18:20', '0333444555', 45, 100, 4500);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('5554443330', '2025-03-01', '14:45', '0909111222', 90, 120, 10800);
INSERT INTO PhoneCall_Cau3 (SSN, CallingDate, CallingTime, CalledNum, Seconds, UnitPrice, Amount)
VALUES
('5554443330', '2025-03-01', '15:00', '0888999000', 30, 120, 3600);

-- SELECT * FROM PhoneCall_Cau3;   --for test

GO
CREATE FUNCTION f_calculate_total (@p_year INT)
RETURNS INT AS
BEGIN
    DECLARE @total_amount AS INT;
    SELECT @total_amount = sum(Amount) FROM PhoneCall_Cau3
    WHERE YEAR(CallingDate) <= @p_year;
    RETURN @total_amount;
END;

GO
SELECT dbo.f_calculate_total(2024);