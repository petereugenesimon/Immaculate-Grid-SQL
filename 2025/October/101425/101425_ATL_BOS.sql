-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for ATL franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #atl_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('ATL', 'BSN', 'ML1');


-- Create temp table for all players with pitching records for ATL franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #atl_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('ATL', 'BSN', 'ML1');


-- Create temp table joining every recorded player for ATL franchise
SELECT *
INTO #atl
FROM #atl_bat
UNION
SELECT *
FROM #atl_pit;


-- Create temp table for all players with batting records for BOS franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #bos_bat
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


-- Query all players who played for ATL & BOS franchises
SELECT DISTINCT(atl.playerID), atl.nameFirst, atl.nameLast
FROM #atl AS atl
INNER JOIN #bos AS bos
	ON atl.playerID = bos.playerID;