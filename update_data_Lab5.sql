-- Viết câu lệnh để cập nhật các dữ liệu sau: 
-- a. Nhân viên có mã là “123456789” thay đổi địa chỉ thành “123 Lý Thường Kiệt F.14 Q.10”.
UPDATE  EMPLOYEE
SET     Address = N'123 Lý Thường Kiệt F.14 Q.10'
WHERE   Ssn = '123456789'; 

-- b. Mối quan hệ của nhân viên “Franklin” với người phụ thuộc “Joy” thay đổi thành “Friend”.
UPDATE  DEPENDENT
SET     Relationship = 'Friend'
WHERE   Dependent_name = 'Joy' AND Essn IN (SELECT Ssn FROM EMPLOYEE WHERE Fname = 'Franklin');

-- c. Tất cả nhân viên của phòng ban có ít nhất một vị trí ở “Houston” được tăng lương gấp đôi. 
-- d. Trừ 5% lương cho các nhân viên có tổng số dự án tham gia ít hơn 2.