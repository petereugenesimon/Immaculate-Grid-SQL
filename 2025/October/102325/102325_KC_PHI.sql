-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for KCR franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #kcr_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'KCA';


-- Create temp table for all players with pitching records for KCR franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #kcr_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'KCA';


-- Create temp table joining every recorded player for KCR franchise
SELECT *
INTO #kcr
FROM #kcr_bat
UNION
SELECT *
FROM #kcr_pit;


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


-- Query all players who played for KCR & PHI franchises
SELECT DISTINCT(kcr.playerID), kcr.nameFirst, kcr.nameLast
FROM #kcr AS kcr
INNER JOIN #phi AS phi
	ON kcr.playerID = phi.playerID;