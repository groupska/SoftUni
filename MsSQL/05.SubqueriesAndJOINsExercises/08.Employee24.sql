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