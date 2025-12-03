-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for KCR franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #kcr_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'KCA';


-- Create temp table for all players with pitching records for KCR franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #kcr_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'KCA';


-- Create temp table joining every recorded player for KCR franchise
SELECT *
INTO #kcr
FROM #kcr_bat
UNION
SELECT *
FROM #kcr_pit;


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


-- Query all players who played for KCR & PIT franchises
SELECT DISTINCT(kcr.playerID), kcr.nameFirst, kcr.nameLast
FROM #kcr AS kcr
INNER JOIN #pit AS pit
	ON kcr.playerID = pit.playerID;