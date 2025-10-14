-- Create temp table of all players not born in the US or NOT NULL
SELECT DISTINCT(playerID), nameFirst, nameLast, birthCountry
INTO #not_us
FROM dbo.People
WHERE birthCountry != 'USA' AND
	birthCountry IS NOT NULL;


-- Create a temp table of all players who have played C
SELECT DISTINCT(playerID), POS
INTO #cat
FROM dbo.Fielding
WHERE POS = 'C';


-- Query all players who have played C and were not born in the US
SELECT DISTINCT(not_us.playerID), not_us.nameFirst, not_us.nameLast
FROM #cat AS cat
INNER JOIN #not_us AS not_us
	ON cat.playerID = not_us.playerID;