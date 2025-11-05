-- Create a temp table for every player who recorded +2,000 hits
SELECT b.playerID, p.nameFirst, p.nameLast, SUM(b.H) AS H
INTO #twogh
FROM dbo.Batting AS b
INNER JOIN dbo.People AS p
	ON b.playerID = p.playerID
GROUP BY b.playerID, p.nameFirst, p.nameLast
HAVING SUM(H) > 1999
ORDER BY H DESC;


-- Create temp table for every player who played C
SELECT DISTINCT(playerID), POS
INTO #catch
FROM dbo.Fielding
WHERE POS = 'C';


-- Query every player who played C & recorded +2,000 hits
SELECT DISTINCT(twogh.playerID), twogh.nameFirst, twogh.nameLast
FROM #twogh AS twogh
INNER JOIN #catch AS c
	ON twogh.playerID = c.playerID;