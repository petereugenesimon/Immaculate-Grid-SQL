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


-- Create temp table for all players with batting records for DET franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #det_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'DET';


-- Create temp table for all players with pitching records for DET franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
INTO #det_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'DET';


-- Create temp table joining every recorded player for DET franchise
SELECT *
INTO #det
FROM #det_bat
UNION
SELECT *
FROM #det_pit;


-- Query every player who won a Silver Slugger with DET franchise
SELECT det.playerID, det.nameFirst, det.nameLast, det.yearID, ss.awardID
FROM #ss AS ss
INNER JOIN #det_bat AS det
	ON ss.playerID = det.playerID AND
	ss.yearID = det.yearID;