-- Query every player who played CF for the KCR franchise
SELECT DISTINCT(f.playerID), p.nameFirst, p.nameLast, f.teamID, f.POS
FROM dbo.FieldingOFsplit AS f
INNER JOIN dbo.People AS p
	ON f.playerID = p.playerID
WHERE f.teamID = 'KCA' AND
	f.POS = 'CF';