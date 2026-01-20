-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Create a temp table for all players who played at least 1 game in RF
SELECT f.playerID, p.nameFirst, p.nameLast, SUM(f.G) AS G
INTO #rf
FROM dbo.FieldingOFsplit AS f
INNER JOIN dbo.People AS p
	ON f.playerID = p.playerID
WHERE f.POS = 'RF'
GROUP BY f.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(f.G);


-- Create a temp table for all players who hit at least 300 HR 
SELECT playerID, SUM(HR) AS HR
INTO #x300hr
FROM dbo.Batting
GROUP BY playerID
HAVING SUM(HR) > 299;


-- Query all players who played at least 1 game in RF & hit at least 300 HR
SELECT rf.playerID, rf.nameFirst, rf.nameLast, rf.G, x300hr.HR
FROM #rf AS rf
INNER JOIN #x300hr AS x300hr
	ON rf.playerID = x300hr.playerID
ORDER BY rf.G;