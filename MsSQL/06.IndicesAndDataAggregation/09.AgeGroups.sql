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

	