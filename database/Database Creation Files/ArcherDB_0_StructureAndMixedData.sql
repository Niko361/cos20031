USE `s100595852_db`;
DROP TABLE IF EXISTS `EndScores`;
DROP TABLE IF EXISTS `EndScoresStaging`;
DROP TABLE IF EXISTS `RangeScores`;
DROP TABLE IF EXISTS `RangeScoresStaging`;
DROP TABLE IF EXISTS `RoundScores`;
DROP TABLE IF EXISTS `RoundScoresStaging`;
DROP TABLE IF EXISTS `UserAccounts`;
DROP TABLE IF EXISTS `CompetitionEnrolments`;
DROP TABLE IF EXISTS `Archers`;
DROP TABLE IF EXISTS `EquivalentRounds`;
DROP TABLE IF EXISTS `Competitions`;
DROP TABLE IF EXISTS `Categories`;
DROP TABLE IF EXISTS `RoundRange`;
DROP TABLE IF EXISTS `Events`;
DROP TABLE IF EXISTS `RoundDefinitions`;
DROP TABLE IF EXISTS `Equipment`;
DROP TABLE IF EXISTS `Championships`;


CREATE TABLE `Championships` (
    `championship_id` INT NOT NULL AUTO_INCREMENT,
    `championship_name` VARCHAR(50),
    PRIMARY KEY (`championship_id`)
);
CREATE TABLE `Equipment` (
    `equipment_id` ENUM('R', 'C', 'B', 'L'),
    `equipment_name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`equipment_id`)
);
CREATE TABLE `RoundDefinitions` (
    `round_def_id` INT NOT NULL AUTO_INCREMENT,
    `round_name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`round_def_id`)
);
CREATE TABLE `RoundRange` (
    `round_range_id` INT NOT NULL AUTO_INCREMENT,
    `target_distance` ENUM(
        '10m',
        '20m',
        '30m',
        '40m',
        '50m',
        '60m',
        '70m',
        '90m'
    ) NOT NULL,
    `target_size` ENUM('80cm', '122cm') NOT NULL,
    `range_number` INT NOT NULL,
    `end_count` INT NOT NULL,
    `round_def_id` INT NOT NULL,
    PRIMARY KEY (`round_range_id`),
    FOREIGN KEY (`round_def_id`) REFERENCES `RoundDefinitions` (`round_def_id`)

);
CREATE TABLE `Categories` (
    `category_id` INT NOT NULL AUTO_INCREMENT,
    `age_group` ENUM(
        'Open',
        'O50',
        'O60',
        'O70',
        'U21',
        'U18',
        'U16',
        'U14'
    ) NOT NULL,
    `gender` ENUM('M', 'F') NOT NULL,
    `equipment_id` ENUM('R', 'C', 'B', 'L'),
    PRIMARY KEY (`category_id`),
    FOREIGN KEY (`equipment_id`) REFERENCES `Equipment` (`equipment_id`)
);
CREATE TABLE `Events` (
    `event_id` INT NOT NULL AUTO_INCREMENT,
    `event_name` VARCHAR(50) NOT NULL,
    `championship_id` INT,
    `base_round_id` INT NOT NULL,
    PRIMARY KEY (`event_id`),
    FOREIGN KEY (`championship_id`) REFERENCES `Championships` (`championship_id`),
    FOREIGN KEY (`base_round_id`) REFERENCES `RoundDefinitions` (`round_def_id`)
);
CREATE TABLE `Competitions` (
    `competition_id` INT NOT NULL AUTO_INCREMENT,
    `event_id` INT NOT NULL,
    `category_id` INT NOT NULL,
    `round_def_id` INT NOT NULL,
    PRIMARY KEY (`competition_id`),
    FOREIGN KEY (`event_id`) REFERENCES `Events` (`event_id`),
    FOREIGN KEY (`category_id`) REFERENCES `Categories` (`category_id`),
    FOREIGN KEY (`round_def_id`) REFERENCES `RoundDefinitions` (`round_def_id`)
);
CREATE TABLE `EquivalentRounds` (
    `equivalent_round_id` INT NOT NULL AUTO_INCREMENT,
    `equivalent_category_id` INT NOT NULL,
    `equivalent_round_def_id` INT NOT NULL,
    `date_from` DATE NOT NULL,
    `date_to` DATE,
    `base_round_def_id` INT NOT NULL,
    PRIMARY KEY (`equivalent_round_id`),
    FOREIGN KEY (`equivalent_category_id`) REFERENCES `Categories` (`category_id`),
    FOREIGN KEY (`equivalent_round_def_id`) REFERENCES `RoundDefinitions` (`round_def_id`),
    FOREIGN KEY (`base_round_def_id`) REFERENCES `RoundDefinitions` (`round_def_id`)
);
CREATE TABLE `Archers` (
    `archer_id` int NOT NULL AUTO_INCREMENT,
    `archer_firstname` VARCHAR(50),
    `archer_lastname` VARCHAR(50),
    `archer_gender` VARCHAR(1) NOT NULL,
    `archer_birthyear` int NOT NULL,
    PRIMARY KEY (`archer_id`)
);
CREATE TABLE `RoundScores` (
    `round_score_id` INT NOT NULL AUTO_INCREMENT,
    `archer_id` INT NOT NULL,
    `competition_id` INT,
    `round_score_date_time` TIMESTAMP NOT NULL,
    `equipment_id` ENUM('R', 'C', 'B', 'L'),
    `round_def_id` INT NOT NULL,
    `total_score` INT,
    `category_id` INT NOT NULL,
    PRIMARY KEY (`round_score_id`),
    FOREIGN KEY (`archer_id`) REFERENCES `Archers` (`archer_id`),
    FOREIGN KEY (`competition_id`) REFERENCES `Competitions` (`competition_id`),
    FOREIGN KEY (`category_id`) REFERENCES `Categories` (`category_id`),
    FOREIGN KEY (`equipment_id`) REFERENCES `Equipment` (`equipment_id`),
    FOREIGN KEY (`round_def_id`) REFERENCES `RoundDefinitions` (`round_def_id`)
);
CREATE TABLE `RoundScoresStaging` (
    `round_score_id` INT NOT NULL AUTO_INCREMENT,
    `archer_id` INT NOT NULL,
    `competition_id` INT,
    `round_score_date_time` TIMESTAMP NOT NULL,
    `equipment_id` ENUM('R', 'C', 'B', 'L'),
    `round_def_id` INT NOT NULL,
    `total_score` INT,
    `category_id` INT NOT NULL,
    PRIMARY KEY (`round_score_id`),
    FOREIGN KEY (`archer_id`) REFERENCES `Archers` (`archer_id`),
    FOREIGN KEY (`competition_id`) REFERENCES `Competitions` (`competition_id`),
    FOREIGN KEY (`category_id`) REFERENCES `Categories` (`category_id`),
    FOREIGN KEY (`equipment_id`) REFERENCES `Equipment` (`equipment_id`),
    FOREIGN KEY (`round_def_id`) REFERENCES `RoundDefinitions` (`round_def_id`)
);
CREATE TABLE `RangeScores` (
    `range_score_id` INT NOT NULL AUTO_INCREMENT,
    `round_score_id` INT NOT NULL,
    `round_range_id` INT NOT NULL,
    PRIMARY KEY (`range_score_id`),
    FOREIGN KEY (`round_score_id`) REFERENCES `RoundScores` (`round_score_id`)
);
CREATE TABLE `RangeScoresStaging` (
    `range_score_id` INT NOT NULL AUTO_INCREMENT,
    `round_score_id` INT NOT NULL,
    `round_range_id` INT NOT NULL,
    PRIMARY KEY (`range_score_id`),
    FOREIGN KEY (`round_score_id`) REFERENCES `RoundScoresStaging` (`round_score_id`)
);
CREATE TABLE `EndScores` (
    `end_id` INT NOT NULL AUTO_INCREMENT,
    `range_score_id` INT NOT NULL,
    `end_number` INT NOT NULL,
    `score_arrow1` INT NOT NULL,
    `score_arrow2` INT NOT NULL,
    `score_arrow3` INT NOT NULL,
    `score_arrow4` INT NOT NULL,
    `score_arrow5` INT NOT NULL,
    `score_arrow6` INT NOT NULL,
    PRIMARY KEY (`end_id`),
    FOREIGN KEY (`range_score_id`) REFERENCES `RangeScores` (`range_score_id`)
);
CREATE TABLE `EndScoresStaging` (
    `end_id` INT NOT NULL AUTO_INCREMENT,
    `range_score_id` INT NOT NULL,
    `end_number` INT NOT NULL,
    `score_arrow1` INT NOT NULL,
    `score_arrow2` INT NOT NULL,
    `score_arrow3` INT NOT NULL,
    `score_arrow4` INT NOT NULL,
    `score_arrow5` INT NOT NULL,
    `score_arrow6` INT NOT NULL,
    PRIMARY KEY (`end_id`),
    FOREIGN KEY (`range_score_id`) REFERENCES `RangeScoresStaging` (`range_score_id`)
);

