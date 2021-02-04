--17. Highest Peak and Longest River by Country
SELECT  Country, [Highest Peak Name], [Highest Peak Elevation], Mountain FROM(
	SELECT  CountryName AS [Country], 
		ISNULL(p.PeakName,'(no highest peak)') AS [Highest Peak Name],
		ISNULL(p.Elevation, 0) AS [Highest Peak Elevation],
		ISNULL(mn.MountainRange, '(no mountain)') AS [Mountain],		
	DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS RankedPeak
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains mn ON mn.Id = mc.MountainId
	LEFT JOIN Peaks p ON p.MountainId = mn.Id
			) AS Peak
	WHERE RankedPeak = 1
ORDER BY Country ASC, [Highest Peak Name] ASC