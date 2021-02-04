--1. Records’ Count
SELECT COUNT(*) FROM WizzardDeposits

--2. 2. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits

--3. Longest Magic Wand Per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
GROUP BY DepositGroup

--4. * Smallest Deposit Group Per Magic Wand Size
SELECT TOP(2) DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize)

--5. Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	GROUP BY DepositGroup

--6. Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator LIKE 'Ollivander family'
	GROUP BY DepositGroup

--7. Deposits Filter
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator LIKE 'Ollivander family'
	GROUP BY DepositGroup
	HAVING SUM(DepositAmount) < 150000
	ORDER BY SUM(DepositAmount) DESC

--8. Deposit Charge
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge)			
	FROM WizzardDeposits
	GROUP BY DepositGroup, MagicWandCreator
	ORDER BY MagicWandCreator, DepositGroup

--9. Age Groups
SELECT AgeGroup, COUNT(*) AS Count
	FROM (
			SELECT FirstName,
				CASE 
						WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
						WHEN Age BETWEEN 10 AND 20 THEN '[11-20]'
						WHEN Age BETWEEN 20 AND 30 THEN '[21-30]'
						WHEN Age BETWEEN 30 AND 40 THEN '[31-40]'
						WHEN Age BETWEEN 40 AND 50 THEN '[41-50]'
						WHEN Age BETWEEN 50 AND 60 THEN '[51-60]'
						WHEN Age >=61 THEN '[61+]'
						
					END AS AgeGroup
				FROM WizzardDeposits
		) AS GROUPAGE
	GROUP BY AgeGroup

	SELECT 
	CASE
	  WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN w.Age >= 61 THEN '[60+]'
	END AS [AgeGroup],
COUNT(*) AS [WizardCount]
	FROM WizzardDeposits AS w
GROUP BY CASE
	  WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	  WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	  WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	  WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	  WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	  WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	  WHEN w.Age >= 61 THEN '[60+]'
	END

--10. First Letter
SELECT DISTINCT LEFT(FirstName, 1)
	FROM WizzardDeposits
	WHERE DepositGroup LIKE 'Troll Chest'
	GROUP BY FirstName

--11. Average Interest 
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest)
	FROM WizzardDeposits
	WHERE DepositStartDate > '1985-01-01'
	GROUP BY DepositGroup, IsDepositExpired
	ORDER BY DepositGroup DESC, IsDepositExpired ASC

--13. Departments Total Salaries
USE SoftUni
SELECT DepartmentID, SUM(Salary)
	FROM Employees 
	GROUP BY DepartmentID
	ORDER BY DepartmentID

--14. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary	
	FROM Employees
	WHERE HireDate > '2000-01-01' AND DepartmentID IN(2, 5, 7)
	GROUP BY DepartmentID

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

--16. Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) AS MaxSalary
	FROM Employees
	GROUP BY DepartmentID
	HAVING MAX(Salary) < 30000 OR MAX(Salary) >=70000

--17. Employees Count Salaries
SELECT COUNT(*)AS Count
	FROM Employees
	WHERE ManagerID IS NULL

--18. *3rd Highest Salary
SELECT DepartmentID, Salary 
	FROM (	SELECT DepartmentID, Salary, 
			DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RANK
			FROM Employees
			GROUP BY DepartmentID, Salary
		 ) AS NEW
		 WHERE RANK = 3

--19. **Salary Challenge
	SELECT TOP(10) e.FirstName, e.LastName, e.DepartmentID
FROM Employees AS e
WHERE e.Salary >(SELECT AVG(e2.Salary)
				FROM Employees AS e2
				WHERE e.DepartmentID = e2.DepartmentID)
ORDER BY e.DepartmentID

--12. * Rich Wizard, Poor Wizard
SELECT SUM(ResultTable.[Difference]) AS SumDifference
FROM (SELECT DepositAmount - (SELECT DepositAmount FROM WizzardDeposits WHERE Id = WizDeposits.Id + 1) 
AS [Difference] FROM WizzardDeposits WizDeposits) AS ResultTable
	 