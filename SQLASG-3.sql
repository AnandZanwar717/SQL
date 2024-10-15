select * from Jomatoe;

------------------------------Assignment-3---------------------------------------------
---- Question 1
-- Create a stored procedure named
CREATE PROCEDURE GetRestaurantsWithTableBooking
AS
BEGIN
    -- Select restaurant information based on the condition
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM Jomatoe
    WHERE TableBooking <> 0;
END;
GO
EXEC GetRestaurantsWithTableBooking;
-----------------------------------------------------------------------------------------------------------

--Question 2

-- Start a transaction
BEGIN TRANSACTION;

-- Update the cuisine type from 'Cafe' to 'Cafeteria'
UPDATE Jomatoe
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

--checking updated rows
select CuisinesType  from Jomatoe where CuisinesType = 'cafeteria'

ROLLBACK TRANSACTION;
--checking updated rows after rollback
select CuisinesType  from Jomatoe where CuisinesType = 'cafe'
---------------------------------------------------------------------------

--Question 3

---using cte  

WITH RankedRestaurants AS (
    SELECT
        RestaurantName,
        RestaurantType,
        Rating,
        Area,
        ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Rating DESC) AS RowNum
    FROM
        Jomatoe
)

-- Query to find the top 5 areas with the highest average ratings of restaurants
SELECT
    Area,
    AVG(Rating) AS AverageRating
FROM
    RankedRestaurants
WHERE
    RowNum <= 5  -- Filter to include only top-rated restaurants (top 5 in each area)
GROUP BY
    Area
ORDER BY
    AverageRating DESC; 

    -----------------------------------------------------------------------------
    ----- Question 3 
--- following query for highest rating area
WITH AreaRatings AS (
    SELECT
        Area,
        AVG(Rating) AS AverageRating,
        ROW_NUMBER() OVER (ORDER BY AVG(Rating) DESC) AS RowNum
    FROM
        Jomatoe
    GROUP BY
        Area
)

SELECT
    Area,
    AverageRating
FROM
    AreaRatings
WHERE
    RowNum <= 5
ORDER BY
    AverageRating DESC;




	


	--------------------------------------------------------

------Question 4 

	DECLARE @counter INT;
SET @counter = 1;

WHILE @counter <= 50
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END;

------------------------------------------------


-------------Question 5
---- Query to create a view 

CREATE VIEW TopRatingRestaurants AS
SELECT
    RestaurantName,
    RestaurantType,
    Rating,
    Area
FROM
    (
        SELECT
            RestaurantName,
            RestaurantType,
            Rating,
            Area,
            ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNum
        FROM
            Jomatoe
    ) AS RankedRestaurants
WHERE
    RowNum <= 5;

-- query to see the view 
select * from TopRatingRestaurants


-----------------------------------------------------------------------------------

-- Question 6 

-- Create a trigger to send email notification for new records of existing restaurants
CREATE TRIGGER SendEmailForNewRecord
ON Jomatoe
AFTER INSERT
AS
BEGIN
    DECLARE @RestaurantName NVARCHAR(255);
    DECLARE @EmailAddress NVARCHAR(255);
    DECLARE @Subject NVARCHAR(255);
    DECLARE @Body NVARCHAR(MAX);
    
    -- Loop through newly inserted records
    DECLARE @NewRestaurantName NVARCHAR(255);
    DECLARE @ExistingRestaurantCount INT;

    DECLARE cursor_new_restaurants CURSOR FOR
    SELECT RestaurantName
    FROM Jomatoe;

    OPEN cursor_new_restaurants;
    FETCH NEXT FROM cursor_new_restaurants INTO @NewRestaurantName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @ExistingRestaurantCount = COUNT(*)
        FROM Jomatoe
        WHERE RestaurantName = @NewRestaurantName;
        IF @ExistingRestaurantCount > 0
        BEGIN
            SELECT @EmailAddress = RestaurantOwnerEmail
            FROM Jomatoe
            WHERE RestaurantName = @NewRestaurantName;

            -- Compose email subject and body
            SET @Subject = 'New Record Added for ' + @NewRestaurantName;
            SET @Body = 'A new record has been added for your restaurant (' + @NewRestaurantName + ').';

            -- Send email using sp_send_dbmail
            EXEC msdb.dbo.sp_send_dbmail
                @profile_name = 'MailProfileName',  
                @recipients = @EmailAddress,
                @subject = @Subject,
                @body = @Body;
        END

        FETCH NEXT FROM cursor_new_restaurants INTO @NewRestaurantName;
    END

    CLOSE cursor_new_restaurants;
    DEALLOCATE cursor_new_restaurants;
END;
-------------------------------------------------------