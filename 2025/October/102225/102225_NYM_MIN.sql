-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for NYM franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #nym_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'NYN';


-- Create temp table for all players with pitching records for NYM franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #nym_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'NYN';


-- Create temp table joining every recorded player for NYM franchise
SELECT *
INTO #nym
FROM #nym_bat
UNION
SELECT *
FROM #nym_pit;


-- Create temp table for all players with batting records for MIN franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #min_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('MIN', 'WS1');


-- Create temp table for all players with pitching records for MIN franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #min_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('MIN', 'WS1');


-- Create temp table joining every recorded player for MIN franchise
SELECT *
INTO #min
FROM #min_bat
UNION
SELECT *
FROM #min_pit;


-- Query all players who played for NYM & MIN franchises
SELECT DISTINCT(nym.playerID), nym.nameFirst, nym.nameLast
FROM #nym AS nym
INNER JOIN #min AS min
	ON nym.playerID = min.playerID;