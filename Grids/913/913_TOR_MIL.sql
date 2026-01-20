-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


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


-- Create temp table for all players with batting records for MIL franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #mil_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('MIL', 'ML4', 'SE1');


-- Create temp table for all players with pitching records for MIL franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #mil_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('MIL', 'ML4', 'SE1');


-- Create temp table joining every recorded player for MIL franchise
SELECT *
INTO #mil
FROM #mil_bat
UNION
SELECT *
FROM #mil_pit;


-- Query all players who played for TOR & MIL franchises
SELECT DISTINCT(tor.playerID), tor.nameFirst, tor.nameLast
FROM #tor AS tor
INNER JOIN #mil AS mil
	ON tor.playerID = mil.playerID;