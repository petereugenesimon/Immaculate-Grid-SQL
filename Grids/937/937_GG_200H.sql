--- Create GG temp table for all players who have won a Gold Glove award
SELECT DISTINCT(a.playerID), p.nameFirst, p.nameLast, a.awardID
INTO #GG
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.People AS p
	ON a.playerID = p.playerID
WHERE a.awardID = 'Gold Glove';


--- Create x200W temp table for all players who have more than 200 pitching wins
SELECT playerID, SUM(W) AS PW
INTO #x200W
FROM dbo.Pitching
GROUP BY playerID
HAVING SUM(W) > 200;


--- Query all players who won a Gold Glove award & have more than 200 pitching wins
SELECT #GG.playerID, #GG.nameFirst, #GG.nameLast, #x200W.PW
FROM #GG 
INNER JOIN #x200W
	ON #GG.playerID = #x200W.playerID
ORDER BY #x200W.PW ASC;