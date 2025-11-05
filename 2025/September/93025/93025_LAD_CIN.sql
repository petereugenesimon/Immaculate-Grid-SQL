-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for LAD franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #lad_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BR3', 'BRO', 'LAN');


-- Create temp table for all players with pitching records for LAD franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #lad_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('BR3', 'BRO', 'LAN');


-- Create temp table joining every recorded player for LAD franchise
SELECT *
INTO #lad
FROM #lad_bat
UNION
SELECT *
FROM #lad_pit;


-- Create temp table for all players with batting records for CIN franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #cin_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('CIN', 'CN2');


-- Create temp table for all players with pitching records for CIN franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #cin_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('CIN', 'CN2');


-- Create temp table joining every recorded player for CIN franchise
SELECT *
INTO #cin
FROM #cin_bat
UNION
SELECT *
FROM #cin_pit;


-- Query all players who played for LAD & CIN franchises
SELECT DISTINCT(lad.playerID), lad.nameFirst, lad.nameLast
FROM #lad AS lad
INNER JOIN #cin AS cin
	ON lad.playerID = cin.playerID;