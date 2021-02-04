--6. Employees Hired After
SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName 
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE e.HireDate > 1999-01-01 AND (d.Name LIKE 'Sales' OR d.Name LIKE 'Finance') 
ORDER BY e.HireDate ASC