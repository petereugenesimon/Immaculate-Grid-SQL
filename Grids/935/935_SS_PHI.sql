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


-- Create temp table for all players with batting records for PHI franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #phi_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'PHI';


-- Create temp table for all players with pitching records for PHI franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
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


-- Query every player who won a Silver Slugger with PHI franchise
SELECT phi.playerID, phi.nameFirst, phi.nameLast, phi.yearID, ss.awardID
FROM #ss AS ss
INNER JOIN #phi_bat AS phi
	ON ss.playerID = phi.playerID AND
	ss.yearID = phi.yearID;