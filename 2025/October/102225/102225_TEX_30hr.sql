-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for TEX franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #tex_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('TEX', 'WS2');


-- Create temp table for all players with pitching records for TEX franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #tex_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('TEX', 'WS2');


-- Create temp table joining every recorded player for TEX franchise
SELECT *
INTO #tex
FROM #tex_bat
UNION
SELECT *
FROM #tex_pit;


-- Create temp for all players who hit 30+ HR in a season with the TEX franchise
SELECT DISTINCT(playerID), teamID
INTO #tex30hr
FROM dbo.Batting
WHERE teamID IN ('TEX', 'WS2') AND
	HR >= 30;


-- Query all players who hit 30+ HR in a season with the TEX franchise
SELECT tx30hr.playerID, tex.nameFirst, tex.nameLast
FROM #tex AS tex
INNER JOIN #tex30hr AS tx30hr
	ON tex.playerID = tx30hr.playerID