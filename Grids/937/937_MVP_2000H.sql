--- Create MVP temp table for all players who have won an MVP award
SELECT DISTINCT(a.playerID), p.nameFirst, p.nameLast, a.awardID
INTO #MVP
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.People AS p
	ON a.playerID = p.playerID
WHERE a.awardID = 'Most Valuable Player';


--- Create x2000H temp table for all players who have more than 2000 hits
SELECT playerID, SUM(H) AS H
INTO #x2000H
FROM dbo.Batting
GROUP BY playerID
HAVING SUM(H) > 2000;


--- Query all players who won an MVP award & have more than 2000 hits
SELECT #MVP.playerID, #MVP.nameFirst, #MVP.nameLast, #x2000H.H
FROM #MVP 
INNER JOIN #x2000H
	ON #MVP.playerID = #x2000H.playerID
ORDER BY #x2000H.H ASC;