--Query 0: Retrieve the birthdate and address of the employee whose name is 'John B.Smith'.
SELECT  Bdate, Address
FROM    EMPLOYEE
WHERE   Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

--Query 1: Retrieve the name and address of all employees who work for the 'Research' department.
SELECT  Fname, Minit, Lname, Address
FROM    EMPLOYEE, DEPARTMENT
WHERE   Dname = 'Research' AND Dnumber = Dno;   
-- Neu thieu dieu kien Dnumber = Dno la sai vi FROM se tao 1 bang la tich Decac cua EMPLOYEE va DEPARTMENT, 
-- tuc la no se ghep moi nhan vien voi moi phong ban 
-- sau do tim trong bang do cac hang co Dname = Research
-- => do do neu k co dkien Dnumber = Dno thi ket qua se tra ve tat ca nhan vien, ke ca nhan vien k lam viec o phong ban Research

SELECT  E.Fname, E.Minit, E.Lname, E.Address
FROM    EMPLOYEE AS E
JOIN    DEPARTMENT AS D ON E.Dno = D.Dnumber
WHERE   D.Dname = 'Research';

--Query 2: For every project located in 'Stafford', 
--          list the project number, the controlling department, 
--          and the department manager's lastname, address, and birthdate
SELECT  Pnumber, Dnum, Dname, Lname, Address, Bdate
FROM    PROJECT, EMPLOYEE, DEPARTMENT
WHERE   Dnum = Dnumber AND Mgr_ssn = Ssn AND Plocation = 'Standford';

SELECT  P.Pnumber, D.Dnumber, D.Dname, E.Lname, E.Address, E.Bdate
FROM    PROJECT AS P 
JOIN    DEPARTMENT AS D ON P.Dnum = D.Dnumber
JOIN    EMPLOYEE AS E ON E.Ssn = D.Mgr_ssn
WHERE   P.Plocation = 'Standford';

--Query 3: For each employee, retrieve the employee's name, 
--          and the name of his or her immediate supervisor.
SELECT  E.Fname, E.Minit, E.Lname, S.Fname, S.Minit, S.Lname
FROM    EMPLOYEE AS E, EMPLOYEE AS S
WHERE   E.Super_ssn = S.Ssn;

SELECT  E.Fname AS E_FirstName, E.Minit AS E_Minit, E.Lname AS E_Lastname, 
        S.Fname AS S_Firstname, S.Minit AS S_Minit, S.Lname AS S_Lastname
FROM    EMPLOYEE AS E, EMPLOYEE AS S
WHERE   E.Super_ssn = S.Ssn;

--Query 4: Retrieve the SSN values for all employees
SELECT  Ssn
FROM    EMPLOYEE;

--Query 5: Retrieve all combinations Employee.SSN and Department.Dname
SELECT  E.Ssn, D.Dname
FROM    EMPLOYEE AS E, DEPARTMENT AS D; 

--Query 6: Retrieves all the attribute values of any Employee who works in Department number 5
SELECT  *
FROM    EMPLOYEE
WHERE   Dno = 5;

--Query 7: retrieves all the attributes of an Employee 
--and the attributes of the Department in which he or she works for the 'Research' Department
SELECT *
FROM    EMPLOYEE AS E
JOIN    DEPARTMENT AS D ON E.Dno = D.Dnumber
WHERE   D.Dname = 'Research';

--Query 8: Retrieve the salary of every employee (Q8A)
-- and all distinct salary values (Q8B)
SELECT  Salary
FROM    EMPLOYEE;

SELECT  DISTINCT Salary
FROM    EMPLOYEE;   
-- ==> khong co hang trung nhau va duoc sap xep theo thu tu tang dan

--Query 9: Make a list of all project numbers 
--for projects that involves an employee whose lastname is 'Smith' 
--as a worker or as a manager of the department that controls the project

( SELECT DISTINCT Pnumber
FROM PROJECT, DEPARTMENT, EMPLOYEE
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn
    AND Lname = 'Smith' )
UNION
( SELECT DISTINCT Pnumber 
FROM PROJECT, WORKS_ON, EMPLOYEE
WHERE Pnumber = Pno AND Essn = Ssn
        AND Lname = 'Smith' );


(SELECT  P.Pnumber
FROM    PROJECT AS P 
JOIN    DEPARTMENT AS D ON P.Dnum = D.Dnumber
JOIN    EMPLOYEE AS E ON E.Ssn = D.Mgr_ssn
WHERE   E.Lname = 'Smith')
UNION
(SELECT  P.Pnumber
FROM    PROJECT AS P 
JOIN    WORKS_ON AS W ON P.Pnumber = W.Pno
JOIN    EMPLOYEE AS E ON E.Ssn = W.Essn
WHERE   E.Lname = 'Smith');

--Query 10: Retrieve all employees whose address is in Houston, Texas.
SELECT  *
FROM    EMPLOYEE AS E  
WHERE   E.Address LIKE '%Houston, TX%';

--Query 11: Retrieve all employees whose SSN has '89' at the end.
SELECT *
FROM    EMPLOYEE
WHERE   Ssn LIKE '_______89';   -- 7 charaters _

SELECT  *
FROM    EMPLOYEE AS E  
WHERE   E.Ssn LIKE '%89';

--Query 12: show the resulting salaries if every employee working on "ProductX" is given 10% raise
SELECT  Fname, Lname, Salary, 1.1 * Salary AS NewSalary
FROM    PROJECT AS P
JOIN    WORKS_ON AS W ON P.Pnumber = W.Pno  
JOIN    EMPLOYEE AS E ON E.Ssn = W.Essn
WHERE   P.Pname = 'ProductX';

