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