CREATE TABLE `UserAccounts` (
  `user_id` INT NOT NULL,
  `user_password` VARCHAR(50),
  `is_recorder` BOOLEAN NOT NULL,
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `Archers` (`archer_id`)
);

CREATE TABLE `CompetitionEnrolments` (
  `archer_id` INT NOT NULL,
  `competition_id` INT NOT NULL,
  KEY `PK+` (`archer_id`, `competition_id`),
  FOREIGN KEY (`archer_id`) REFERENCES `Archers` (`archer_id`),
  FOREIGN KEY (`competition_id`) REFERENCES `Competitions` (`competition_id`)
);


-- added a few indexes based on columns that are likely to require rapid lookups
CREATE INDEX idx_RoundScoreArcherID ON RoundScores (archer_id); 
CREATE INDEX idx_RoundScoreCompetitionID ON RoundScores (competition_id); 
CREATE INDEX idx_RoundScoreCategoryID ON RoundScores (category_id); 
CREATE INDEX idx_RoundScoreDateTime ON RoundScores (round_score_date_time); 
CREATE INDEX idx_RoundScoreTotalScore ON RoundScores (total_score); 

-- probably not necessary unless there are many competitions added to the database
CREATE INDEX idx_CompetitionCategory ON Competitions (category_id); 

