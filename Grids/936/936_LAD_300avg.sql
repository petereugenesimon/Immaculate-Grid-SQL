-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(franchID), name, teamID
FROM dbo.Teams;


-- Create temp table for all players with batting records for LAD franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #lad_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BR3', 'BRO', 'LAN');


-- Query every player who played for LAD franchise & had a .300 AVG season
SELECT DISTINCT(x300.playerID), lad_bat.nameFirst, lad_bat.nameLast, x300.AB, x300.AVG
FROM (SELECT playerID, AB, ((H * 1.0) / AB) AS AVG
		FROM dbo.Batting
		WHERE AB > 0 AND
			((H * 1.0) / AB) > 0.299 AND
			teamID IN ('BR3', 'BRO', 'LAN')) AS x300
INNER JOIN #lad_bat AS lad_bat
	ON x300.playerID = lad_bat.playerID
ORDER BY x300.AB;