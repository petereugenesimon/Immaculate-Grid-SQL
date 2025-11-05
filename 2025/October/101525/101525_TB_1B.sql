-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for TBD franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #tbd_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'TBA';


-- Create temp table for all players with pitching records for TBD franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #tbd_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'TBA';


-- Create temp table joining every recorded player for TBD franchise
SELECT *
INTO #tbd
FROM #tbd_bat
UNION
SELECT *
FROM #tbd_pit;


-- Create temp table for every player who played 1B for TBD franchise
SELECT DISTINCT(playerID), teamID, POS
INTO #tbd1b
FROM dbo.Fielding
WHERE teamID = 'TBA' AND
	POS = '1B';


-- Query every player who played 1B for TBD franchise
SELECT DISTINCT(tbd.playerID), tbd.nameFirst, tbd.nameLast
FROM #tbd AS tbd
INNER JOIN #tbd1b AS tbd1b
	ON tbd.playerID = tbd1b.playerID;