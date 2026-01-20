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


-- Create temp table for all players with batting records for MIN franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #min_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('MIN', 'WS1');


-- Create temp table for all players with pitching records for MIN franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #min_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('MIN', 'WS1');


-- Create temp table joining every recorded player for MIN franchise
SELECT *
INTO #min
FROM #min_bat
UNION
SELECT *
FROM #min_pit;


-- Query all players who played for MIN and were not born in the US
SELECT DISTINCT(min.playerID), min.nameFirst, min.nameLast
FROM #min AS min
INNER JOIN #not_us AS not_us
	ON min.playerID = not_us.playerID;