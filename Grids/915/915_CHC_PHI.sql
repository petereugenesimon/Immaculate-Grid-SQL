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


-- Create temp table for all players with batting records for PHI franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #phi_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'PHI';


-- Create temp table for all players with pitching records for PHI franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #phi_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'PHI';


-- Create temp table joining every recorded player for PHI franchise
SELECT *
INTO #phi
FROM #phi_bat
UNION
SELECT *
FROM #phi_pit;


-- Query all players who played for CHC & PHI franchises
SELECT DISTINCT(chc.playerID), chc.nameFirst, chc.nameLast
FROM #chc AS chc
INNER JOIN #phi AS phi
	ON chc.playerID = phi.playerID;