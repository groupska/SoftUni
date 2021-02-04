--14. Countries with Rivers
SELECT TOP (5) c.CountryName, r.RiverName
	FROM Countries c
	JOIN Continents ct ON c.ContinentCode = ct.ContinentCode
	LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers r ON cr.RiverId = r.Id
WHERE ct.ContinentName LIKE 'Africa'
ORDER BY c.CountryName 