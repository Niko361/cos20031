SELECT Events.event_name, Competitions.competition_id 
FROM Competitions 
JOIN Events ON Competitions.event_id = Events.event_id 
WHERE `competition_id` IN (SELECT `competition_id` FROM `CompetitionEnrolments` WHERE `archer_id` = '1');

SELECT  DISTINCT Events.event_name FROM  Events;

SELECT Competitions.competition_id 
FROM Competitions 
JOIN Events ON Competitions.event_id = Events.event_id 
WHERE Events.event_name = 'Glenferrie Archery Tournament';




-- View list of scores (default- sorting the scores in desc date order).
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
ORDER BY `round_score_date_time` DESC 
LIMIT 25;



-- View list of scores (between two DateTimes)
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
WHERE round_score_date_time > '2023-04-23 08:00:00'
    AND round_score_date_time < '2023-04-23 12:00:00'
ORDER BY `round_score_date_time` DESC 
LIMIT 25;

-- View list of scores (sorting the scores in desc order of total score).
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
ORDER BY `total_score` DESC 
LIMIT 25;

-- View list of scores (filtering by range shot)
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
WHERE RoundDefinitions.round_name = 'WA70/1440'
ORDER BY `round_score_date_time` DESC 
LIMIT 25;

-- View list of scores (filtering by archer)
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
WHERE RoundScores.archer_id = '150'
ORDER BY `round_score_date_time` DESC 
LIMIT 25;

-- View list of scores (filtering by event/competition)
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
WHERE Events.event_name = 'Glenferrie Archery Tournament'
ORDER BY `round_score_date_time` DESC 
LIMIT 25;

-- Find Archer’s best score for a given round (view list of scores filtering by round definition and archer, as well as sorting by score).
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
WHERE RoundScores.archer_id = '50' AND RoundDefinitions.round_name = 'AA50/1440'
ORDER BY total_score DESC 
LIMIT 1;

-- Find best score for ever shot for a given round (view list of scores filtering by round definition).
SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
    Archers.archer_lastname AS LastName, Archers.archer_birthyear AS BirthYear,
    Categories.gender AS Gender, Categories.age_group AS AgeGroup,
    Equipment.equipment_name AS Equipment, RoundDefinitions.round_name AS RoundName, 
    Events.event_name AS EventName, championship_name AS Championship, total_score AS TotalScore
FROM `RoundScores`
JOIN `Archers` ON RoundScores.archer_id=Archers.archer_id 
JOIN Equipment ON RoundScores.equipment_id=Equipment.equipment_id
JOIN Competitions ON RoundScores.competition_id=Competitions.competition_id
JOIN RoundDefinitions ON RoundScores.round_def_id=RoundDefinitions.round_def_id
JOIN Events ON Competitions.event_id=Events.event_id
JOIN Categories ON RoundScores.category_id=Categories.category_id
JOIN Championships ON Events.championship_id=Championships.championship_id
WHERE RoundDefinitions.round_name = 'AA50/1440'
ORDER BY total_score DESC 
LIMIT 1;