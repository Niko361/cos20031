<!DOCTYPE html>
  <html lang = "en">
  <head>
    <meta charset="utf-8" />
    <meta name="description" content="ScoreSheet" />
    <meta name="keywords" 	 content="HTML, CSS, JS" />
    <meta name="author"		 content="Halim" />
    <title> Score Sheet </title>
  </head>
    <style>
              .table
        {
          display:table;
          border-collapse:separate;
          border-spacing:2px;
          width: 500px;
        }
        .thead
        {
          display:table-header-group;
          color:white;
          font-weight:bold;
          background-color:grey;
        }
        .tbody
        {
          display:table-row-group;
        }
        .tr
        {
          display:table-row;
        }
        .td
        {
          display:table-cell;
          border:1px solid black;
          padding:1px;
        }
        .tr.editing .td input
        {
          width:100px;
        }
    </style>
  <body>

 	  <?php include 'includes/header.inc.php'; ?>
    <?php
    if (isset($_POST["Competition"])){
        $competition = ($_POST["Competition"]);
        $_SESSION["competition"] = $competition;
    }
    	 require_once "settings.php";
	     $conn = @mysqli_connect($host,$user,$pwd,$sql_db);
        // find out how many ranges in competition's round
         $query = "SELECT COUNT(*) FROM RoundRange WHERE `round_def_id` IN
				(SELECT `round_def_id` FROM `Competitions` WHERE `competition_id` = '$competition') ";
          $RangeCount = mysqli_fetch_array(mysqli_query($conn, $query))[0];
    
    // find out competition's round
       $query = "SELECT `round_def_id` FROM `Competitions` WHERE `competition_id` = '$competition'";
    $Round = mysqli_fetch_array(mysqli_query($conn, $query))['round_def_id'];
    ?>
    <div class="container-sm">
    <h1 style="text-align: center">Submit Score</h1>
    <?php
    for($RangeNum=1; $RangeNum<=$RangeCount; $RangeNum++)
    {
    $query = "SELECT `target_distance` FROM `RoundRange` WHERE `range_number` = '$RangeNum' AND `round_def_id` = '$Round'";
    $RangeDistance = mysqli_fetch_array(mysqli_query($conn, $query))['target_distance'];
      echo ' 
      <h2> Range ' . $RangeNum . ', ' . $RangeDistance . ' Metres</h2>
      <div class="table">
        <div class="thead">
          <div class="tr">
            <div class="td"></div>
            <div class="td">Arrow 1</div>
            <div class="td">Arrow 2</div>
            <div class="td">Arrow 3</div>
            <div class="td">Arrow 4</div>
            <div class="td">Arrow 5</div>
            <div class="td">Arrow 6</div>
          </div>
        </div>
      ';
        $query = "SELECT `end_count` FROM RoundRange WHERE `range_number` = $RangeNum AND `round_def_id` = '$Round'";
          $EndCount = mysqli_fetch_array(mysqli_query($conn, $query))['end_count'];
          echo ' 
            <div class="tbody">
          ';
          for($EndNum=1; $EndNum<=$EndCount; $EndNum++)
          {
              echo ' <form class="tr"> 
                    <div class="thead">End ' . $EndNum . '</div>
                     <div class="td"><input form="tr" type="text" name="' . $RangeNum .'_' . $EndNum . '_1" value="0" maxlength="2" size="2"/></div>
                     <div class="td"><input form="tr" type="text" name="' . $RangeNum .'_' . $EndNum . '_2" value="0" maxlength="2" size="2"/></div>
                     <div class="td"><input form="tr" type="text" name="' . $RangeNum .'_' . $EndNum . '_3" value="0" maxlength="2" size="2"/></div>
                     <div class="td"><input form="tr" type="text" name="' . $RangeNum .'_' . $EndNum . '_4" value="0" maxlength="2" size="2"/></div>
                     <div class="td"><input form="tr" type="text" name="' . $RangeNum .'_' . $EndNum . '_5" value="0" maxlength="2" size="2"/></div>
                     <div class="td"><input form="tr" type="text" name="' . $RangeNum .'_' . $EndNum . '_6" value="0" maxlength="2" size="2"/></div>
                     </form>';
              
          }
         echo " 
                </div>
            </div>
          ";
    }
    ?>
    </div>
  </body>
</html>
