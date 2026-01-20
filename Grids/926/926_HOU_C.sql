-- Create temp table for all players with batting records for HOU franchise
SELECT DISTINCT(bt.playerID), p.nameFirst, p.nameLast
INTO #hou_bat
FROM dbo.Batting AS bt
INNER JOIN dbo.People AS p
	ON bt.playerID = p.playerID
WHERE bt.teamID = 'HOU';


-- Create temp table for all players with pitching records for HOU franchise
SELECT DISTINCT(pt.playerID), p.nameFirst, p.nameLast
INTO #hou_pit
FROM dbo.Pitching AS pt
INNER JOIN dbo.People AS p
	ON pt.playerID = p.playerID
WHERE pt.teamID = 'HOU';


-- Create temp table joining every recorded player for HOU franchise
SELECT *
INTO #hou
FROM #hou_bat
UNION
SELECT *
FROM #hou_pit;


-- Create a temp table of all players who have played C
SELECT DISTINCT(playerID), POS
INTO #cat
FROM dbo.Fielding
WHERE POS = 'C';


-- Query all players who played C for HOU
SELECT DISTINCT(hou.playerID), hou.nameFirst, hou.nameLast
FROM #hou AS hou
INNER JOIN #cat AS cat
	ON hou.playerID = cat.playerID;