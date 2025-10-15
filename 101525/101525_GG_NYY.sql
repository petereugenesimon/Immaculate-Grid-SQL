-- Create a temp table for every Gold Glove
SELECT DISTINCT(playerID), awardID, yearID
INTO #gg
FROM dbo.AwardsPlayers
WHERE awardID = 'Gold Glove';


-- Create temp table for all players with batting records for NYY franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #nyy_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID IN ('BLA', 'NYA');


-- Create temp table for all players with pitching records for NYY franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
INTO #nyy_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID IN ('BLA', 'NYA');


-- Create temp table joining every recorded player for NYY franchise
SELECT *
INTO #nyy
FROM #nyy_bat
UNION
SELECT *
FROM #nyy_pit;


-- Query every player who won a Gold Glove with NYY franchise
SELECT nyy.playerID, nyy.nameFirst, nyy.nameLast, nyy.yearID, gg.awardID
FROM #gg AS gg
INNER JOIN #nyy_bat AS nyy
	ON gg.playerID = nyy.playerID AND
	gg.yearID = nyy.yearID;