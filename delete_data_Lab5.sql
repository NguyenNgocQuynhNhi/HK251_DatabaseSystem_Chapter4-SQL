-- Viết câu lệnh để xoá các dữ liệu sau: 
-- a. Xóa những thân nhân của nhân viên có tên là “Alice". 
DELETE FROM DEPENDENT
WHERE   Essn IN (SELECT Ssn
                FROM    EMPLOYEE
                WHERE   Fname = 'Alice');

-- b. Xóa dự án “Product Z”. 
DELETE FROM WORKS_ON
WHERE   Pno IN (SELECT Pnumber
                FROM    PROJECT
                WHERE   Pname = 'Product Z');

DELETE FROM PROJECT
WHERE   Pname = 'Product Z';