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


-- Create temp for all players who hit 30+ HR in a season with the NYM franchise
SELECT DISTINCT(playerID), teamID
INTO #nym30hr
FROM dbo.Batting
WHERE teamID = 'NYN' AND
	HR >= 30;


-- Query all players who hit 30+ HR in a season with the NYM franchise
SELECT nym30hr.playerID, nym.nameFirst, nym.nameLast
FROM #nym AS nym
INNER JOIN #nym30hr AS nym30hr
	ON nym.playerID = nym30hr.playerID