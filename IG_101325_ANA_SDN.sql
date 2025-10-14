-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for ANA franchise
SELECT DISTINCT(b.playerID), p.nameFirst, p.nameLast
INTO #ana_bat
FROM dbo.Batting AS b
INNER JOIN dbo.People AS p
	ON b.playerID = p.playerID
WHERE b.teamID IN ('ANA', 'CAL', 'LAA');


-- Create temp table for all players with pitching records for ANA franchise
SELECT DISTINCT(b.playerID), p.nameFirst, p.nameLast
INTO #ana_pit
FROM dbo.Pitching AS b
INNER JOIN dbo.People AS p
	ON b.playerID = p.playerID
WHERE b.teamID IN ('ANA', 'CAL', 'LAA');


-- Create temp table joining every recorded player for ANA franchise
SELECT *
INTO #ana
FROM #ana_bat
UNION
SELECT *
FROM #ana_pit;


-- Create temp table for all players with batting records for SDN franchise
SELECT DISTINCT(b.playerID), p.nameFirst, p.nameLast
INTO #sdn_bat
FROM dbo.Batting AS b
INNER JOIN dbo.People AS p
	ON b.playerID = p.playerID
WHERE b.teamID = 'SDN';


-- Create temp table for all players with pitching records for SDN franchise
SELECT DISTINCT(b.playerID), p.nameFirst, p.nameLast
INTO #sdn_pit
FROM dbo.Pitching AS b
INNER JOIN dbo.People AS p
	ON b.playerID = p.playerID
WHERE b.teamID = 'SDN';


-- Create temp table joining every recorded player for SDN franchise
SELECT *
INTO #sdn
FROM #sdn_bat
UNION
SELECT *
FROM #sdn_pit;


-- Query all players who played for ANA & SDN franchises
SELECT DISTINCT(ana.playerID), ana.nameFirst, ana.nameLast
FROM #ana AS ana
INNER JOIN #sdn AS sd
	ON ana.playerID = sd.playerID;
