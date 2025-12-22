-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(franchID), name, teamID
FROM dbo.Teams;


-- Query all players who played at least 1 game in LF for TOR
SELECT f.playerID, p.nameFirst, p.nameLast, SUM(f.G) AS G
FROM dbo.FieldingOFsplit AS f
INNER JOIN dbo.People AS p
	ON f.playerID = p.playerID
WHERE f.teamID = 'TOR' AND
	f.POS = 'LF'
GROUP BY f.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(f.G);