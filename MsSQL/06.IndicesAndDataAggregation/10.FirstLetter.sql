--10. First Letter
SELECT DISTINCT LEFT(FirstName, 1)
	FROM WizzardDeposits
	WHERE DepositGroup LIKE 'Troll Chest'
	GROUP BY FirstName