--8. Deposit Charge
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge)			
	FROM WizzardDeposits
	GROUP BY DepositGroup, MagicWandCreator
	ORDER BY MagicWandCreator, DepositGroup