CREATE INDEX idx_RangeScoreRoundScoreID ON RangeScores (round_score_id); 
CREATE INDEX idx_EndScoresRangeScoreID ON EndScores (range_score_id); 

-- may not be needed depending on how many scores are kept in the staging tables, but doesn't cost much to add
CREATE INDEX idx_RangeScoreStagingRoundScoreID ON RangeScoresStaging (round_score_id); 
CREATE INDEX idx_EndScoresStagingRangeScoreID ON EndScoresStaging (range_score_id); 



-- Only need a couple of archers here to ensure that the UserAccounts and RoundScoresStaging tables can be populated
INSERT INTO Archers (archer_id, archer_firstname, archer_lastname, archer_gender, archer_birthyear) VALUES ('1', 'Aron', 'Hrynczyk', 'M', '1994');
INSERT INTO UserAccounts(user_id, user_password, is_recorder) VALUES ('1', 'password', '0');

INSERT INTO Archers (archer_id, archer_firstname, archer_lastname, archer_gender, archer_birthyear) VALUES ('2', 'Delaney', 'McDermot', 'M', '1940');
INSERT INTO UserAccounts(user_id, user_password, is_recorder) VALUES ('2', 'password', '1');

INSERT INTO Championships (championship_id, championship_name) VALUES ('1', '2015');
INSERT INTO Championships (championship_id, championship_name) VALUES ('2', '2016');
INSERT INTO Championships (championship_id, championship_name) VALUES ('3', '2017');
INSERT INTO Championships (championship_id, championship_name) VALUES ('4', '2018');
INSERT INTO Championships (championship_id, championship_name) VALUES ('5', '2019');
INSERT INTO Championships (championship_id, championship_name) VALUES ('6', '2020');
INSERT INTO Championships (championship_id, championship_name) VALUES ('7', '2021');
INSERT INTO Championships (championship_id, championship_name) VALUES ('8', '2022');
INSERT INTO Championships (championship_id, championship_name) VALUES ('9', '2023');

