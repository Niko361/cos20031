-- Add Archer (including adding an account and setting password to "password")
START TRANSACTION;
INSERT INTO `Archers` (archer_firstname, archer_lastname, archer_gender, archer_birthyear) 
    VALUES ('Freddy', 'McDouglas', 'M', 1953);
INSERT INTO `UserAccounts` (user_id, user_password, is_recorder) 
    VALUES ((SELECT archer_id FROM `Archers` ORDER BY archer_id DESC LIMIT 1), 'password', '0');
COMMIT;
SELECT * FROM `Archers` ORDER BY archer_id DESC LIMIT 1;
SELECT * FROM `UserAccounts` ORDER BY user_id DESC LIMIT 1;

-- Add Recorder (including adding password).
START TRANSACTION;
INSERT INTO `Archers` (archer_firstname, archer_lastname, archer_gender, archer_birthyear) 
    VALUES ('Maria', 'McRecorda', 'F', 1960);
INSERT INTO `UserAccounts` (user_id, user_password, is_recorder) 
    VALUES ((SELECT archer_id FROM `Archers` ORDER BY archer_id DESC LIMIT 1), 'password', '1');
COMMIT;
SELECT * FROM `Archers` ORDER BY archer_id DESC LIMIT 1;
SELECT * FROM `UserAccounts` ORDER BY user_id DESC LIMIT 1;

-- Change Password (for both Archer and Recorder).
SELECT * FROM `UserAccounts` WHERE user_id = '250';
UPDATE `UserAccounts`
    SET user_password = 'newpassword' 
    WHERE user_id = '250';
SELECT * FROM `UserAccounts` WHERE user_id = '250';


-- Add Score into staging tables (as practice, by archer).
START TRANSACTION;
INSERT INTO RoundScoresStaging (archer_id, round_score_date_time, equipment_id, round_def_id, total_score, category_id) 
    VALUES ('3', '2023-04-23 17:25:7.85', 'L', '4', '683', '28');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '13');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '8', '5', '3', '2', '2', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '8', '7', '7', '3', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '9', '5', '5', '4', '4', '2');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '8', '7', '6', '4', '0', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '9', '8', '6', '5', '4', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '9', '9', '7', '7', '6', '3');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '14');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '6', '5', '4', '2', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '8', '7', '3', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '8', '5', '4', '3', '3', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '8', '7', '5', '2', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '9', '8', '6', '6', '6', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '9', '5', '4', '2', '0', '0');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '15');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '9', '8', '6', '6', '3', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '9', '6', '6', '3', '3');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '9', '8', '6', '5', '4', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '8', '7', '3', '3', '2', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '8', '7', '5', '2', '0', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '8', '7', '6', '6', '1', '0');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '16');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '9', '7', '7', '7', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '9', '8', '6', '4', '3');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '9', '8', '2', '2', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '9', '8', '8', '7', '4', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '6', '5', '4', '4', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '7', '7', '6', '4', '1', '1');
COMMIT;

SELECT * FROM `RoundScoresStaging` ORDER BY `round_score_id` DESC LIMIT 1;
SELECT * FROM `RangeScoresStaging` ORDER BY `range_score_id` DESC LIMIT 4;
SELECT * FROM `EndScoresStaging` ORDER BY `end_id` DESC LIMIT 24;

-- Add Score into staging tables (as a part of a competition, by archer).
START TRANSACTION;
INSERT INTO RoundScoresStaging (archer_id, competition_id, round_score_date_time, equipment_id, round_def_id, total_score, category_id) 
    VALUES ('3', '28', '2023-04-23 17:25:7.85', 'L', '4', '683', '28');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '13');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '8', '5', '3', '2', '2', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '8', '7', '7', '3', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '9', '5', '5', '4', '4', '2');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '8', '7', '6', '4', '0', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '9', '8', '6', '5', '4', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '9', '9', '7', '7', '6', '3');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '14');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '6', '5', '4', '2', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '8', '7', '3', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '8', '5', '4', '3', '3', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '8', '7', '5', '2', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '9', '8', '6', '6', '6', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '9', '5', '4', '2', '0', '0');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '15');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '9', '8', '6', '6', '3', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '9', '6', '6', '3', '3');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '9', '8', '6', '5', '4', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '8', '7', '3', '3', '2', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '8', '7', '5', '2', '0', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '8', '7', '6', '6', '1', '0');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) 
    VALUES ((SELECT round_score_id FROM `RoundScoresStaging` ORDER BY round_score_id DESC LIMIT 1), '16');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '1', '9', '7', '7', '7', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '2', '9', '9', '8', '6', '4', '3');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '3', '9', '8', '2', '2', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '4', '9', '8', '8', '7', '4', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '5', '6', '5', '4', '4', '1', '0');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
    VALUES ((SELECT range_score_id FROM `RangeScoresStaging` ORDER BY range_score_id DESC LIMIT 1), '6', '7', '7', '6', '4', '1', '1');
