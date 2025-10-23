-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for WSN franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #wsn_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('MON', 'WAS');


-- Create temp table for all players with pitching records for WSN franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #wsn_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('MON', 'WAS');


-- Create temp table joining every recorded player for WSN franchise
SELECT *
INTO #wsn
FROM #wsn_bat
UNION
SELECT *
FROM #wsn_pit;


-- Create temp table for all players with batting records for ANA franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #ana_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('ANA', 'CAL', 'LAA');


-- Create temp table for all players with pitching records for ANA franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #ana_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('ANA', 'CAL', 'LAA');


-- Create temp table joining every recorded player for ANA franchise
SELECT *
INTO #ana
FROM #ana_bat
UNION
SELECT *
FROM #ana_pit;


-- Query all players who played for WSN & ANA franchises
SELECT DISTINCT(wsn.playerID), wsn.nameFirst, wsn.nameLast
FROM #wsn AS wsn
INNER JOIN #ana AS ana
	ON wsn.playerID = ana.playerID;