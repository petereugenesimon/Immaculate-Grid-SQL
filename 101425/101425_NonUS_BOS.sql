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


-- Create temp table for all players with batting records for BOS franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #bos_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'BOS';


-- Create temp table for all players with pitching records for BOS franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #bos_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'BOS';


-- Create temp table joining every recorded player for BOS franchise
SELECT *
INTO #bos
FROM #bos_bat
UNION
SELECT *
FROM #bos_pit;


-- Query all players who played for BOS and were not born in the US
SELECT DISTINCT(bos.playerID), bos.nameFirst, bos.nameLast
FROM #bos AS bos
INNER JOIN #not_us AS not_us
	ON bos.playerID = not_us.playerID;