COMMIT;

SELECT * FROM `RoundScoresStaging` ORDER BY `round_score_id` DESC LIMIT 1;
SELECT * FROM `RangeScoresStaging` ORDER BY `range_score_id` DESC LIMIT 4;
SELECT * FROM `EndScoresStaging` ORDER BY `end_id` DESC LIMIT 24;

-- View list of scores in staging tables (by recorder).
SELECT * FROM `RoundScoresStaging` ORDER BY `round_score_id`;

-- Edit Score in staging table (by recorder).
SELECT * FROM `RoundScoresStaging` WHERE round_score_id = '6';
SELECT * FROM `EndScoresStaging` WHERE end_id = '144';
UPDATE `RoundScoresStaging`
    SET total_score = '685' 
    WHERE round_score_id = '6';
UPDATE `EndScoresStaging`
    SET score_arrow1 = '9'
    WHERE end_id = '144';
SELECT * FROM `RoundScoresStaging` WHERE round_score_id = '6';
SELECT * FROM `EndScoresStaging` WHERE end_id = '144';

-- Forward/Duplicate data from staging to main scores tables (by recorder- approve button, ensure that scores in each end are sorted by score)
START TRANSACTION;
INSERT INTO RoundScores (archer_id, competition_id, round_score_date_time, equipment_id, round_def_id, total_score, category_id) 
SELECT archer_id, competition_id, round_score_date_time, equipment_id, round_def_id, total_score, category_id
FROM RoundScoresStaging
WHERE RoundScoresStaging.round_score_id = '1';

