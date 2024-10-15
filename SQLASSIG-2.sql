select * from Jomatoe;

                            --Assignment 2


-- Question 1

-- Create a user-defined function to stuff 'Chicken' into a phrase
CREATE FUNCTION dbo.StuffChickenIntoPhrase (@originalPhrase NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @modifiedPhrase NVARCHAR(100);

    -- Replace 'Bites' with 'Chicken Bites'
    SET @modifiedPhrase = REPLACE(@originalPhrase, 'Bites', 'Chicken Bites');

    -- Return the modified phrase
    RETURN @modifiedPhrase;
END;

-- using function
DECLARE @phrase NVARCHAR(100) = 'Quick Bites';

-- Calling function to update the word 
DECLARE @modifiedPhrase NVARCHAR(100) = dbo.StuffChickenIntoPhrase(@phrase);

-- modified phrase can be displayed by following query
SELECT @modifiedPhrase AS ModifiedPhrase;


--------------------------------------------------------------------------------
-- question 2
-- Create a user-defined function to find the restaurant with the maximum number of ratings
CREATE FUNCTION dbo.GetRestaurantWithMaxRatingsss()
RETURNS TABLE
AS
RETURN
(
    SELECT RestaurantName, CuisinesType
    FROM Jomatoe
    WHERE No_of_Rating = (SELECT MAX(No_of_Rating) FROM Jomatoe)
);

-- Use the user-defined function to get the restaurant with the maximum ratings
SELECT RestaurantName, CuisinesType
FROM dbo.GetRestaurantWithMaxRatingsss();




-------------------------------------------------------------------

--Question 3
ALTER TABLE Jomatoe
ADD RatingStatus VARCHAR(20); -- Adjust the VARCHAR length as needed


UPDATE Jomatoe
SET RatingStatus = CASE
    WHEN Rating > 4 THEN 'Excellent'
    WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
    WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
    WHEN Rating <= 3 THEN 'Bad'
    ELSE 'Unknown' -- Handle any other cases if needed
END;

select RatingStatus from Jomatoe;
----------------------------------------------------------------------------------------------
--Question 4 

-- Assuming 'restaurants' is your table name and 'Rating' is the column name

-- Ceil (Round up to the nearest integer)
SELECT Rating,
       CEILING(Rating) AS CeilRating
FROM Jomatoe;

-- Floor (Round down to the nearest integer)
SELECT Rating,
       FLOOR(Rating) AS FloorRating
FROM Jomatoe;

-- Absolute Value
SELECT Rating,
       ABS(Rating) AS AbsoluteRating
FROM Jomatoe;


-- Current Date
SELECT GETDATE() AS CurrentDate;

-- Extract Year, Month Name, and Day
SELECT YEAR(GETDATE()) AS CurrentYear,
       DATENAME(MONTH, GETDATE()) AS CurrentMonthName,
       DAY(GETDATE()) AS CurrentDay;
----------------------------------------------------------------------------------------------------


-- Question 5 


SELECT RestaurantType, SUM(AverageCost) AS TotalAverageCost
FROM Jomatoe
GROUP BY RestaurantType
WITH ROLLUP;


---------------------------------------------------------------------------------------------------------------







