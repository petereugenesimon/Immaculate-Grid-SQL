--- Create GG temp table for all players who have won a Gold Glove award
SELECT DISTINCT(a.playerID), p.nameFirst, p.nameLast, a.awardID
INTO #GG
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.People AS p
	ON a.playerID = p.playerID
WHERE a.awardID = 'Gold Glove';


--- Create temp table for all players who have played 2B
SELECT DISTINCT(playerID), POS, SUM(G) AS x2BG
INTO #x2B
FROM dbo.Fielding
WHERE POS = '2B'
GROUP BY playerID, POS;


--- Query all players who have won an MVP award & played 2B
SELECT #GG.playerID, #GG.nameFirst, #GG.nameLast, #x2B.x2BG
FROM #GG
INNER JOIN #x2B
	ON #GG.playerID = #x2B.playerID
ORDER BY #x2B.x2BG ASC;