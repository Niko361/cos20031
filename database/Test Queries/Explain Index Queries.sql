EXPLAIN SELECT * FROM RoundScores WHERE archer_id = '100';

EXPLAIN SELECT * FROM RoundScores WHERE competition_id = '10';

EXPLAIN SELECT * FROM RoundScores WHERE category_id = '10';

EXPLAIN SELECT * FROM RoundScores 
    WHERE round_score_date_time > '2023-04-23 08:00:00'
    AND round_score_date_time < '2023-04-23 12:00:00';

EXPLAIN SELECT * FROM RoundScores ORDER BY `total_score` DESC;


EXPLAIN SELECT * FROM Competitions WHERE category_id = '10';

EXPLAIN SELECT * FROM RangeScores WHERE round_score_id = '100';

EXPLAIN SELECT * FROM EndScores WHERE range_score_id = '400';

EXPLAIN SELECT * FROM RangeScoresStaging WHERE round_score_id = '100';

EXPLAIN SELECT * FROM EndScoresStaging WHERE range_score_id = '400';