-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Create temp table for all players with batting records for LAD franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast, SUM(bt.G) AS G
INTO #lad_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BR3', 'BRO', 'LAN')
GROUP BY bt.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(bt.G);


-- Create a temp table for all players who hit at least 300 HR 
SELECT playerID, SUM(HR) AS HR
INTO #x300hr
FROM dbo.Batting
GROUP BY playerID
HAVING SUM(HR) > 299;


-- Query all players who played for LAD franchise & hit at least 300 HR
SELECT lad_bat.playerID, lad_bat.nameFirst, lad_bat.nameLast, lad_bat.G, x300hr.HR
FROM #lad_bat AS lad_bat
INNER JOIN #x300hr AS x300hr
	ON lad_bat.playerID = x300hr.playerID
ORDER BY lad_bat.G, x300hr.HR;