INSERT INTO Equipment (equipment_id, equipment_name) VALUES ('R', 'Recurve');
INSERT INTO Equipment (equipment_id, equipment_name) VALUES ('C', 'Compound');
INSERT INTO Equipment (equipment_id, equipment_name) VALUES ('B', 'Recurve/Compound Barebow');
INSERT INTO Equipment (equipment_id, equipment_name) VALUES ('L', 'LongBow');

INSERT INTO RoundDefinitions (round_def_id, round_name) VALUES ('1', 'WA90/1440');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('1', '90m', '122cm', '1', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('1', '70m', '122cm', '2', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('1', '50m', '80cm', '3', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('1', '30m', '80cm', '4', '6');

INSERT INTO RoundDefinitions (round_def_id, round_name) VALUES ('2', 'WA70/1440');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('2', '70m', '122cm', '1', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('2', '60m', '122cm', '2', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('2', '50m', '80cm', '3', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('2', '30m', '80cm', '4', '6');

INSERT INTO RoundDefinitions (round_def_id, round_name) VALUES ('3', 'WA60/1440');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('3', '60m', '122cm', '1', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('3', '50m', '122cm', '2', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('3', '40m', '80cm', '3', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('3', '30m', '80cm', '4', '6');

INSERT INTO RoundDefinitions (round_def_id, round_name) VALUES ('4', 'AA50/1440');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('4', '50m', '122cm', '1', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('4', '40m', '122cm', '2', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('4', '30m', '80cm', '3', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('4', '20m', '80cm', '4', '6');

INSERT INTO RoundDefinitions (round_def_id, round_name) VALUES ('5', 'AA40/1440');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('5', '40m', '122cm', '1', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('5', '30m', '122cm', '2', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('5', '30m', '80cm', '3', '6');
INSERT INTO RoundRange (round_def_id, target_distance, target_size, range_number, end_count) VALUES ('5', '20m', '80cm', '4', '6');

INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('1', 'Open', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('2', 'Open', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('3', 'Open', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('4', 'Open', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('5', 'Open', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('6', 'Open', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('7', 'Open', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('8', 'Open', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('9', 'O50', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('10', 'O50', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('11', 'O50', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('12', 'O50', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('13', 'O50', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('14', 'O50', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('15', 'O50', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('16', 'O50', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('17', 'O60', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('18', 'O60', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('19', 'O60', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('20', 'O60', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('21', 'O60', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('22', 'O60', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('23', 'O60', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('24', 'O60', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('25', 'O70', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('26', 'O70', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('27', 'O70', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('28', 'O70', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('29', 'O70', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('30', 'O70', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('31', 'O70', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('32', 'O70', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('33', 'U21', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('34', 'U21', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('35', 'U21', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('36', 'U21', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('37', 'U21', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('38', 'U21', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('39', 'U21', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('40', 'U21', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('41', 'U18', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('42', 'U18', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('43', 'U18', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('44', 'U18', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('45', 'U18', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('46', 'U18', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('47', 'U18', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('48', 'U18', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('49', 'U16', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('50', 'U16', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('51', 'U16', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('52', 'U16', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('53', 'U16', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('54', 'U16', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('55', 'U16', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('56', 'U16', 'F', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('57', 'U14', 'M', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('58', 'U14', 'M', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('59', 'U14', 'M', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('60', 'U14', 'M', 'L');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('61', 'U14', 'F', 'R');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('62', 'U14', 'F', 'C');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('63', 'U14', 'F', 'B');
INSERT INTO Categories (category_id, age_group, gender, equipment_id) VALUES ('64', 'U14', 'F', 'L');

INSERT INTO Events (event_name, base_round_id, championship_id) VALUES ('Glenferrie Archery Tournament', '1', '9');

INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '1', '1');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '2', '1');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '3', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '4', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '5', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '6', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '7', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '8', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '9', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '10', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '11', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '12', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '13', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '14', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '15', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '16', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '17', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '18', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '19', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '20', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '21', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '22', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '23', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '24', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '25', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '26', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '27', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '28', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '29', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '30', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '31', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '32', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '33', '1');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '34', '1');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '35', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '36', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '37', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '38', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '39', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '40', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '41', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '42', '2');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '43', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '44', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '45', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '46', '3');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '47', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '48', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '49', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '50', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '51', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '52', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '53', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '54', '4');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '55', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '56', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '57', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '58', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '59', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '60', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '61', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '62', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '63', '5');
INSERT INTO Competitions (event_id, category_id, round_def_id) VALUES ('1', '64', '5');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('1', '1', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('2', '1', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('3', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('4', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('5', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('6', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('7', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('8', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('9', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('10', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('11', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('12', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('13', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('14', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('15', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('16', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('17', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('18', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('19', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('20', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('21', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('22', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('23', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('24', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('25', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('26', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('27', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('28', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('29', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('30', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('31', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('32', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('33', '1', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('34', '1', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('35', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('36', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('37', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('38', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('39', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('40', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('41', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('42', '2', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('43', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('44', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('45', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('46', '3', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('47', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('48', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('49', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('50', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('51', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('52', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('53', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('54', '4', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('55', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('56', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('57', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('58', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('59', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('60', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('61', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('62', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('63', '5', '2017-01-01', NULL, '1');
INSERT INTO EquivalentRounds (equivalent_category_id, equivalent_round_def_id, date_from,date_to, base_round_def_id) VALUES ('64', '5', '2017-01-01', NULL, '1');;

INSERT INTO CompetitionEnrolments (archer_id, competition_id) VALUES ('1', '1');


INSERT INTO RoundScoresStaging (archer_id, competition_id, round_score_date_time, equipment_id, round_def_id, total_score, category_id) VALUES ('1', '1', '2020-07-23 00:00:00.000', 'R', '1', '720', '1');



INSERT INTO RangeScoresStaging (round_score_id, round_range_id) VALUES ('1', '1');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) VALUES ('1', '2');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) VALUES ('1', '3');
INSERT INTO RangeScoresStaging (round_score_id, round_range_id) VALUES ('1', '4');



INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('1', '1', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('1', '2', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('1', '3', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('1', '4', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('1', '5', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('1', '6', '9','9','5', '5', '1', '1');

INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('2', '1', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('2', '2', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('2', '3', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('2', '4', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('2', '5', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('2', '6', '9','9','5', '5', '1', '1');

INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('3', '1', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('3', '2', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('3', '3', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('3', '4', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('3', '5', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('3', '6', '9','9','5', '5', '1', '1');

INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('4', '1', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('4', '2', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('4', '3', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('4', '4', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('4', '5', '9','9','5', '5', '1', '1');
INSERT INTO EndScoresStaging (range_score_id, end_number, score_arrow1, score_arrow2, score_arrow3, score_arrow4, score_arrow5, score_arrow6) VALUES ('4', '6', '9','9','5', '5', '1', '1');