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


-- Query every player who won a Silver Slugger with CHC franchise
SELECT chc.playerID, chc.nameFirst, chc.nameLast, chc.yearID, ss.awardID
FROM #ss AS ss
INNER JOIN #chc_bat AS chc
	ON ss.playerID = chc.playerID AND
	ss.yearID = chc.yearID;