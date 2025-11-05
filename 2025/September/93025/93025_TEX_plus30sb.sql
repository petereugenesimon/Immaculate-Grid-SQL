-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Query every player who recorded 30+ SB in a season for the TEX franchise
SELECT bat.playerID, play.nameFirst, play.nameLast, bat.yearID, bat.teamID, bat.SB
FROM dbo.Batting AS bat
INNER JOIN dbo.People AS play
	ON bat.playerID = play.playerID
WHERE teamID IN ('TEX', 'WS2') AND
	SB > 29;