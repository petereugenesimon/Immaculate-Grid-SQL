--- Create MVP temp table for all players who have won an MVP award
SELECT DISTINCT(a.playerID), p.nameFirst, p.nameLast, a.awardID
INTO #MVP
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.People AS p
	ON a.playerID = p.playerID
WHERE a.awardID = 'Most Valuable Player';


--- Create x200W temp table for all players who have more than 200 pitching wins
SELECT playerID, SUM(W) AS PW
INTO #x200W
FROM dbo.Pitching
GROUP BY playerID
HAVING SUM(W) > 200;


--- Query all players who won an MVP award & have more than 200 pitching wins
SELECT #MVP.playerID, #MVP.nameFirst, #MVP.nameLast, #x200W.PW
FROM #MVP 
INNER JOIN #x200W
	ON #MVP.playerID = #x200W.playerID;