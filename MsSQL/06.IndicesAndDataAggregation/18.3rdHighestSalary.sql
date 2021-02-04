--18. *3rd Highest Salary
SELECT DepartmentID, Salary 
	FROM (	SELECT DepartmentID, Salary, 
			DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RANK
			FROM Employees
			GROUP BY DepartmentID, Salary
		 ) AS NEW
		 WHERE RANK = 3