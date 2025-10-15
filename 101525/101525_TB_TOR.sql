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


-- Create temp table for all players with batting records for TOR franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #tor_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'TOR';


-- Create temp table for all players with pitching records for TOR franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #tor_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'TOR';


-- Create temp table joining every recorded player for TOR franchise
SELECT *
INTO #tor
FROM #tor_bat
UNION
SELECT *
FROM #tor_pit;


-- Query all players who played for TBD & TOR franchises
SELECT DISTINCT(tbd.playerID), tbd.nameFirst, tbd.nameLast
FROM #tbd AS tbd
INNER JOIN #tor AS tor
	ON tbd.playerID = tor.playerID;