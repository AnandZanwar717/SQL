select * from fact;
select * from Location;
select * from Product;

------- Case Study 1 ---------------------------
----Question 1-------------------
select count(distinct state) from Location;


-----Question 2---------------
select COUNT(Type) from Product where Type = 'Regular';

---- Question 3
select sum(Marketing) from fact where ProductId = 1;

--- Question 4 
select MIN(Sales)  from fact;

--- Question 5
select max(COGS)  from fact;

-- Question 6
select * from Product where Product_Type = 'coffee';

--- Question 7 
select * from fact where Total_Expenses > 40;

-- Question 8
select AVG(sales) as sal from fact where Area_Code = 719;

--- Question 9
select sum(profit) as total_profit  from fact as F inner join Location as O on F.Area_Code= O.Area_Code where State='Colorado';

------------Question 10

SELECT productID, AVG(Inventory) as average_Inventory from fact group by ProductId;

------- Question 11
SELECT distinct(state)
FROM Location
ORDER BY state ;

----- Question 12 

select ProductId,AVG(Budget_Margin) as avg_budget  from fact group by ProductId having AVG(Budget_Margin) > 100 order by ProductId;


----- Question 13

SELECT SUM(sales)
FROM fact
WHERE  date = '2010-01-01';

--- question 14
SELECT ProductId, date, SUM(Total_Expenses) AS total_expense
FROM fact
GROUP BY ProductId, date
ORDER BY productId, date;

------ Question 15

select date, F.productID, product_type, product, sales, profit, state, f.area_code  from fact as f 
inner join Product as p
on f.ProductId=p.ProductId
inner join Location as l
on f.Area_Code= l.Area_Code

---- Question 16

SELECT sales ,  DENSE_RANK() OVER (order BY sales DESC) AS sales_wise_rank FROM fact;

---- Question 17
select distinct(state), sum(Profit) as totalProfit, sum(Sales) as totalSales from fact as f inner join location as l on f.Area_Code=l.Area_Code group by State;

--------Question 18
select state, sum(Profit) as total_profit,  sum(Sales) as totalsales, Product from fact as f inner join location as l on f.Area_Code=l.Area_Code 
inner join Product p on f.ProductId= p.ProductId
group by State, Product  ;

---- Question 19 
SELECT
    productId,
    sales AS original_sales_amount,
    sales * (1 + 0.05) AS increased_sales_amount
FROM
    fact;

--------- Question 20 

SELECT p.ProductId, p.Product_Type, MAX(f.Profit) AS max_profit
FROM fact AS f
INNER JOIN Product AS p ON f.ProductId = p.ProductId
GROUP BY p.ProductId, p.Product_Type;


------- Question 21 

CREATE PROCEDURE FetchProductsByType
    @product_type NVARCHAR(50)  
AS
BEGIN
    SELECT
        ProductID,
        Product,
        Product_Type
    FROM
        Product
    WHERE
        Product_Type = @product_type;
END;

-- Execute the stored procedure to fetch products by product_type
EXEC FetchProductsByType @product_type = 'Coffee';


-------- Question 22
SELECT
    *,
    CASE
        WHEN Total_Expenses < 60 THEN 'Profit'
        ELSE 'Loss'
    END AS ProfitOrLoss
FROM
    Fact;

------Question 23 
SELECT
    CASE
        WHEN GROUPING(WeekStartDate) = 1 THEN 'Total Weekly Sales'
        ELSE CONVERT(VARCHAR, WeekStartDate, 103)  -- Display week start date in dd/mm/yyyy format
    END AS WeekStartDate,
    SUM(Sales) AS TotalSales
FROM (
    SELECT
        DATEADD(WEEK, DATEDIFF(WEEK, 0, Date), 0) AS WeekStartDate,
        Sales
    FROM
        Fact
) AS WeeklySales
GROUP BY
    ROLLUP(WeekStartDate)
ORDER BY
    WeekStartDate DESC;


	----- Question 24

select * from fact 
union 
select * from Location;

select * from fact 
Intersect 
select * from Location;

---- This operations didnt work as there are no same number of columns in two tables 

--- Question 25

-- Step 1: Create the function
CREATE FUNCTION dbo.GetProductsByType
(
    @productType NVARCHAR(50)  
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ProductID,
        Product,
        Product_Type
    FROM
        Product
    WHERE
        Product_Type = @productType
);

-- execution of function
SELECT *
FROM dbo.GetProductsByType('coffee');


------ Question 26

---- using store procedure along with transcational commands
CREATE PROCEDURE UpdateAndUndoProductType
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE Product
        SET Product_Type = 'tea'
        WHERE ProductId = 1;

        COMMIT TRANSACTION;

        
    END TRY
    BEGIN CATCH
        -- Rollback the transaction to undo it 
        ROLLBACK TRANSACTION;

    END CATCH;
END;
------- Execute the store procedure
exec UpdateAndUndoProductType;

---- Question 27

select Date,ProductId, Sales   from fact where Total_Expenses between 100 and 200;

---- Question 28 
DELETE  FROM Product
WHERE Type = 'regular';


select * from Product

--- Question 29 


SELECT ASCII(SUBSTRING(Product, 5, 1)) AS ASCII_Value
FROM Product;


---------------------------------------------------------------------------------------------------------------------------------------------------

