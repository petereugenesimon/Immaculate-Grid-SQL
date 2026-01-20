--- Create MVP temp table for all players who have won an MVP award
SELECT DISTINCT(a.playerID), p.nameFirst, p.nameLast, a.awardID
INTO #MVP
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.People AS p
	ON a.playerID = p.playerID
WHERE a.awardID = 'Most Valuable Player';


--- Create temp table for all players who have played 2B
SELECT DISTINCT(playerID), POS, SUM(G) AS x2BG
INTO #x2B
FROM dbo.Fielding
WHERE POS = '2B'
GROUP BY playerID, POS;


--- Query all players who have won an MVP award & played 2B
SELECT #MVP.playerID, #MVP.nameFirst, #MVP.nameLast, #x2B.x2BG
FROM #MVP
INNER JOIN #x2B
	ON #MVP.playerID = #x2B.playerID
ORDER BY #x2B.x2BG ASC;