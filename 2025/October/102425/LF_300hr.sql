-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Create a temp table for all players who played at least 1 game in LF
SELECT f.playerID, p.nameFirst, p.nameLast, SUM(f.G) AS G
INTO #lf
FROM dbo.FieldingOFsplit AS f
INNER JOIN dbo.People AS p
	ON f.playerID = p.playerID
WHERE f.POS = 'LF'
GROUP BY f.playerID, p.nameFirst, p.nameLast
ORDER BY SUM(f.G);


-- Create a temp table for all players who hit at least 300 HR 
SELECT playerID, SUM(HR) AS HR
INTO #x300hr
FROM dbo.Batting
GROUP BY playerID
HAVING SUM(HR) > 299;


-- Query all players who played at least 1 game in LF & hit at least 300 HR
SELECT lf.playerID, lf.nameFirst, lf.nameLast, lf.G, x300hr.HR
FROM #lf AS lf
INNER JOIN #x300hr AS x300hr
	ON lf.playerID = x300hr.playerID
ORDER BY lf.G;