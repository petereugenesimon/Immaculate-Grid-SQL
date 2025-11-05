SELECT DISTINCT(playerID), teamID
FROM Pitching
WHERE teamID = "BOS";

SELECT DISTINCT(playerID), teamID
FROM Pitching
WHERE teamID = "NYN";

SELECT BOS.playerID
	FROM 
		(SELECT DISTINCT(playerID), teamID
		FROM Pitching
		WHERE teamID = "BOS") AS BOS
INNER JOIN 
		(SELECT DISTINCT(playerID), teamID
		FROM Pitching
		WHERE teamID = "NYN") AS NYN
	ON BOS.playerID = NYN.playerID;

SELECT IG.playerID, People.nameFirst, People.nameLast
FROM (SELECT BOS.playerID
		FROM 
			(SELECT DISTINCT(playerID), teamID
			FROM Pitching
			WHERE teamID = "BOS") AS BOS
		INNER JOIN 
			(SELECT DISTINCT(playerID), teamID
			FROM Pitching
			WHERE teamID = "NYN") AS NYN
		ON BOS.playerID = NYN.playerID) AS IG
INNER JOIN People
	ON IG.playerID = People.playerID;