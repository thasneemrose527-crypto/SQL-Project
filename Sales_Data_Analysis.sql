CREATE TABLE Sales(
SaleID INT,
CustomerName VARCHAR(50),
Product VARCHAR(50),
Region VARCHAR(50),
Quantity INT,
Price INT,
SaleDate DATE
);

INSERT INTO Sales VALUES
(1,'Ravi','Laptop','South',2,50000,'2025-01-10'),
(2,'Priya','Mobile','North',1,30000,'2025-01-15'),
(3,'Arun','Tablet','South',3,20000,'2025-02-01'),
(4,'Divya','Laptop','East',1,50000,'2025-02-20'),
(5,'Kumar','Mobile','West',2,30000,'2025-03-05');

SELECT * FROM Sales;

SELECT *
FROM Sales
WHERE Region='South';

SELECT *
FROM Sales
ORDER BY Price DESC;

SELECT SUM(Price*Quantity)
FROM Sales;

SELECT AVG(Price)
FROM Sales;

SELECT MAX(Price)
FROM Sales;

SELECT Region,
SUM(Price*Quantity)
FROM Sales
GROUP BY Region;

SELECT Product,
SUM(Quantity)
FROM Sales
GROUP BY Product;

SELECT Region,
SUM(Price*Quantity)
FROM Sales
GROUP BY Region
HAVING SUM(Price*Quantity)>50000;

SELECT CustomerName,
Price,
CASE
WHEN Price>=50000 THEN 'Premium'
WHEN Price>=30000 THEN 'Standard'
ELSE 'Budget'
END AS Category
FROM Sales;

SELECT CustomerName,
Price,
ROW_NUMBER() OVER(ORDER BY Price DESC)
FROM Sales;

SELECT CustomerName,
Price,
RANK() OVER(ORDER BY Price DESC)
FROM Sales;

SELECT CustomerName,
Price,
DENSE_RANK() OVER(ORDER BY Price DESC)
FROM Sales;

SELECT CustomerName,
Price,
LAG(Price) OVER(ORDER BY Price)
FROM Sales;

SELECT CustomerName,
Price,
LEAD(Price) OVER(ORDER BY Price)
FROM Sales;

SELECT CustomerName,
Price,
SUM(Price) OVER(ORDER BY SaleDate)
FROM Sales;

WITH SalesCTE AS
(
SELECT *
FROM Sales
)
SELECT *
FROM SalesCTE;

WITH HighSales AS
(
SELECT *
FROM Sales
WHERE Price>=30000
)
SELECT *
FROM HighSales;

SELECT Product,
SUM(Quantity)
FROM Sales
GROUP BY Product
ORDER BY SUM(Quantity) DESC;

SELECT CustomerName,
SUM(Price*Quantity)
FROM Sales
GROUP BY CustomerName
ORDER BY SUM(Price*Quantity) DESC;

SELECT MONTH(SaleDate),
SUM(Price*Quantity)
FROM Sales
GROUP BY MONTH(SaleDate);


SELECT Region,
SUM(Price*Quantity)
FROM Sales
GROUP BY Region;

SELECT Product,
SUM(Price*Quantity)
FROM Sales
GROUP BY Product
ORDER BY SUM(Price*Quantity) DESC;