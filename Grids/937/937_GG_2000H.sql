--- Create GG temp table for all players who have won a Gold Glove award
SELECT DISTINCT(a.playerID), p.nameFirst, p.nameLast, a.awardID
INTO #GG
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.People AS p
	ON a.playerID = p.playerID
WHERE a.awardID = 'Gold Glove';


--- Create x2000H temp table for all players who have more than 2000 hits
SELECT playerID, SUM(H) AS H
INTO #x2000H
FROM dbo.Batting
GROUP BY playerID
HAVING SUM(H) > 2000;


--- Query all players who won a Gold Glove award & have more than 2000 hits
SELECT #GG.playerID, #GG.nameFirst, #GG.nameLast, #x2000H.H
FROM #GG 
INNER JOIN #x2000H
	ON #GG.playerID = #x2000H.playerID
ORDER BY #x2000H.H ASC;