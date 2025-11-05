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


-- Create temp table for all players with batting records for HOU franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #hou_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'HOU';


-- Create temp table for all players with pitching records for HOU franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #hou_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'HOU';


-- Create temp table joining every recorded player for HOU franchise
SELECT *
INTO #hou
FROM #hou_bat
UNION
SELECT *
FROM #hou_pit;


-- Query all players who played for BOS & HOU franchises
SELECT DISTINCT(bos.playerID), bos.nameFirst, bos.nameLast
FROM #bos AS bos
INNER JOIN #hou AS hou
	ON bos.playerID = hou.playerID;