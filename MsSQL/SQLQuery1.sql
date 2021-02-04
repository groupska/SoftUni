--USE SoftUni
--Problem 1. Find Names of All Employees by First Name

SELECT FirstName, LastName FROM Employees WHERE FirstName LIKE 'SA%'

--Problem 2. Find Names of All employees by Last Name
SELECT FirstName, LastName FROM Employees WHERE LastName LIKE '%ei%'

--Problem 3. Find First Names of All Employees
SELECT FirstName FROM Employees 
	WHERE DepartmentID = 3 OR 
		  DepartmentID = 10 AND 
		  YEAR(HireDate) > 1995 AND 
		  YEAR(HireDate) < 2005

-- Problem 4. Find All Employees Except Engineers
SELECT FirstName, LastName FROM Employees WHERE JobTitle NOT LIKE '%engineer%'

--Problem 5. Find Towns with Name Length
SELECT [Name] FROM Towns WHERE LEN(Name) = 5 OR LEN(Name) = 6
	ORDER BY Name ASC

--Problem 6. Find Towns Starting With
SELECT * FROM Towns 
	WHERE  LEFT(Name, 1) IN ('M', 'K', 'B', 'E')
	ORDER BY Name ASC

--Problem 7. Find Towns Not Starting With
SELECT * FROM Towns 
	WHERE  LEFT(Name, 1) NOT IN ('R', 'B', 'D')
	ORDER BY Name ASC

--Problem 8. Create View Employees Hired After 2000 Year
--CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees 
	WHERE YEAR(HireDate) > 2000

--Problem 9. Length of Last Name
SELECT FirstName, LastName FROM Employees 
	WHERE LEN(LastName) = 5

--Problem 10. Rank Employees by Salary
SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION BY Salary
	ORDER BY EmployeeID ) AS RANK FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000  
	ORDER BY Salary DESC

--Problem 11. Find All Employees with Rank 2 *
SELECT * FROM (
SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION BY Salary
	ORDER BY EmployeeID ) AS RANK FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000  
	) AS RESULT
	WHERE RANK = 2
	ORDER BY Salary DESC

--USE Geography
--Problem 12. Countries Holding ‘A’ 3 or More Times
SELECT CountryName, IsoCode FROM Countries
	WHERE CountryName LIKE '%A%A%A%'
	ORDER BY IsoCode ASC

--Problem 13. Mix of Peak and River Names
SELECT PeakName, RiverName, LOWER(LEFT(PeakName, LEN(PeakName)-1)+RiverName) AS Mix FROM Peaks, Rivers
	WHERE LEFT(RiverName,1) = RIGHT(PeakName,1)
	ORDER BY Mix

	--USE Diablo
--Problem 14. Games from 2011 and 2012 year




