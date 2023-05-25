<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="description" content="Index, Score Lookup" />
    <meta name="keywords" content="HTML, CSS" />
    <meta name="author" content="Alex Nikolov" />
    <title> Lookup Scores </title>
</head>

<body>
    <?php include 'includes/header.inc.php'; ?>
    <?php
    session_start();

    require_once "settings.php";
    $conn = @mysqli_connect($host, $user, $pwd, $sql_db);
    if (!$conn) {
        // Displays an error message
        echo "<p>Database connection failure</p>";
    } else {
        $query = "SELECT  DISTINCT event_name FROM  Events";
        $raw_events =  mysqli_query($conn, $query);

        $query = "SELECT round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
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
            LIMIT 15";
        $scores =  mysqli_query($conn, $query);
    }
    ?>
    <div class="container-sm">
        <h3 style="text-align: center">View Scores</h3>
        <form method="POST" action="ScoreSheet.php" novalidate="novalidate">
            <label>Select Competition: </label>
            <select name="Competition">
                <?php
                
                while ($event_names = mysqli_fetch_array(
                    $raw_events,
                    MYSQLI_ASSOC
                )) :;
                ?>
                    <option value="<?php echo $event_names["event_name"]; ?>">
                        <?php echo $event_names["event_name"]; ?>
                    </option>
                <?php
                endwhile;

                ?>
            </select>
            <br>
            <input type="submit" value="NEXT" name="submit" style="margin-top: 10px">
        </form>

        <hr>
		<div class="row">
			<div class="table-responsive">
                <table  class="table table-striped table-hover">
                    <tbody>
                        <tr>
                            <th>DateTime</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Birth Year</th>
                            <th>Gender</th>
                            <th>Age Group</th>
                            <th>Equipment</th>
                            <th>Round Name</th>
                            <th>Event</th>
                            <th>Championship</th>
                            <th>Total Score</th>
                        </tr>
                        <?php
                        while ($score_row = mysqli_fetch_assoc($scores)) {
                            echo "<tr>\n";
                            echo "<td>", $score_row["ScoreDateTime"], "</td>\n";
                            echo "<td>", $score_row["FirstName"], "</td>\n";
                            echo "<td>", $score_row["LastName"], "</td>\n";
                            echo "<td>", $score_row["BirthYear"], "</td>\n";
                            echo "<td>", $score_row["Gender"], "</td>\n";
                            echo "<td>", $score_row["AgeGroup"], "</td>\n";
                            echo "<td>", $score_row["Equipment"], "</td>\n";
                            echo "<td>", $score_row["RoundName"], "</td>\n";
                            echo "<td>", $score_row["EventName"], "</td>\n";
                            echo "<td>", $score_row["Championship"], "</td>\n";
                            echo "<td>", $score_row["TotalScore"], "</td>\n";
                            echo "</tr>\n";
                        }


                            /*	<tr v-for="m in msg">
                                    <td>{{ m.code }}</td>
                                    <td>{{ m.desc }}</td>
                                    <td>{{ m.cp }}</td>
                                    <td>{{ m.type }}</td>
                                </tr> */
                        ?>
                    </tbody>
                </table>	
		    </div> 
        </div>
        

    </div>
</body>
</html>