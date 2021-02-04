--13. Count Mountain Ranges

SELECT mc.CountryCode, COUNT(m.MountainRange) 
	FROM MountainsCountries mc
	JOIN Mountains m ON mc.MountainId = m.Id
	WHERE mc.CountryCode IN ('BG', 'RU', 'US')
GROUP BY mc.CountryCode
