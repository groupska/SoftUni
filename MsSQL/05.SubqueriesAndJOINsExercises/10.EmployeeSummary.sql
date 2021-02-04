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