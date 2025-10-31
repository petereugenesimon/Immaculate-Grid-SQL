-- Create a temp table for every player who recorded +30 SB in a season
SELECT DISTINCT(b.playerID), p.nameFirst, p.nameLast
INTO #sb30
FROM dbo.Batting AS b
INNER JOIN dbo.People AS p
	ON b.playerID = p.playerID
WHERE SB > 29;


-- Create temp table for every player who played 3B
SELECT DISTINCT(playerID), POS
INTO #third
FROM dbo.Fielding
WHERE POS = '3B';


-- Query every player who played 3B & recorded +30 SB in a season
SELECT DISTINCT(sb30.playerID), sb30.nameFirst, sb30.nameLast
FROM #sb30 AS sb30
INNER JOIN #third AS third
	ON sb30.playerID = third.playerID;