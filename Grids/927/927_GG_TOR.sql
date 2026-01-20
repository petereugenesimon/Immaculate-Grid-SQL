-- Create a temp table for every Gold Glove
SELECT DISTINCT(playerID), awardID, yearID
INTO #gg
FROM dbo.AwardsPlayers
WHERE awardID = 'Gold Glove';


-- Create temp table for all players with batting records for TOR franchise
SELECT bt.playerID, p.nameFirst, p.nameLast, bt.yearID
INTO #tor_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'TOR';


-- Create temp table for all players with pitching records for TOR franchise
SELECT pt.playerID, p.nameFirst, p.nameLast, pt.yearID
INTO #tor_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'TOR';


-- Create temp table joining every recorded player for TOR franchise
SELECT *
INTO #tor
FROM #tor_bat
UNION
SELECT *
FROM #tor_pit;


-- Query every player who won a Gold Glove with TOR franchise
SELECT tor.playerID, tor.nameFirst, tor.nameLast, tor.yearID, gg.awardID
FROM #gg AS gg
INNER JOIN #tor_bat AS tor
	ON gg.playerID = tor.playerID AND
	gg.yearID = tor.yearID;