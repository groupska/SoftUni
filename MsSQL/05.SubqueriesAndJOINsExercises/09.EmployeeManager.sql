--9. Employee Manager
SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName
	FROM Employees e
	JOIN Employees m ON e.ManagerID = m.EmployeeID 
	WHERE e.ManagerID = 3 OR e.ManagerID = 7
ORDER BY e.EmployeeID