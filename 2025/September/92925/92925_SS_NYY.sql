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



-- Create temp table for all players with batting records for NYY franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #nyy_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BLA', 'NYA');


-- Create temp table for all players with pitching records for NYY franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
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


-- Query every player who won a Silver Slugger with NYY franchise
SELECT nyy.playerID, nyy.nameFirst, nyy.nameLast, nyy.yearID, ss.awardID
FROM #ss AS ss
INNER JOIN #nyy_bat AS nyy
	ON ss.playerID = nyy.playerID AND
	ss.yearID = nyy.yearID;