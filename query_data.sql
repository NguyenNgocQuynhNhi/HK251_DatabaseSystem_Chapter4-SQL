-- a. Hiển thị tên nhân viên, mã phòng ban, lương của nhân viên có lương từ 1000 đến 2000. 
SELECT  ENAME, DEPTNO, SAL  
FROM    EMP
WHERE   SAL  BETWEEN 1000 AND 2000;

-- b. Hiển thị mã phòng ban, tên phòng ban, sắp xếp theo thứ tự tên phòng ban. 
SELECT  DEPTNO, DNAME
FROM            DEPT
ORDER BY        DNAME

-- c. Hiển thị mã nhân viên, tên nhân viên của phòng ban có mã là 10 hoặc 20. 
SELECT  EMPNO, ENAME
FROM    EMP
WHERE   DEPTNO = 10 OR DEPTNO = 20;

-- d. Hiển thị tên nhân viên, nghề nghiệp của nhân viên có nghề là ‘CLERK’, thuộc phòng ban có mã số là 20 
SELECT  ENAME, JOB  
FROM    EMP
WHERE   JOB = 'CLERK' AND DEPTNO = 20;

-- e. Hiển thị mã nhân viên, tên nhân viên của nhân viên có tên có chứa chuỗi ‘TH’ hay ‘LL’. 
SELECT  EMPNO, ENAME 
FROM    EMP
WHERE   ENAME LIKE '%TH%' OR ENAME LIKE '%LL%';

-- f. Hiển thị tên nhân viên, nghề nghiệp, lương của những nhân viên có giám đốc quản lý. 
SELECT ENAME, JOB, SAL
FROM EMP
WHERE MGR IS NOT NULL;

-- g. Hiển thị tên nhân viên, mã phòng ban, ngày gia nhập công ty sao cho gia nhập công ty trong năm 1983. 
SELECT  ENAME, DEPTNO, HIREDATE 
FROM    EMP 
WHERE   YEAR(HIREDATE) = 1983;

-- h. Hiển thị tên nhân viên, ngày gia nhập công ty, ngày xét nâng lương (sau ngày gia nhập công ty 1 
--năm), sắp xếp theo thứ tự ngày xét nâng lương. 
SELECT  ENAME, HIREDATE, DATEADD(YEAR, +1, HIREDATE) AS UpSalDate
FROM    EMP
ORDER BY  UpSalDate;  

-- i. Tìm lương thấp nhất, lớn nhất và lương trung bình trong tất cả nhân viên. 
SELECT  MIN(SAL) AS MinSal, MAX(SAL) AS MaxSal, AVG(SAL) AS AvgSal
FROM    EMP;

-- j.  Tìm lương nhỏ nhất và lớn nhất của mỗi loại nghề nghiệp. 
SELECT  JOB, MIN(SAL) AS MinSal, MAX(SAL) AS MaxSal
FROM    EMP
GROUP BY    JOB;

-- k. Tìm xem có bao nhiêu giám đốc trong danh sách nhân viên. 
SELECT  COUNT(*) AS NumOfManagers
FROM    EMP
WHERE   JOB = 'MANAGER';

-- l. Tìm tất cả các phòng ban mà số nhân viên trong phòng >3. 
SELECT  DEPTNO
FROM    EMP
GROUP BY    DEPTNO
HAVING  COUNT(*) > 3;

-- m. Tìm ra mức lương của mỗi nhân viên làm việc cho một giám đốc nào đó sắp xếp theo thứ tự tăng 
--dần của mức lương. 
SELECT  EMPNO, ENAME, MGR, SAL
FROM    EMP
WHERE   MGR IS NOT NULL
ORDER BY    SAL;

-- n. Hiển thị tên nhân viên, vị trí địa lý, tên phòng với điều kiện lương >1500. 
SELECT  ENAME, LOC, DNAME
FROM    EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE   SAL > 1500;

SELECT E.ENAME, D.LOC, D.DNAME
FROM EMP AS E 
JOIN DEPT AS D ON E.DEPTNO = D.DEPTNO
WHERE E.SAL > 1500;

-- o. Hiển thị tên nhân viên , nghề nghiệp, lương, mức lương, tên phòng làm việc trừ nhân viên có nghề là 
--cleck và sắp xếp theo chiều giảm của lương. 

-- p. Hiển thị nghề nghiệp được tuyển dụng vào năm 1981 và không được tuyển dụng vào năm 1994. 

-- q. Tìm những nhân viên gia nhập công ty trước giám đốc của họ.