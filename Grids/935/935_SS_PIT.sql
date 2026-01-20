-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create a temp table for every Silver Slugger
SELECT DISTINCT(playerID), awardID, yearID
INTO #ss
FROM dbo.AwardsPlayers
WHERE awardID = 'Silver Slugger';


-- Create temp table for all players with batting records for PIT franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #pit_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('PIT', 'PT1');


-- Create temp table for all players with pitching records for PIT franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
INTO #pit_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('PIT', 'PT1');


-- Create temp table joining every recorded player for PIT franchise
SELECT *
INTO #pit
FROM #pit_bat
UNION
SELECT *
FROM #pit_pit;


-- Query every player who won a Silver Slugger with PIT franchise
SELECT pit.playerID, pit.nameFirst, pit.nameLast, pit.yearID, ss.awardID
FROM #ss AS ss
INNER JOIN #pit_bat AS pit
	ON ss.playerID = pit.playerID AND
	ss.yearID = pit.yearID;