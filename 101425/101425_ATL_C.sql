-- Create temp table for all players with batting records for ATL franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #atl_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('ATL', 'BSN', 'ML1');


-- Create temp table for all players with pitching records for ATL franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #atl_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('ATL', 'BSN', 'ML1');


-- Create temp table joining every recorded player for ATL franchise
SELECT *
INTO #atl
FROM #atl_bat
UNION
SELECT *
FROM #atl_pit;


-- Create a temp table of all players who have played C
SELECT DISTINCT(playerID), POS
INTO #cat
FROM dbo.Fielding
WHERE POS = 'C';


-- Query all players who played C for ATL
SELECT DISTINCT(atl.playerID), atl.nameFirst, atl.nameLast
FROM #atl AS atl
INNER JOIN #cat AS cat
	ON atl.playerID = cat.playerID;