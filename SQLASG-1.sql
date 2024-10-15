CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);
INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

	CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

	INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

	CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money);
	INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)


--assignment-1 
--Question 1
INSERT INTO Orders Values 
(5004,2245,103,'2022-07-07',450);

select * from Orders;


--
--Question 2 
-- Add Primary key constraint for SalesmanId column in Salesman table
ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL; 
ALTER TABLE Salesman
ADD CONSTRAINT PK_SalesmanId_Salesman PRIMARY KEY (SalesmanId);

-- Add default constraint for City column in Salesman table

--as default contrainst was already  present for city hence dropped the present one and added new one
ALTER TABLE Salesman
DROP CONSTRAINT DF_Salesman_City;
ALTER TABLE Salesman
ADD CONSTRAINT DF_Salesman_City DEFAULT 'DefaultValue' FOR City;

-- Add Foreign key constraint for SalesmanId column in Customer table


-- foreign key operation needs the same values in both tables .. following query gives the different values present in customer table from salesman table
SELECT DISTINCT SalesmanId
FROM Customer
WHERE SalesmanId IS NOT NULL
  AND SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

  -- inserting and updating record in salesman table to match with customer table 
  INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (107, 'John', 30, 'New York', 19),
    (110, 'Smith', 45, 'Houston', 34);

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_SalesmanId 
FOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId);

-- Adding not null constraint in CustomerName column for the Customer table
ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

-- question 3 
-- query for customername ending with N 
SELECT *
FROM Customer
WHERE CustomerName LIKE '%N';
-- query for purchase amount more than 500
select * from Customer where PurchaseAmount>500;

-- question 4
SELECT SalesmanID
FROM Salesman
UNION
SELECT SalesmanID
FROM Customer;

SELECT SalesmanID
FROM Salesman
UNION all
SELECT SalesmanID
FROM Customer;

-- question 5 

SELECT o.OrderDate,
       s.Name as SalesmanName,
       c.CustomerName,
       s.Commission,
       s.City
FROM Orders o
INNER JOIN Salesman s ON o.SalesmanId = s.SalesmanId
INNER JOIN Customer c ON o.CustomerId = c.CustomerId
WHERE c.PurchaseAmount BETWEEN 500 AND 1500;

--question 6 

SELECT s.*, o.*
FROM Salesman s
RIGHT JOIN Orders o ON s.SalesmanId = o.SalesmanId;