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


-- Create temp table for all players with batting records for CHC franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #chc_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'CHN';


-- Create temp table for all players with pitching records for CHC franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
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


-- Query all players who played for NYM & CHC franchises
SELECT DISTINCT(nym.playerID), nym.nameFirst, nym.nameLast
FROM #nym AS nym
INNER JOIN #chc AS chc
	ON nym.playerID = chc.playerID;