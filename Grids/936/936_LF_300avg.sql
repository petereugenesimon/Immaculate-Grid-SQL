-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Create a temp table of every player played at least 1 game in LF
SELECT f.playerID, p.nameFirst, p.nameLast, SUM(f.Glf) AS LF
INTO #LF
FROM dbo.FieldingOF AS f
INNER JOIN dbo.People AS p
	ON f.playerID = p.playerID
GROUP BY f.playerID, p.nameFirst, p.nameLast
HAVING SUM(f.Glf) > 0;


-- Query every player who played at least 1 game in LF & had a .300 AVG season
SELECT DISTINCT(x300.playerID), LF.nameFirst, LF.nameLast
FROM (SELECT playerID, ((H * 1.0) / AB) AS AVG
		FROM dbo.Batting
		WHERE AB > 0 AND
			((H * 1.0) / AB) > 0.299) AS x300
INNER JOIN #LF AS LF
	ON x300.playerID = LF.playerID
ORDER BY x300.playerID;