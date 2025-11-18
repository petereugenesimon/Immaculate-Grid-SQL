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


-- Create temp for all players who hit 30+ HR in a season
SELECT DISTINCT(playerID)
INTO #30hr
FROM dbo.Batting
WHERE HR >= 30;


-- Query all players born outside the US who hit 30+ HR in a season
SELECT x30hr.playerID, not_us.nameFirst, not_us.nameLast
FROM #not_us AS not_us
INNER JOIN #30hr AS x30hr
	ON not_us.playerID = x30hr.playerID