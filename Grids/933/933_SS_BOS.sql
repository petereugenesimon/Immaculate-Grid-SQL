-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for BOS franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #BOS_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'BOS';


-- Create temp table for all players with pitching records for BOS franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #bos_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'BOS';


-- Create temp table joining every recorded player for BOS franchise
SELECT *
INTO #bos
FROM #bos_bat
UNION
SELECT *
FROM #bos_pit;


-- Create temp table for every player who played SS for BOS franchise
SELECT DISTINCT(playerID), teamID, POS
INTO #bosss
FROM dbo.Fielding
WHERE teamID = 'BOS' AND
	POS = 'SS';


-- Query every player who played SS for BOS franchise
SELECT DISTINCT(bos.playerID), bos.nameFirst, bos.nameLast
FROM #bos AS bos
INNER JOIN #bosss AS bosss
	ON bos.playerID = bosss.playerID;