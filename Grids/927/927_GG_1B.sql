-- Create temp table for every player who won a Gold Glove and played 1B at least once
SELECT DISTINCT(gg.playerID)
INTO #gg_all1b
FROM dbo.AwardsPlayers AS gg
INNER JOIN dbo.Fielding AS all1b
	ON gg.playerID = all1b.playerID
WHERE gg.awardID = 'Gold Glove' AND
	all1b.POS = '1B';


-- Query every player who won a Gold Glove and played 1B at least once
SELECT ggfirst.playerID, p.nameFirst, p.nameLast
FROM #gg_all1b AS ggfirst
INNER JOIN dbo.People AS p
	ON ggfirst.playerID = p.playerID;