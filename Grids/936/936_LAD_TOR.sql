-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for LAD franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast, SUM(bt.G) AS G
INTO #lad_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BR3', 'BRO', 'LAN')
GROUP BY bt.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(bt.G);


-- Create temp table for all players with pitching records for LAD franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast, SUM(pt.G) AS G
INTO #lad_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('BR3', 'BRO', 'LAN')
GROUP BY pt.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(pt.G);


-- Create temp table joining every recorded player for LAD franchise
SELECT *
INTO #lad
FROM #lad_bat
UNION
SELECT *
FROM #lad_pit;


-- Create temp table for all players with batting records for TOR franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast, SUM(bt.G) AS G
INTO #tor_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'TOR'
GROUP BY bt.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(bt.G);


-- Create temp table for all players with pitching records for TOR franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast, SUM(pt.G) AS G
INTO #tor_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'TOR'
GROUP BY pt.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(pt.G);


-- Create temp table joining every recorded player for TOR franchise
SELECT *
INTO #tor
FROM #tor_bat
UNION
SELECT *
FROM #tor_pit;


-- Query all players who played for LAD & TOR franchises
SELECT DISTINCT(lad.playerID), lad.nameFirst, lad.nameLast, lad.G, tor.G
FROM #lad AS lad
INNER JOIN #tor AS tor
	ON lad.playerID = tor.playerID
ORDER BY lad.G, tor.G;