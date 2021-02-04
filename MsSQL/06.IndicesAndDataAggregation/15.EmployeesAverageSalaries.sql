--15. Employees Average Salaries
		SELECT * 
			INTO MoreThan3000
			FROM Employees
			WHERE Salary > 30000
		
	DELETE FROM MoreThan3000
	WHERE ManagerID = 42

	UPDATE MoreThan3000
		SET Salary = Salary + 5000
		WHERE DepartmentID = 1

	SELECT DepartmentID, AVG(Salary) AS AverageSalary
		FROM MoreThan3000
		GROUP BY DepartmentID