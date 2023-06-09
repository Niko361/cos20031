<!DOCTYPE html>
  <html lang = "en">
  <head>
    <meta charset="utf-8" />
    <meta name="description" content="PreScore" />
    <meta name="keywords" 	 content="HTML, CSS" />
    <meta name="author"		 content="Jinjuta" />
    <title> Pre Review Score </title>
  </head>
  <body>
 	  <?php include 'includes/header.inc.php'; ?>
	  <?php
	  	session_start();
	  	
	    	require_once "settings.php";
	     	$conn = @mysqli_connect($host,$user,$pwd,$sql_db);
		if (!$conn) {
			// Displays an error message
			echo "<p>Database connection failure</p>";
    } 
    else {
	    $query = "SELECT Events.event_name, Competitions.competition_id FROM Competitions JOIN Events ON Competitions.event_id = Events.event_id WHERE `competition_id` IN (SELECT `competition_id` FROM `CompetitionEnrolments` WHERE `archer_id` = '1')";
        $enrolments =  mysqli_query($conn, $query);

        $query_archers = "SELECT archer_id, archer_firstname, archer_lastname FROM Archers WHERE archer_id IN 
        (SELECT archer_id FROM CompetitionEnrolments WHERE competition_id IN 
        (SELECT competition_id FROM Competitions))";
        $archers =  mysqli_query($conn, $query_archers);

		}	
	  ?>
		<div class="centred">
    <h1 style="text-align: center">Submit Score</h1>
	  <form method="POST" action="ReviewScoreSheet.php"  novalidate="novalidate">
        <label>Select Competition: </label>
        <select name="Competition">
            <?php
              
                while ($competition = mysqli_fetch_array(
                        $enrolments,MYSQLI_ASSOC)):;
            ?>
                <option value="<?php echo $competition["competition_id"]; ?>">
                    <?php echo $competition["event_name"]; ?>
                </option>
            <?php
                endwhile;
                
            ?>
        </select>

        <br>
        <br>

        <label>Select Archer: </label>
        <select name="Archer">
            <?php
                while ($archer = mysqli_fetch_array($archers, MYSQLI_ASSOC)):;
            ?>
                <option value="<?php echo $archer["archer_id"]; ?>">
                    <?php echo $archer["archer_firstname"]." ".$archer["archer_lastname"]; ?>
                </option>
            <?php
                endwhile;
            ?>
        </select>
        <br>
        <br>
        <input type="submit" value="SELECT" name="submit" style="margin-top: 10px">
    </form>
    </div>
  </body>
</html>
