CREATE DATABASE PortfolioDB;
USE PortfolioDB;

CREATE TABLE Employees (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees VALUES
(1,'Ravi','HR',30000),
(2,'Priya','IT',50000),
(3,'Arun','Sales',40000);

SELECT * FROM Employees;

SELECT * 
FROM Employees
WHERE Department = 'IT';

SELECT *
FROM Employees
ORDER BY Salary DESC;

SELECT COUNT(*) AS TotalEmployees
FROM Employees;

SELECT AVG(Salary) AS AverageSalary
FROM Employees;

SELECT MAX(Salary) AS HighestSalary
FROM Employees;

SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department;

SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) >= 1;

CREATE TABLE Departments (
    DepartmentID INT,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Sales');

SELECT e.Name, e.Department, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.Department = d.DepartmentName;

INSERT INTO Departments VALUES (4,'Finance');

SELECT e.Name, d.DepartmentName
FROM Departments d
LEFT JOIN Employees e
ON d.DepartmentName = e.Department;

SELECT e.Name, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d
ON e.Department = d.DepartmentName;

CREATE TABLE Staff (
    EmpID INT,
    EmpName VARCHAR(50),
    ManagerID INT
);

INSERT INTO Staff VALUES
(1,'Ravi',NULL),
(2,'Priya',1),
(3,'Arun',1),
(4,'Divya',2);


SELECT e.EmpName AS Employee,
       m.EmpName AS Manager
FROM Staff e
LEFT JOIN Staff m
ON e.ManagerID = m.EmpID;

CREATE TABLE Colors (
    ColorName VARCHAR(20)
);

INSERT INTO Colors VALUES
('Red'),
('Blue');

CREATE TABLE Sizes (
    SizeName VARCHAR(20)
);

INSERT INTO Sizes VALUES
('S'),
('M'),
('L');

SELECT *
FROM Colors
CROSS JOIN Sizes;

SELECT *
FROM Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
);

CREATE TABLE Departments1 (
    Department VARCHAR(50)
);

INSERT INTO Departments1 VALUES
('HR'),
('IT');

SELECT *
FROM Employees
WHERE Department IN
(
    SELECT Department
    FROM Departments1
);

SELECT e.Name, e.Salary, e.Department
FROM Employees e
WHERE e.Salary >
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE Department = e.Department
);

SELECT *
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Departments d
    WHERE d.DepartmentName = e.Department
);

SELECT *
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM Departments d
    WHERE d.DepartmentName = e.Department
);

SELECT Name,
       Salary,
       CASE
           WHEN Salary >= 50000 THEN 'High'
           WHEN Salary >= 40000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM Employees;

SELECT Name,
       Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM Employees;

UPDATE Employees
SET Salary = 50000
WHERE Name = 'Arun';
set sql_safe_updates=0;

SELECT Name,
       Salary,
       RANK() OVER (ORDER BY Salary DESC) AS EmpRank
FROM Employees;

SELECT Name,
       Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;

SELECT Name,
       Salary,
       LAG(Salary) OVER (ORDER BY Salary DESC) AS PreviousSalary
FROM Employees;

SELECT Name,
       Salary,
       LEAD(Salary) OVER (ORDER BY Salary DESC) AS NextSalary
FROM Employees;

SELECT Name,
       Salary,
       SUM(Salary) OVER (ORDER BY Name) AS RunningTotal
FROM Employees;

SELECT *
FROM (
    SELECT Name,
           Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
    FROM Employees
) t
WHERE rnk <= 2;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Name ORDER BY Salary DESC) AS rn
    FROM Employees
) t
WHERE rn = 1;


SELECT Name,
       Department,
       Salary,
       RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
FROM Employees;

WITH EmployeeCTE AS
(
    SELECT *
    FROM Employees
)
SELECT *
FROM EmployeeCTE;

WITH HighSalary AS
(
    SELECT *
    FROM Employees
    WHERE Salary >= 40000
),
LowSalary AS
(
    SELECT *
    FROM Employees
    WHERE Salary < 40000
)
SELECT * FROM HighSalary
UNION ALL
SELECT * FROM LowSalary;

WITH EmpDept AS
(
    SELECT e.Name,
           e.Department,
           e.Salary,
           d.DepartmentName
    FROM Employees e
    INNER JOIN Departments d
    ON e.Department = d.DepartmentName
)
SELECT *
FROM EmpDept;

WITH SalaryRank AS
(
    SELECT Name,
           Department,
           Salary,
           DENSE_RANK() OVER(ORDER BY Salary DESC) AS RankNo
    FROM Employees
)
SELECT *
FROM SalaryRank;

WITH RECURSIVE Numbers AS
(
    SELECT 1 AS Num
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 5
)
SELECT *
FROM Numbers;

