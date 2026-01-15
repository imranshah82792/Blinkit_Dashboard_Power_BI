CREATE DATABASE blinkit;
USE blinkit;
SELECT * FROM blinkit_grocery_database;

SET SQL_SAFE_UPDATES = 0;
UPDATE blinkit_grocery_database
SET Item_Fat_Content =
   CASE 
      WHEN Item_Fat_Content IN('LF','low fat') THEN 'Low Fat'
      WHEN Item_Fat_Content = 'reg' THEN 'Regular'
      ELSE Item_Fat_Content
   END
WHERE Item_Fat_Content IN ('LF','low fat','reg');
SET SQL_SAFE_UPDATES = 1;

SELECT DISTINCT(Item_Fat_Content)FROM blinkit_grocery_database;

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales 
FROM blinkit_grocery_database
WHERE Outlet_Establishment_Year = 2022 ;

SELECT CAST(AVG(Sales) AS DECIMAL(10,2)) AS AVG_Sales 
FROM blinkit_grocery_database
WHERE Outlet_Establishment_Year = 2022;

SELECT COUNT(*) 
FROM blinkit_grocery_database
WHERE Outlet_Establishment_Year = 2022;

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS AVG_Rating 
FROM blinkit_grocery_database;

SELECT Item_Type,
-- Item_Fat_Content,
      CAST(SUM(Sales) AS DECIMAL (10,2)) AS Total_Sales,
      CAST(AVG(Sales) AS DECIMAL (10,2)) AS AVG_Sales,
      CAST(COUNT(*) AS DECIMAL (10,2)) AS No_Of_Items,
      CAST(AVG(Rating) AS DECIMAL (10,2)) AS AVG_RATING
FROM blinkit_grocery_database
-- WHERE Outlet_Establishment_Year = 2022
GROUP BY Item_Type
-- Item_Fat_Content
ORDER BY Total_Sales DESC
LIMIT 3;

SELECT Outlet_Location_Type,
      COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Sales END),0) AS Low_Fat,
      COALESCE(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Sales END),0) AS Regular
FROM blinkit_grocery_database
WHERE Item_Fat_Content IN ('Low Fat','Regular')
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

