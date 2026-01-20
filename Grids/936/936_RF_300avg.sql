-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Create a temp table of every player played at least 1 game in RF
SELECT f.playerID, p.nameFirst, p.nameLast, SUM(f.Grf) AS RF
INTO #RF
FROM dbo.FieldingOF AS f
INNER JOIN dbo.People AS p
	ON f.playerID = p.playerID
GROUP BY f.playerID, p.nameFirst, p.nameLast
HAVING SUM(f.Grf) > 0
ORDER BY SUM(f.Grf);


-- Query every player who played at least 1 game in RF & had a .300 AVG season
SELECT DISTINCT(x300.playerID), RF.nameFirst, RF.nameLast, RF.RF
FROM (SELECT playerID, ((H * 1.0) / AB) AS AVG
		FROM dbo.Batting
		WHERE AB > 0 AND
			((H * 1.0) / AB) > 0.299) AS x300
INNER JOIN #RF AS RF
	ON x300.playerID = RF.playerID
ORDER BY RF.RF;