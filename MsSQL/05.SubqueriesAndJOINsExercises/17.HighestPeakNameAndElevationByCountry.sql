 --17. Highest Peak Name and Elevation by Country
 SELECT TOP (5) CountryName, MAX(p.Elevation) AS MAXEL, MAX(r.Length) AS MAXLEN  

	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains mn ON mn.Id = mc.MountainId
	LEFT JOIN Peaks p ON p.MountainId = mn.Id
	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers r ON r.Id = cr.RiverId
	GROUP BY c.CountryName
	ORDER BY MAXEL DESC, MAXLEN DESC