-- Query list of unique birthCountries
SELECT DISTINCT(birthCountry)
FROM dbo.People
ORDER BY birthCountry;


-- Create temp table of all players not born in the US or NOT NULL
SELECT DISTINCT(playerID), nameFirst, nameLast, birthCountry
INTO #not_us
FROM dbo.People
WHERE birthCountry != 'USA' AND
	birthCountry IS NOT NULL;


-- Create temp table for all players with batting records for LAD franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #lad_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BR3', 'BRO', 'LAN');


-- Create temp table for all players with pitching records for LAD franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #lad_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('BR3', 'BRO', 'LAN');


-- Create temp table joining every recorded player for LAD franchise
SELECT *
INTO #lad
FROM #lad_bat
UNION
SELECT *
FROM #lad_pit;


-- Query all players who played for LAD and were not born in the US
SELECT DISTINCT(lad.playerID), lad.nameFirst, lad.nameLast
FROM #lad AS lad
INNER JOIN #not_us AS not_us
	ON lad.playerID = not_us.playerID;