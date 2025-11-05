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


-- Create temp table for all players with batting records for SEA franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #sea_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'SEA';


-- Create temp table for all players with pitching records for SEA franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #sea_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'SEA';


-- Create temp table joining every recorded player for SEA franchise
SELECT *
INTO #sea
FROM #sea_bat
UNION
SELECT *
FROM #sea_pit;


-- Query all players who played for SEA and were not born in the US
SELECT DISTINCT(sea.playerID), sea.nameFirst, sea.nameLast
FROM #sea AS sea
INNER JOIN #not_us AS not_us
	ON sea.playerID = not_us.playerID;