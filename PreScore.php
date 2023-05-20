<!DOCTYPE html>
  <html lang = "en">
  <head>
    <meta charset="utf-8" />
    <meta name="description" content="PreScore" />
    <meta name="keywords" 	 content="HTML, CSS" />
    <meta name="author"		 content="Halim" />
    <link rel = "stylesheet" href ="styles/style.css">
    <title> Pre Score </title>
  </head>
  <body>
 	  <?php include 'includes/header.inc'; ?>
	  <?php
	  	session_start();
	  	
	    	require_once "settings.php";
	     	$conn = @mysqli_connect($host,$user,$pwd,$sql_db);
		if (!$conn) {
			// Displays an error message
			echo "<p>Database connection failure</p>";
    } 
    else {
			$query = "SELECT `event_name` FROM Events WHERE `event_id` IN
        (SELECT `event_id` FROM Competitions WHERE `competition_id` IN
				(SELECT `competition_id` FROM `CompetitionEnrolments` WHERE `archer_id` = '$archer_id')) "; //need login id global variable
			$enrolments =  mysqli_query($conn, $query);
		}	
	  ?>
		
	  <form method="POST" action="ScoreSheet.php"  novalidate="novalidate">
        <label>Select Competition</label>
        <select name="Competition">
            <?php
                while ($competition = mysqli_fetch_array(
                        $enrolments,MYSQLI_ASSOC)):;
            ?>
                <option value="<?php echo $competition["competition_id"]; ?>">
                    <?php echo $competition["competition_name"]; ?>
                </option>
            <?php
                endwhile;
            ?>
        </select>
        <br>
        <input type="submit" value="submit" name="submit">
    </form>
  </body>
</html>
