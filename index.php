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

        if (isset($_POST["event_name"])) {
            $selectedEvent = ($_POST["event_name"]);
        } else {
            $selectedEvent = "*";
        }

        if (isset($_POST["equipment_name"])) {
            $selectedEquipment = ($_POST["equipment_name"]);
        } else {
            $selectedEquipment = "*";
        }

        if (isset($_POST["archer_id"])) {
            $selectedArcherID = ($_POST["archer_id"]);
        } else {
            $selectedArcherID = "*";
        }

        if (isset($_POST["round_def_id"])) {
            $selectedRoundDefID = ($_POST["round_def_id"]);
        } else {
            $selectedRoundDefID = "*";
        }

        if (isset($_POST["archer_gender"])) {
            $selectedArcherGender = ($_POST["archer_gender"]);
        } else {
            $selectedArcherGender = "*";
        }

        if (isset($_POST["age_group"])) {
            $selectedAgeGroup = ($_POST["age_group"]);
        } else {
            $selectedAgeGroup = "*";
        }

        if (isset($_POST["championship_id"])) {
            $selectedChampionshipID = ($_POST["championship_id"]);
        } else {
            $selectedChampionshipID = "*";
        }

        if (isset($_POST["sort_by"])) {
            $selectedOrderBy = ($_POST["sort_by"]);
        } else {
            $selectedOrderBy = "round_score_date_time DESC";
        }

        if (isset($_POST["start_date"])) {
            $selectedStartDate = ($_POST["start_date"]);
        } else {
            $selectedStartDate = "";
        }

        if (isset($_POST["end_date"])) {
            $selectedEndDate = ($_POST["end_date"]);
        } else {
            $selectedEndDate = "";
        }

        $query = "SELECT  DISTINCT event_name FROM  Events";
        $events =  mysqli_query($conn, $query);

        $query = "SELECT equipment_name FROM  Equipment";
        $equipment =  mysqli_query($conn, $query);

        $query = "SELECT archer_id, archer_firstname, archer_lastname, archer_gender, archer_birthyear 
                FROM  Archers ORDER BY archer_firstname, archer_lastname, archer_gender, archer_birthyear";
        $archers =  mysqli_query($conn, $query);

        $query = "SELECT round_def_id, round_name FROM RoundDefinitions";
        $round_definitions =  mysqli_query($conn, $query);

        $query = "SELECT DISTINCT archer_gender FROM Archers";
        $archer_genders =  mysqli_query($conn, $query);

        $query = "SELECT DISTINCT age_group FROM Categories";
        $age_groups =  mysqli_query($conn, $query);

        $query = "SELECT championship_id, championship_name FROM Championships";
        $championships =  mysqli_query($conn, $query);



        $whereclause = "";
        if ($selectedEvent != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE Events.event_name='$selectedEvent' ";
            else
                $whereclause .= " AND Events.event_name='$selectedEvent' ";
        }
        if ($selectedEquipment != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE Equipment.equipment_name='$selectedEquipment' ";
            else
                $whereclause .= " AND Equipment.equipment_name='$selectedEquipment' ";
        }
        if ($selectedArcherID != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE Archers.archer_id='$selectedArcherID' ";
            else
                $whereclause .= " AND Archers.archer_id='$selectedArcherID' ";
        }
        if ($selectedRoundDefID != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE RoundScores.round_def_id='$selectedRoundDefID' ";
            else
                $whereclause .= " AND RoundScores.round_def_id='$selectedRoundDefID' ";
        }
        if ($selectedArcherGender != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE Archers.archer_gender='$selectedArcherGender' ";
            else
                $whereclause .= " AND Archers.archer_gender='$selectedArcherGender' ";
        }
        if ($selectedAgeGroup != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE Categories.age_group='$selectedAgeGroup' ";
            else
                $whereclause .= " AND Categories.age_group='$selectedAgeGroup' ";
        }
        if ($selectedChampionshipID != "*") {
            if ($whereclause == "")
                $whereclause .= " WHERE Championships.championship_id='$selectedChampionshipID' ";
            else
                $whereclause .= " AND Championships.championship_id='$selectedChampionshipID' ";
        }
        if ($selectedStartDate != "") {
            if ($whereclause == "")
                $whereclause .= " WHERE round_score_date_time >= '$selectedStartDate' ";
            else
                $whereclause .= " AND round_score_date_time >= '$selectedStartDate' ";
        }
        if ($selectedEndDate != "") {
            if ($whereclause == "")
                $whereclause .= " WHERE round_score_date_time < '$selectedEndDate' ";
            else
                $whereclause .= " AND round_score_date_time < '$selectedEndDate' ";
        }


        $query = "SELECT round_score_id, round_score_date_time AS ScoreDateTime, Archers.archer_firstname AS FirstName, 
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
            JOIN Championships ON Events.championship_id=Championships.championship_id $whereclause";

        $query .= " ORDER BY $selectedOrderBy LIMIT 15";

        $scores =  mysqli_query($conn, $query);
    }
    ?>
    <div class="container-sm">
        <h3 style="text-align: center">View Scores</h3>
        <!-- <form method="POST" action="https://mercury.swin.edu.au/it000000/formtest.php" novalidate="novalidate"> -->
        <form method="POST" action="index.php" novalidate="novalidate">
            <div class="row">
                <div class="col-3">
                    <label>Select Event: </label>
                    <select class="form-select" name="event_name">
                        <option value="*">*</option>
                        <?php
                        while ($event_names = mysqli_fetch_array($events, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $event_names["event_name"], "\" ";
                            if ($event_names["event_name"] == $selectedEvent)
                                echo "selected";
                            echo ">", $event_names["event_name"], "</option>\n";
                        }
                        ?>
                    </select>
                    <label>Select Equipment: </label>
                    <select class="form-select" name="equipment_name">
                        <option value="*">*</option>
                        <?php
                        while ($equipment_names = mysqli_fetch_array($equipment, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $equipment_names["equipment_name"], "\" ";
                            if ($equipment_names["equipment_name"] == $selectedEquipment)
                                echo "selected";
                            echo ">", $equipment_names["equipment_name"], "</option>\n";
                        }
                        ?>
                    </select>
                    <label>Select Archer: </label>
                    <select class="form-select" name="archer_id">
                        <option value="*">*</option>
                        <?php
                        while ($archer = mysqli_fetch_array($archers, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $archer["archer_id"], "\" ";
                            if ($archer["archer_id"] == $selectedArcherID)
                                echo "selected";
                            echo ">", $archer["archer_firstname"], " ", $archer["archer_lastname"], " (",
                            $archer["archer_gender"], ", ", $archer["archer_birthyear"], ")",  "</option>\n";
                        }
                        ?>
                    </select>
                </div>
                <div class="col-3">
                    <label>Select Archer Gender: </label>
                    <select class="form-select" name="archer_gender">
                        <option value="*">*</option>
                        <?php
                        while ($archer_gender = mysqli_fetch_array($archer_genders, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $archer_gender["archer_gender"], "\" ";
                            if ($archer_gender["archer_gender"] == $selectedArcherGender)
                                echo "selected";
                            echo ">", $archer_gender["archer_gender"], "</option>\n";
                        }
                        ?>
                    </select>
                    <label>Select Age Group: </label>
                    <select class="form-select" name="age_group">
                        <option value="*">*</option>
                        <?php
                        while ($age_group = mysqli_fetch_array($age_groups, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $age_group["age_group"], "\" ";
                            if ($age_group["age_group"] == $selectedAgeGroup)
                                echo "selected";
                            echo ">", $age_group["age_group"], "</option>\n";
                        }
                        ?>
                    </select>
                    <label>Select Championship: </label>
                    <select class="form-select" name="championship_id">
                        <option value="*">*</option>
                        <option value="NULL">None</option>
                        <?php
                        while ($championship = mysqli_fetch_array($championships, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $championship["championship_id"], "\" ";
                            if ($championship["championship_id"] == $selectedChampionshipID)
                                echo "selected";
                            echo ">", $championship["championship_name"], "</option>\n";
                        }
                        ?>
                    </select>
                </div>
                <div class="col-3">
                    <label>Select Round Name: </label>
                    <select class="form-select" name="round_def_id">
                        <option value="*">*</option>
                        <?php
                        while ($round_definition = mysqli_fetch_array($round_definitions, MYSQLI_ASSOC)) {
                            echo "<option value=\"", $round_definition["round_def_id"], "\" ";
                            if ($round_definition["round_def_id"] == $selectedRoundDefID)
                                echo "selected";
                            echo ">", $round_definition["round_name"], "</option>\n";
                        }
                        ?>
                    </select>
                    <label>Sort By: </label>
                    <select class="form-select" name="sort_by">
                        <?php
                        switch ($selectedOrderBy) {
                            case "round_score_date_time DESC":
                                echo "<option value=\"round_score_date_time DESC\" selected>Date/Time (Newest First)</option>
                        <option value=\"round_score_date_time ASC\">Date/Time (Oldest First)</option>
                        <option value=\"total_score DESC\">Score (Highest First)</option>
                        <option value=\"total_score ASC\">Score (Lowest First)</option>\"";
                                break;
                            case "round_score_date_time ASC":
                                echo "<option value=\"round_score_date_time DESC\" >Date/Time (Newest First)</option>
                        <option value=\"round_score_date_time ASC\" selected>Date/Time (Oldest First)</option>
                        <option value=\"total_score DESC\">Score (Highest First)</option>
                        <option value=\"total_score ASC\">Score (Lowest First)</option>\"";
                                break;
                            case "total_score DESC":
                                echo "<option value=\"round_score_date_time DESC\" >Date/Time (Newest First)</option>
                        <option value=\"round_score_date_time ASC\">Date/Time (Oldest First)</option>
                        <option value=\"total_score DESC\" selected>Score (Highest First)</option>
                        <option value=\"total_score ASC\">Score (Lowest First)</option>\"";
                                break;
                            case "total_score ASC":
                                echo "<option value=\"round_score_date_time DESC\" >Date/Time (Newest First)</option>
                        <option value=\"round_score_date_time ASC\">Date/Time (Oldest First)</option>
                        <option value=\"total_score DESC\">Score (Highest First)</option>
                        <option value=\"total_score ASC\" selected>Score (Lowest First)</option>\"";
                                break;
                        }
                        ?>
                    </select>
                </div>
                <div class="col-3">
                    <div class="row">
                        <label for="start_date">Start Date:</label>
                        <input type="date" id="start_date" name="start_date" value=<?php echo $selectedStartDate; ?>>
                        <label for="end_date">End Date:</label>
                        <input type="date" id="end_date" name="end_date" value=<?php echo $selectedEndDate; ?>>
                        <br>
                    </div>
                </div>
            
    </div>
    <br>
    <button type="submit" class="btn btn-primary">Submit</button>
    </form>

    <hr>
    <div class="row">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
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
                    ?>
                </tbody>
            </table>
        </div>
    </div>


    </div>
</body>

</html>