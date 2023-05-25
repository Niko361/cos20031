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
        $query = //"SELECT `competition_id`, `event_name` FROM Events WHERE `event_id` IN
            //(SELECT `event_id` FROM Competitions WHERE `competition_id` IN
            //(SELECT `competition_id` FROM `CompetitionEnrolments` WHERE `archer_id` = '1')) "; //need login id global variable
            "SELECT Events.event_name, Competitions.competition_id FROM Competitions JOIN Events ON Competitions.event_id = Events.event_id WHERE `competition_id` IN
      (SELECT `competition_id` FROM `CompetitionEnrolments` WHERE `archer_id` = '1')";
        $enrolments =  mysqli_query($conn, $query);
    }
    ?>
    <div class="centred">
        <h1 style="text-align: center">Lookup Score</h1>
        <form method="POST" action="ScoreSheet.php" novalidate="novalidate">
            <label>Select Competition: </label>
            <select name="Competition">
                <?php

                while ($competition = mysqli_fetch_array(
                    $enrolments,
                    MYSQLI_ASSOC
                )) :;
                ?>
                    <option value="<?php echo $competition["competition_id"]; ?>">
                        <?php echo $competition["event_name"]; ?>
                    </option>
                <?php
                endwhile;

                ?>
            </select>
            <br>
            <input type="submit" value="NEXT" name="submit" style="margin-top: 10px">
        </form>
    </div>
</body>

</html>