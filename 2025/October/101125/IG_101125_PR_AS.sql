SELECT DISTINCT(p.playerID), p.nameFirst, p.nameLast, p.birthCountry
FROM dbo.People AS p
INNER JOIN AllstarFull AS a_s
	ON p.playerID = a_s.playerID
WHERE birthCountry = 'P.R.'