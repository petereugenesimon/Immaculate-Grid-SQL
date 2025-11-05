-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


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


-- Create temp table for all players with batting records for CHC franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #chc_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'CHN';


-- Create temp table for all players with pitching records for CHC franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
INTO #chc_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'CHN';


-- Create temp table joining every recorded player for CHC franchise
SELECT *
INTO #chc
FROM #chc_bat
UNION
SELECT *
FROM #chc_pit;


-- Query all players who played for BOS & CHC franchises
SELECT DISTINCT(bos.playerID), bos.nameFirst, bos.nameLast
FROM #bos AS bos
INNER JOIN #chc AS chc
	ON bos.playerID = chc.playerID;