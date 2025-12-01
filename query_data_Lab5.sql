-- a. Truy xuất tên của những nhân viên nhỏ hơn 30 tuổi mà có mức lương lớn hơn 10.000 $.
SELECT  Fname, Minit, Lname
FROM    EMPLOYEE
WHERE   Employee.salary > 10000 AND Bdate > DATEADD(YEAR, -30, GETDATE());
-- b. Truy xuất các name của tất cả employee có sex là male trong Department “Research” mà làm cho   
-- ít nhất một project nhiều hơn 10 giờ một tuần. 
WITH    Male_Research AS (
    SELECT  Ssn, Fname, Minit, Lname
    FROM    EMPLOYEE JOIN DEPARTMENT ON EMPLOYEE.Dno = DEPARTMENT.Dnumber
    WHERE   Sex = 'M' AND DEPARTMENT.Dname = 'Research'
)

SELECT  Fname, Minit, Lname
FROM    Male_Research JOIN WORKS_ON ON Male_Research.Ssn = WORKS_ON.Essn
WHERE   WORKS_ON.HoursWork > 10;


-- c. Truy xuất tên của nhân viên là manager của phòng ban “Research”.
SELECT  Fname, Minit, Lname
FROM    EMPLOYEE JOIN DEPARTMENT ON Dno = Dnumber
WHERE   Dname = 'Research' AND Ssn = Mgr_ssn;

-- d. Tìm tên của tất cả employee được giám sát trực tiếp bởi manager của phòng ban “Research”. 
WITH    Mgr_Research AS (
    SELECT  Mgr_ssn, Fname, Minit, Lname
    FROM    EMPLOYEE JOIN DEPARTMENT ON Dno = Dnumber
    WHERE   Dname = 'Research' AND Ssn = Mgr_ssn
)

SELECT  EMPLOYEE.Fname, EMPLOYEE.Minit, EMPLOYEE.Lname
FROM    Mgr_Research, EMPLOYEE
WHERE   EMPLOYEE.Super_ssn = Mgr_Research.Mgr_ssn;

-- e. Với mỗi project, liệt kê tên project, và tổng số giờ một tuần mà tất cả nhân viên phải làm cho 
-- project đó. 
SELECT  Pname, SUM(HoursWork) AS TotalHours
FROM    PROJECT JOIN WORKS_ON ON Pnumber = Pno
GROUP BY    Pname

-- f. Với mỗi phòng ban, liệt kê tên phòng ban và tên của tất cả các employee làm việc cho phòng ban đó.
SELECT  Dname, EMPLOYEE.Fname, EMPLOYEE.Minit, EMPLOYEE.Lname
FROM    EMPLOYEE JOIN DEPARTMENT ON Dno = Dnumber
ORDER BY    Dno, Dname;

-- g. Liệt kê tên của tất cả employee không làm bất cứ project nào ở “Houston”. 

WITH    Project_Houston AS ( 
    SELECT  Ssn, Fname, Minit, Lname
    FROM    EMPLOYEE AS E JOIN WORKS_ON AS W ON E.Ssn = W.Essn
                        JOIN PROJECT AS P ON P.Pnumber = W.Pno
    WHERE   Plocation = 'Houston'
)

SELECT  Fname, Minit, Lname
FROM    EMPLOYEE
WHERE   EMPLOYEE.Ssn NOT IN (SELECT Ssn FROM Project_Houston);

    -- h. Liệt kê tên của tất cả employee làm việc cho tất cả các project ở “Houston”. 

    SELECT  Fname, Minit, Lname
    FROM    EMPLOYEE AS E JOIN WORKS_ON AS W ON E.Ssn = W.Essn
                        JOIN    PROJECT AS P ON P.Pnumber = W.Pno
    WHERE   Plocation = 'Houston'
    GROUP BY    E.Ssn, E.Fname, E.Minit, E.Lname
    HAVING  COUNT(*) = (SELECT  COUNT(*)    
                        FROM    PROJECT     
                        WHERE   Plocation = 'Houston');

-- i. Tìm các employee có tổng số dự án tham gia nhiều nhất trong công ty. 
WITH    CountProjects AS (
    SELECT      Essn, COUNT(*) AS TheNumberOfProjects
    FROM        WORKS_ON
    GROUP BY    Essn
)

SELECT  Fname, Minit, Lname
FROM    EMPLOYEE AS E JOIN CountProjects ON E.Ssn = CountProjects.Essn
WHERE   TheNumberOfProjects = (SELECT  MAX(TheNumberOfProjects)
                    FROM    CountProjects);


-- SELECT  E.Fname, E.Minit, E.Lname
-- FROM    EMPLOYEE AS E JOIN WORKS_ON AS W ON E.Ssn = W.Essn
-- GROUP BY    E.Ssn, E.Fname, E.Minit, E.Lname
-- HAVING  MAX(COUNT(Pno));

-- j. Liệt kê tên các employee có lương cao nhất trong mỗi phòng ban. 
-- k. Với mỗi phòng ban, tìm các employee có tổng số dự án tham gia nhiều nhất trong phòng ban đó. 
-- l. Liệt kê last name của tất cả các manager của các department nhưng không tham gia project nào. 