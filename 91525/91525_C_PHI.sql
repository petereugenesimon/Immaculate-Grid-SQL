-- Create temp table for all players with batting records for PHI franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #phi_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'PHI';


-- Create temp table for all players with pitching records for PHI franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
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


-- Create temp table for every player who played C for PHI franchise
SELECT DISTINCT(playerID), teamID, POS
INTO #phic
FROM dbo.Fielding
WHERE teamID = 'PHI' AND
	POS = 'C';


-- Query every player who played C for PHI franchise
SELECT DISTINCT(phi.playerID), phi.nameFirst, phi.nameLast
FROM #phi AS phi
INNER JOIN #phic AS phic
	ON phi.playerID = phic.playerID;