--1. Employee Address
SELECT TOP(5) EmployeeID, JobTitle, e.AddressID, a.AddressText 
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	ORDER BY e.AddressID ASC

--2. Addresses with Towns
SELECT TOP(50) e.FirstName, e.LastName, t.Name AS Town, a.AddressText 
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON a.TownID = t.TownID
ORDER BY e.FirstName ASC, e.LastName

--3. Sales Employee
SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS DepartmentName 
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE d.Name LIKE 'Sales'
ORDER BY e.EmployeeID

--4. Employee Departments
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name  AS DepartmentName
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary >15000
ORDER BY e.DepartmentID

--5. Employees Without Project
SELECT TOP(3) e.EmployeeID, e.FirstName 
	FROM Employees e
	LEFT JOIN EmployeesProjects p ON e.EmployeeID = p.EmployeeID
	WHERE p.ProjectID IS NULL
ORDER BY e.EmployeeID ASC


--6. Employees Hired After
SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName 
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE e.HireDate > 1999-01-01 AND (d.Name LIKE 'Sales' OR d.Name LIKE 'Finance') 
ORDER BY e.HireDate ASC

--7. Employees with Project
SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name AS ProjectName 
	FROM Employees e
	JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
	JOIN Projects p ON ep.ProjectID = p.ProjectID 
	WHERE p.StartDate > 2002-08-13 AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--8. Employee 24
	SELECT e.EmployeeID, e.FirstName, 
		   CASE 
				WHEN YEAR(p.StartDate) >= 2005 THEN NULL
				ELSE p.Name
		   END
		   AS ProjectName
		FROM Employees e
		LEFT JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
		LEFT JOIN Projects p ON ep.ProjectID = p.ProjectID 
		WHERE e.EmployeeID = 24 

--9. Employee Manager
SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName
	FROM Employees e
	JOIN Employees m ON e.ManagerID = m.EmployeeID 
	WHERE e.ManagerID = 3 OR e.ManagerID = 7
ORDER BY e.EmployeeID

--10. Employee Summary
SELECT  TOP(50)
		e.EmployeeID, 
		e.FirstName + ' ' + e.LastName AS EmployeeName, 
		m.FirstName + ' ' + m.LastName AS ManagerName, 
		d.Name 
	FROM Employees e
	JOIN Employees m ON m.EmployeeID = e.ManagerID 
	JOIN Departments d ON d.DepartmentID = m.DepartmentID 
ORDER BY e.EmployeeID

--11. Min Average Salary
	SELECT TOP(1) AVG(Salary) AS MinAverageSalary
		FROM Employees e		
GROUP BY e.DepartmentID
ORDER BY MinAverageSalary ASC

USE Geography
--12. Highest Peaks in Bulgaria
SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation
	FROM Countries AS c
	JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	JOIN Mountains AS m ON m.Id = mc.MountainId
	JOIN Peaks AS p ON p.MountainId = m.Id
	WHERE c.CountryName LIKE 'Bulgaria' AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--13. Count Mountain Ranges

SELECT mc.CountryCode, COUNT(m.MountainRange) 
	FROM MountainsCountries mc
	JOIN Mountains m ON mc.MountainId = m.Id
	WHERE mc.CountryCode IN ('BG', 'RU', 'US')
GROUP BY mc.CountryCode

--14. Countries with Rivers
SELECT TOP (5) c.CountryName, r.RiverName
	FROM Countries c
	JOIN Continents ct ON c.ContinentCode = ct.ContinentCode
	LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers r ON cr.RiverId = r.Id
WHERE ct.ContinentName LIKE 'Africa'
ORDER BY c.CountryName 

--15. *Continents and Currencies
SELECT ContinentCode, CurrencyCode, Total FROM (
	SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS Total,
	DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) AS Ranked 
	FROM Countries
	GROUP BY ContinentCode ,CurrencyCode) AS k
	WHERE Ranked = 1 AND Total >1
ORDER BY ContinentCode

--16.Countries Without Any Mountains

SELECT COUNT(C.CountryName)	AS Count
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
	WHERE mc.MountainId IS NULL

--17. Highest Peak and Longest River by Country
SELECT  Country, [Highest Peak Name], [Highest Peak Elevation], Mountain FROM(
	SELECT  CountryName AS [Country], 
		ISNULL(p.PeakName,'(no highest peak)') AS [Highest Peak Name],
		ISNULL(p.Elevation, 0) AS [Highest Peak Elevation],
		ISNULL(mn.MountainRange, '(no mountain)') AS [Mountain],		
	DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS RankedPeak
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains mn ON mn.Id = mc.MountainId
	LEFT JOIN Peaks p ON p.MountainId = mn.Id
			) AS Peak
	WHERE RankedPeak = 1
ORDER BY Country ASC, [Highest Peak Name] ASC
	

	

	
 --17
 SELECT TOP (5) CountryName, MAX(p.Elevation) AS MAXEL, MAX(r.Length) AS MAXLEN  

	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains mn ON mn.Id = mc.MountainId
	LEFT JOIN Peaks p ON p.MountainId = mn.Id
	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers r ON r.Id = cr.RiverId
	GROUP BY c.CountryName
	ORDER BY MAXEL DESC, MAXLEN DESC