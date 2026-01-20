-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for CLE franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #cle_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'CLE';


-- Create temp table for all players with pitching records for CLE franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #cle_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'CLE';


-- Create temp table joining every recorded player for CLE franchise
SELECT *
INTO #cle
FROM #cle_bat
UNION
SELECT *
FROM #cle_pit;


-- Create temp table for every player who played C for CLE franchise
SELECT DISTINCT(playerID), teamID, POS
INTO #clec
FROM dbo.Fielding
WHERE teamID = 'CLE' AND
	POS = 'C';


-- Query every player who played C for CLE franchise
SELECT DISTINCT(cle.playerID), cle.nameFirst, cle.nameLast
FROM #cle AS cle
INNER JOIN #clec AS clec
	ON cle.playerID = clec.playerID;