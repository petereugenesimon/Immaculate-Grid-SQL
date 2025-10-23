-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for NYY franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #nyy_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BLA', 'NYA');


-- Create temp table for all players with pitching records for NYY franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #nyy_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('BLA', 'NYA');


-- Create temp table joining every recorded player for NYY franchise
SELECT *
INTO #nyy
FROM #nyy_bat
UNION
SELECT *
FROM #nyy_pit;


-- Create temp table for every player who played C for NYY franchise
SELECT DISTINCT(playerID), teamID, POS
INTO #nyyc
FROM dbo.Fielding
WHERE teamID IN ('BLA', 'NYA') AND
	POS = 'C';


-- Query every player who played C for NYY franchise
SELECT DISTINCT(nyy.playerID), nyy.nameFirst, nyy.nameLast
FROM #nyy AS nyy
INNER JOIN #nyyc AS nyyc
	ON nyy.playerID = nyyc.playerID;