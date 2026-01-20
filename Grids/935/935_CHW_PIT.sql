-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for CHW franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #chw_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'CHA';


-- Create temp table for all players with pitching records for CHW franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #chw_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'CHA';


-- Create temp table joining every recorded player for CHW franchise
SELECT *
INTO #chw
FROM #chw_bat
UNION
SELECT *
FROM #chw_pit;


-- Create temp table for all players with batting records for PIT franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #pit_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('PIT', 'PT1');


-- Create temp table for all players with pitching records for PIT franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #pit_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('PIT', 'PT1');


-- Create temp table joining every recorded player for PIT franchise
SELECT *
INTO #pit
FROM #pit_bat
UNION
SELECT *
FROM #pit_pit;


-- Query all players who played for CHW & PIT franchises
SELECT DISTINCT(chw.playerID), chw.nameFirst, chw.nameLast
FROM #chw AS chw
INNER JOIN #pit AS pit
	ON chw.playerID = pit.playerID;