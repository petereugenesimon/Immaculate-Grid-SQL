-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for CHC franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #chc_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'CHN';


-- Create temp table for all players with pitching records for CHC franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
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


-- Create temp table for all players with batting records for CLE franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #cle_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'CLE';


-- Create temp table for all players with pitching records for CLE franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #cle_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'CLE';


-- Create temp table joining every recorded player for CLE franchise
SELECT *
INTO #cle
FROM #cle_bat
UNION
SELECT *
FROM #cle_pit;


-- Query all players who played for CHC & CLE franchises
SELECT DISTINCT(chc.playerID), chc.nameFirst, chc.nameLast
FROM #chc AS chc
INNER JOIN #cle AS cle
	ON chc.playerID = cle.playerID;