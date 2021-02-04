/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Username,
		SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) 
		AS EmailProvider 
   FROM [Users]
  ORDER BY EmailProvider , [Username] 

  --Problem 16. Get Users with IPAdress Like Pattern
  SELECT Username, IpAddress
	  FROM Users
	  WHERE	IpAddress LIKE '___.1%.%.___'
ORDER BY Username

--Problem 17. Show All Games with Duration and Part of the Day
SELECT 
	[Name] AS 'Game',
		CASE 
			WHEN DATEPART(HOUR, Start) BETWEEN 0 AND 11 THEN 'Morning'
			WHEN DATEPART(HOUR, Start) BETWEEN 12 AND 17 THEN 'Afternoon'
			WHEN DATEPART(HOUR, Start) BETWEEN 18 AND 23 THEN 'Evening'
			WHEN DATEPART(HOUR, Start) BETWEEN 18 AND 23 THEN 'Evening'
		END
	AS [Part of the day], 
		CASE
			WHEN Duration <= 3 THEN 'Extra Short'
			WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
			WHEN Duration > 6 THEN 'Long'
			WHEN Duration IS NULL THEN 'Extra Long'
		END
	AS [Duration] 
FROM Games
ORDER BY [Name], [Duration], [Part of the day]

USE Orders
--Problem 18. Orders Table
SELECT 
	ProductName, 
	OrderDate, 
	OrderDate + 3 AS  [Pay Due], 
	DATEADD(month, 1, OrderDate) AS [Deliver Due]
	FROM Orders

--Problem 19. People Table
	CREATE TABLE People
	(
		Id INT PRIMARY KEY,
		[Name] VARCHAR(30),
		Birthday DATETIME
	)

	INSERT INTO People VALUES
	(1,'Victor', '2000-12-07'),
	(2, 'Steven', '1992-09-10'),
	(3, 'Stephen', '1910-09-19'),
	(4, 'John', '2010-01-06')

	SELECT 
		[Name], Birthday,
		YEAR(GETDATE())- YEAR(Birthday) AS [Age of year], 
		DATEDIFF(MONTH, Birthday, GETDATE()) AS [Age in Months],
		DATEDIFF(DAY, Birthday, GETDATE()) AS [Age in Days],
		'' [Age in Minutes]
	FROM People