SELECT  Fname, Lname, 1.1 * Salary AS INC_SAL 
FROM    EMPLOYEE, WORKS_ON, PROJECT
WHERE   Ssn = Essn AND Pno = Pnumber AND Pname = 'ProductX';

--Query 13: Retrieve the name and address of all employees who work for the 'Research' department
SELECT  E.Lname, E.Fname, E.Address, E.Dno, D.Dname
FROM    EMPLOYEE AS E
        JOIN    DEPARTMENT AS D ON E.Dno = D.Dnumber
WHERE   D.Dname = 'Research';

SELECT  E.Lname, E.Fname, E.Address, E.Dno
FROM    EMPLOYEE AS E  
WHERE   E.Dno IN (
                SELECT  D.Dnumber
                FROM    DEPARTMENT AS D  
                WHERE   D.Dname = 'Research');

--Query 14: Retrieve the name of each employee 
--who has a dependent with the same firstname as the employee

SELECT  E.Fname AS E_FirstName, Depend.Dependent_name AS DependentName
FROM    DEPENDENT AS Depend 
        JOIN EMPLOYEE AS E ON Depend.Essn = E.Ssn
WHERE   E.Fname = Depend.Dependent_name;

SELECT  E.Fname, E.Lname
FROM    EMPLOYEE E  
WHERE   E.Ssn IN (SELECT Essn 
                        FROM    DEPENDENT
                        WHERE   Essn = E.Ssn AND E.Fname = Dependent_name);

--Query 15: Retrieve the SSNs of all employees 
--who work the same (project, hours) combination on some project
--that employee John Smith (SSN = 123456789) works on (using a nested query) 

-- SELECT  W.Essn
-- FROM    WORKS_ON AS W
-- WHERE   W.Pno IN (SELECT  W.Pno, W.HoursWork
--                                 FROM    WORKS_ON AS W
--                                 WHERE   W.Essn = '123456789')
--         AND W.HoursWork IN (SELECT  W.Pno, W.HoursWork
--                                 FROM    WORKS_ON AS W
--                                 WHERE   W.Essn = '123456789'); 

SELECT  W1.Essn, W1.Pno, W1.HoursWork
FROM    WORKS_ON AS W1
WHERE   EXISTS  (SELECT * 
                FROM    WORKS_ON AS W2
                WHERE   W2.Essn = '123456789'
                AND     W1.Pno = W2.Pno
                AND     W1.HoursWork = W2.HoursWork)
        AND W1.Essn <> '123456789';

-- SELECT  Pno, HoursWork
-- FROM    WORKS_ON
-- WHERE   Essn = '123456789';

--Query 16: Retrieve all employees whose salary is greater than the salary of all employees in department 5
SELECT *
FROM    EMPLOYEE 
WHERE   Salary > ALL ( SELECT Salary
                                FROM  EMPLOYEE
                                WHERE Dno = 5);

--Query 17: Retrieve the names of employees who have no dependents
SELECT  E.Fname, E.Lname
FROM    EMPLOYEE AS E  
WHERE   NOT EXISTS (SELECT      *    
                        FROM    DEPENDENT AS D  
                        WHERE   D.Essn = E.Ssn);

--Query 18: Retrieve the SSNs of all employees who work on project numbers 1, 2, or 3
SELECT  Essn
FROM    WORKS_ON
WHERE   Pno IN (1, 2, 3);

SELECT  Essn
FROM    WORKS_ON
WHERE   Pno = 1 OR Pno = 2 OR Pno = 3;

--Query 19: Find the max, min, average salary among all employees
SELECT  MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvrSalary
FROM    EMPLOYEE;

--Query 20: Retrieve the total number of employees in the company
SELECT  COUNT(*) AS TheNumberOfEmployees
FROM    EMPLOYEE;

--Query 21: Retrieve the number of employees in the 'Research' Department
SELECT  COUNT(*) AS TheNumberOfEmployees
FROM    EMPLOYEE AS E  
        JOIN DEPARTMENT AS D ON E.Dno = D.Dnumber
WHERE   D.Dname = 'Research';

SELECT
    D.Dnumber,         -- (Bạn muốn hiển thị cột này)
    D.Dname,           -- (Bạn muốn hiển thị cột này)
    COUNT(*) AS TheNumberOfEmployees
FROM
    EMPLOYEE AS E
    JOIN DEPARTMENT AS D ON E.Dno = D.Dnumber
WHERE
    D.Dname = 'Research'
GROUP BY
    D.Dnumber,         -- (Vì vậy bạn phải GROUP BY nó)
    D.Dname;           -- (Và GROUP BY cả nó)

-- Lấy số lượng nhân viên của TẤT CẢ các phòng ban
SELECT
    D.Dnumber,
    D.Dname,
    COUNT(*) AS TheNumberOfEmployees
FROM
    EMPLOYEE AS E
    JOIN DEPARTMENT AS D ON E.Dno = D.Dnumber
GROUP BY
    D.Dnumber,
    D.Dname;

--Query 22: For each department, retrieve the department number, 
--the number of employees in the department, 
--and their average salary.
SELECT  D.Dnumber, COUNT(*) AS TheNumberOfEmployees, AVG(Salary) AS TheAvrSalary
FROM    EMPLOYEE AS E  
        JOIN    DEPARTMENT AS D ON E.Dno = D.Dnumber
GROUP BY        Dnumber;

SELECT  Dno, COUNT(*) AS TheNumberOfEmployees, AVG(Salary) AS TheAvrSalary
FROM    EMPLOYEE 
GROUP BY        Dno;