INSERT INTO RangeScores (round_score_id, round_range_id) 
SELECT
    (SELECT round_score_id FROM `RoundScores` ORDER BY round_score_id DESC LIMIT 1),
    RangeScoresStaging.round_range_id
    FROM RangeScoresStaging 
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '1';
INSERT INTO EndScores(range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
SELECT
    (SELECT range_score_id FROM `RangeScores` ORDER BY range_score_id DESC LIMIT 1),
    end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6 
    FROM EndScoresStaging 
    INNER JOIN RangeScoresStaging
    ON EndScoresStaging.range_score_id = RangeScoresStaging.range_score_id
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '1';

INSERT INTO RangeScores (round_score_id, round_range_id) 
SELECT
    (SELECT round_score_id FROM `RoundScores` ORDER BY round_score_id DESC LIMIT 1),
    RangeScoresStaging.round_range_id
    FROM RangeScoresStaging 
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '2';
INSERT INTO EndScores(range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
SELECT
    (SELECT range_score_id FROM `RangeScores` ORDER BY range_score_id DESC LIMIT 1),
    end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6 
    FROM EndScoresStaging 
    INNER JOIN RangeScoresStaging
    ON EndScoresStaging.range_score_id = RangeScoresStaging.range_score_id
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '2';
INSERT INTO RangeScores (round_score_id, round_range_id) 
SELECT
    (SELECT round_score_id FROM `RoundScores` ORDER BY round_score_id DESC LIMIT 1),
    RangeScoresStaging.round_range_id
    FROM RangeScoresStaging 
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '3';
INSERT INTO EndScores(range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
SELECT
    (SELECT range_score_id FROM `RangeScores` ORDER BY range_score_id DESC LIMIT 1),
    end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6 
    FROM EndScoresStaging 
    INNER JOIN RangeScoresStaging
    ON EndScoresStaging.range_score_id = RangeScoresStaging.range_score_id
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '3';
INSERT INTO RangeScores (round_score_id, round_range_id) 
SELECT
    (SELECT round_score_id FROM `RoundScores` ORDER BY round_score_id DESC LIMIT 1),
    RangeScoresStaging.round_range_id
    FROM RangeScoresStaging 
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '4';

INSERT INTO EndScores(range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) 
SELECT
    (SELECT range_score_id FROM `RangeScores` ORDER BY range_score_id DESC LIMIT 1),
    end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6 
    FROM EndScoresStaging 
    INNER JOIN RangeScoresStaging
    ON EndScoresStaging.range_score_id = RangeScoresStaging.range_score_id
    INNER JOIN RoundRange
    ON RangeScoresStaging.round_range_id = RoundRange.round_range_id
    WHERE RangeScoresStaging.round_score_id = '1' 
    AND RoundRange.range_number = '4';
COMMIT;

SELECT * FROM `RoundScores` ORDER BY `round_score_id` DESC LIMIT 1;
SELECT * FROM `RangeScores` ORDER BY `range_score_id` DESC LIMIT 4;
SELECT * FROM `EndScores` ORDER BY `end_id` DESC LIMIT 24;



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

-- View Score details
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
WHERE round_score_id = '10';

SELECT end_id, target_distance, target_size, range_number, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6
FROM RangeScores 
INNER JOIN RoundRange
ON RangeScores.round_range_id = RoundRange.round_range_id
INNER JOIN EndScores
ON RangeScores.range_score_id = EndScores.range_score_id
WHERE RangeScores.round_score_id = '10'
ORDER BY end_id ASC;


-- View Round Definitions.
SELECT *
FROM RoundDefinitions
INNER JOIN RoundRange
ON RoundDefinitions.round_def_id = RoundRange.round_def_id
WHERE RoundDefinitions.round_name = 'WA70/1440';

-- View Rounds Equivalent to a given round
SELECT RoundDefinitionsBase.round_name AS BaseRound, RoundDefinitionsEquivalent.round_name AS EquivalentRound,Categories.gender AS EquivalentGender, Categories.age_group AS EquivalentAgeGroup, 
    Equipment.equipment_name AS EquivalentEquipment
FROM EquivalentRounds
JOIN Categories ON EquivalentRounds.equivalent_category_id = Categories.category_id
JOIN RoundDefinitions RoundDefinitionsEquivalent ON EquivalentRounds.equivalent_round_def_id = RoundDefinitionsEquivalent.round_def_id
JOIN RoundDefinitions RoundDefinitionsBase ON EquivalentRounds.base_round_def_id = RoundDefinitionsBase.round_def_id
JOIN Equipment ON Categories.equipment_id=Equipment.equipment_id
WHERE EquivalentRounds.base_round_def_id = '1';

-- Add new Round Definitions (by recorders).
START TRANSACTION;
INSERT INTO `RoundDefinitions` (round_name) 
    VALUES ('Long Sydney');
INSERT INTO `RoundRange` (round_def_id, target_distance, target_size, range_number, end_count) 
    VALUES ((SELECT round_def_id FROM `RoundDefinitions` ORDER BY round_def_id DESC LIMIT 1), '90m', '122cm', '1', '5');
INSERT INTO `RoundRange` (round_def_id, target_distance, target_size, range_number, end_count) 
    VALUES ((SELECT round_def_id FROM `RoundDefinitions` ORDER BY round_def_id DESC LIMIT 1), '70m', '122cm', '2', '5');
INSERT INTO `RoundRange` (round_def_id, target_distance, target_size, range_number, end_count) 
    VALUES ((SELECT round_def_id FROM `RoundDefinitions` ORDER BY round_def_id DESC LIMIT 1), '60m', '122cm', '3', '5');
INSERT INTO `RoundRange` (round_def_id, target_distance, target_size, range_number, end_count) 
    VALUES ((SELECT round_def_id FROM `RoundDefinitions` ORDER BY round_def_id DESC LIMIT 1), '50m', '122cm', '4', '5');
COMMIT;
SELECT *
FROM RoundDefinitions
INNER JOIN RoundRange
ON RoundDefinitions.round_def_id = RoundRange.round_def_id
WHERE RoundDefinitions.round_def_id = (SELECT round_def_id FROM `RoundDefinitions` ORDER BY round_def_id DESC LIMIT 1);

-- Add new competition that is linked to a championship (By recorders)
START TRANSACTION;
INSERT INTO Events (event_name, base_round_id, championship_id) VALUES ('Glenferrie Archery Tournament', '1', '9');
INSERT INTO Competitions (event_id, category_id, round_def_id) 
    VALUES ((SELECT event_id FROM `Events` ORDER BY event_id DESC LIMIT 1),
    (SELECT category_id FROM Categories WHERE age_group = 'U18' AND gender = 'M' AND equipment_id = 'C'), '1');
COMMIT;

SELECT * FROM Events
JOIN Competitions
ON Events.event_id = Competitions.event_id
JOIN Categories
ON Competitions.category_id = Categories.category_id
LEFT JOIN Championships
ON Events.championship_id = Championships.championship_id
WHERE Events.event_id = (SELECT event_id FROM `Events` ORDER BY event_id DESC LIMIT 1);

-- Add new competition that is not linked to a championship (By recorders)
START TRANSACTION;
INSERT INTO Events (event_name, base_round_id) VALUES ('Glenferrie Archery Tournament', '1');
INSERT INTO Competitions (event_id, category_id, round_def_id) 
    VALUES ((SELECT event_id FROM `Events` ORDER BY event_id DESC LIMIT 1), 
    (SELECT category_id FROM Categories WHERE age_group = 'O70' AND gender = 'F' AND equipment_id = 'C'), '1');
COMMIT;

SELECT * FROM Events
JOIN Competitions
ON Events.event_id = Competitions.event_id
JOIN Categories
ON Competitions.category_id = Categories.category_id
LEFT JOIN Championships
ON Events.championship_id = Championships.championship_id
WHERE Events.event_id = (SELECT event_id FROM `Events` ORDER BY event_id DESC LIMIT 1);

-- Enrol Archers into competitions (By recorders)
INSERT INTO CompetitionEnrolments (archer_id, competition_id) VALUES ('3', '28');
SELECT * FROM CompetitionEnrolments WHERE archer_id = '3' AND competition_id = '28' LIMIT 1;