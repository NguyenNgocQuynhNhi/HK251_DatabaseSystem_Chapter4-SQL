CREATE PROCEDURE CalcDiscount @total MONEY, @discount MONEY OUTPUT
AS
IF @total >= 500
   SET @discount = @total * 0.1
ELSE
   SET @discount = 0

DECLARE @d MONEY = 8
EXEC CalcDiscount 800, @d OUTPUT

GO
-- 2. Khối lệnh để thực thi và xem kết quả
DECLARE @d MONEY = 8
EXEC CalcDiscount 800, @d OUTPUT
SELECT @d AS Ket_Qua_Cua_d; -- <-- Đây là cách xem kết quả