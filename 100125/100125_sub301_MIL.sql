-- LAHMAN DB DOES NOT CONTAIN ANY 2025 RECORDS


-- Query franchise & team IDs
SELECT DISTINCT(tf.franchID), tf.franchName, t.teamID, t.name
FROM dbo.TeamsFranchises AS tf
INNER JOIN dbo.Teams AS t
	ON tf.franchID = t.franchID;


-- Query every player who recorded an ERA < 3.01 in a season for the MIL franchise
SELECT pit.playerID, play.nameFirst, play.nameLast, pit.yearID, pit.teamID, pit.ERA
FROM dbo.Pitching AS pit
INNER JOIN dbo.People AS play
	ON pit.playerID = play.playerID
WHERE teamID IN ('MIL', 'ML4', 'SE1') AND
	ERA < 3.01;