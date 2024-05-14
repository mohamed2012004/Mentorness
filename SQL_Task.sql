--Show the columns
select *
from [corona].[dbo].[Corona Virus Dataset]
---------------------------------------------------------------------------------------------------------------
--check NULL values
SELECT 
    SUM(case when Latitude is null then 1 else 0 end) as latitude, 
    SUM(case when Longitude  is null then 1 else 0 end) as longtitude,
	SUM(case when Country_Region is null then 1 else 0 end) as country_region,
	SUM(case when [Date] is null then 1 else 0 end) as [Date],
	SUM(case when Confirmed is null then 1 else 0 end) as confirmed,
	SUM(case when Deaths is null then 1 else 0 end) as deaths,
	SUM(case when Recovered is null then 1 else 0 end) as recovered
from [corona].[dbo].[Corona Virus Dataset] 

--------------------------------------------------------------------------------------------------------------------
--update the null values with zeros for all columns. 
SELECT 
	COALESCE(Latitude,0) As Lattitude,COALESCE(Longitude,0) As long
	
FROM
	[corona].[dbo].[Corona Virus Dataset]

--------------------------------------------------------------------------------------------------------------------
--check total number of rows
SELECT
	COUNT(*) AS TotalNumOfRows
FROM
	[corona].[dbo].[Corona Virus Dataset]
--------------------------------------------------------------------------------------------------------------------
--end_date 
SELECT 
	top(1)[Date] As End_date
FROM
    [corona].[dbo].[Corona Virus Dataset]
ORDER BY
    [Date] DESC;
--start_date
SELECT 
	top(1)[Date] As start_date
FROM    
    [corona].[dbo].[Corona Virus Dataset]
ORDER BY
    [Date] Asc;

--------------------------------------------------------------------------------------------------------------------
-- Number of month present in dataset
SELECT 
	MONTH([Date]) AS Month
FROM
	[corona].[dbo].[Corona Virus Dataset];
--------------------------------------------------------------------------------------------------------------------
-- monthly average for confirmed, deaths, recovered
SELECT 
    
    MONTH([Date]) AS Month,
    AVG(Confirmed) AS AverageConfirmed,
    AVG(Deaths) AS AverageDeaths,
    AVG(Recovered) AS AverageRecovered
FROM 
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY 
     MONTH([Date])
ORDER BY 
     Month;
---------------------------------------------------------------------------------------------------------------------------------------
--Countvalue for confirmed, deaths, recovered each month.
SELECT 

    MONTH([Date]) AS Month,
   COUNT(Confirmed) AS Confirmed,
   Count(Deaths) AS Deaths,
   Count(Recovered) AS Recovered
FROM 
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY 
     MONTH([Date])
ORDER BY 
    Month;
-------------------------------------------------------------------------------------------------------------------------------------------
--maximum values of confirmed, deaths, recovered per year.
SELECT 
    YEAR([Date]) AS Year,
    
    MAX(Confirmed) AS MaxConfirmed,
    MAX(Deaths) AS MaxDeaths,
    MAX(Recovered) AS MaxRecovered
FROM 
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY 
    YEAR([Date])
ORDER BY 
    Year;
-------------------------------------------------------------------------------------------------------------------------------------------
--minmum values of confirmed, deaths, recovered per year.
SELECT 
    YEAR([Date]) AS Year,
    
    MIN(Confirmed) AS MinConfirmed,
    MIN(Deaths) AS MinDeaths,
    MIN(Recovered) AS MinRecovered
FROM 
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY 
    YEAR([Date])
ORDER BY 
    Year;
----------------------------------------------------------------------------------------------------------------------------------------
--The total number of case of confirmed, deaths, recovered each month

SELECT 
    MONTH([Date]) AS Month,
    
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM 
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY 
    MONTH([Date])
ORDER BY 
    Month;
----------------------------------------------------------------------------------------------------------------------------------------
-- how corona virus spread out with respect to confirmed case
SELECT 
    COUNT(Confirmed) AS TotalConfirmedCases,
    AVG(CONVERT(BIGINT, Confirmed)) AS AverageConfirmedCases,
    SUM(POWER(CONVERT(BIGINT, Confirmed) - AVG_Cases.AverageConfirmedCases, 2)) / COUNT(Confirmed) AS VarianceConfirmedCases,
    SQRT(SUM(POWER(CONVERT(BIGINT, Confirmed) - AVG_Cases.AverageConfirmedCases, 2)) / COUNT(Confirmed)) AS StdDevConfirmedCases
FROM 
    [corona].[dbo].[Corona Virus Dataset],
    (SELECT AVG(CONVERT(BIGINT, Confirmed)) AS AverageConfirmedCases FROM [corona].[dbo].[Corona Virus Dataset]) AS AVG_Cases;

--------------------------------------------------------------------------------------------------------------------------------------------
---- how corona virus spread out with respect to recovered case
SELECT 
    COUNT(Recovered) AS TotalRecoveredCases,
    AVG(CONVERT(BIGINT, Recovered)) AS AverageRecoveredCases,
    SUM(POWER(CONVERT(BIGINT, Recovered) - AVG_Cases.AverageRecoveredCases, 2)) / COUNT(Recovered) AS VarianceRecoveredCases,
    SQRT(SUM(POWER(CONVERT(BIGINT, Recovered) - AVG_Cases.AverageRecoveredCases, 2)) / COUNT(Recovered)) AS StdDevRecoveredCases
FROM 
    [corona].[dbo].[Corona Virus Dataset],
    (SELECT AVG(CONVERT(BIGINT, Recovered)) AS AverageRecoveredCases FROM [corona].[dbo].[Corona Virus Dataset]) AS AVG_Cases;
-----------------------------------------------------------------------------------------------------------------------------------
--Country having highest number of the Confirmed case
SELECT Top(1)
    Country_Region,
    MAX(Confirmed) AS MaxConfirmedCases
FROM
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY
    Country_Region
Order by
	MaxConfirmedCases DESC;
---------------------------------------------------------------------------------------------------------------------------------------
--Country having highest number of the Confirmed case
SELECT Top(1)
    Country_Region,
    Min(Deaths) AS MindeathsCases
FROM
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY
    Country_Region
Order by
	MindeathsCases DESC;
---------------------------------------------------------------------------------------------------------------------------------------
--Top 5 Countries having highest number of the recovered case
SELECT Top(5)
    Country_Region,
    MAX(Recovered) AS MaxRecoveredCases
FROM
    [corona].[dbo].[Corona Virus Dataset]
GROUP BY
    Country_Region
Order by
	MaxRecoveredCases DESC;