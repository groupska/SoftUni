--1. Employee Address
SELECT TOP(5) EmployeeID, JobTitle, e.AddressID, a.AddressText 
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	ORDER BY e.AddressID ASC