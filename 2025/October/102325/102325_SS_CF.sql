-- Create a temp table for every Silver Slugger who played CF at least once
SELECT a.playerID, a.awardID, a.yearID, f.POS
INTO #ss_cf
FROM dbo.AwardsPlayers AS a
INNER JOIN dbo.FieldingOFsplit AS f
	ON a.playerID = f.playerID
WHERE a.awardID = 'Silver Slugger' AND
	f.POS = 'CF';


-- Query every player who won a Silver Slugger & played CF at least once
SELECT DISTINCT(sscf.playerID), p.nameFirst, p.nameLast
FROM dbo.People AS p
INNER JOIN #ss_cf AS sscf
	ON p.playerID = sscf.playerID;