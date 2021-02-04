--16.Countries Without Any Mountains

SELECT COUNT(C.CountryName)	AS Count
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
	WHERE mc.MountainId IS NULL