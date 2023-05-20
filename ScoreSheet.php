<!DOCTYPE html>
  <html lang = "en">
  <head>
    <meta charset="utf-8" />
    <meta name="description" content="ScoreSheet" />
    <meta name="keywords" 	 content="HTML, CSS", "JS" />
    <meta name="author"		 content="Halim" />
    <meta name="script source"		 content="http://jsfiddle.net/ZRQPP/" />  
    <link rel = "stylesheet" href ="styles/style.css">
    <title> Score Sheet </title>
  </head>
    <style>
              .table
        {
          display:table;
          border-collapse:separate;
          border-spacing:2px;
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
        .tr.editing .td INPUT
        {
          width:100px;
        }
    </style>
    <script>
                function edit(element){
          var tr = jQuery(element).parent().parent();
          if(!tr.hasClass("editing")) {
            tr.addClass("editing");
            tr.find("DIV.td").each(function(){
              if(!jQuery(this).hasClass("action")){
                var value = jQuery(this).text();
                jQuery(this).text("");
                jQuery(this).append('<input type="text" value="'+value+'" />');
              } else {
                jQuery(this).find("BUTTON").text("save");
              }
            });
          } else {
            tr.removeClass("editing");
            tr.find("DIV.td").each(function(){
              if(!jQuery(this).hasClass("action")){
                var value = jQuery(this).find("INPUT").val();
                jQuery(this).text(value);
                jQuery(this).find("INPUT").remove();
              } else {
                jQuery(this).find("BUTTON").text("edit");
              }
            });
          }
        }
      </script>
  <body>
 	  <?php include 'includes/header.inc'; ?>
    if (isset($_POST["Competition"])){
        $competition = ($_POST["Competition"]);
        $_SESSION["competition"] = $competition;
    }
    	 require_once "settings.php";
	     $conn = @mysqli_connect($host,$user,$pwd,$sql_db);
        // find out how many ranges in competition's round
         $query = "SELECT COUNT(*) FROM RoundRange WHERE `round_def_id` IN
				(SELECT `round_def_id` FROM `Competition` WHERE `competition_id` = '$competition') ";
          $RangeCount = mysqli_query($conn, $query);
    
    // find out competition's round
       $query = "SELECT `round_def_id` FROM `Competition` WHERE `competition_id` = '$competition'";
    $Round = mysqli_query($conn, $query);
    <?php
    for($RangeNum=0; $RangeNum<=$RangeCount; $RangeNum++)
    {
    $query = "SELECT `target_distance` FROM `RoundRange` WHERE `range_number` = $RangeNum AND `round_def_id` = '$Round'";
    $RangeDistance = mysqli_query($conn, $query);
      echo " 
      <h2> Range '$RangeNum', '$RangeDistance' Metres</h2>
      <div class="table">
        <div class="thead">
          <div class="tr">
            <div class="td">Arrow 1</div>
            <div class="td">Arrow 2</div>
            <div class="td">Arrow 3</div>
            <div class="td">Arrow 4</div>
            <div class="td">Arrow 5</div>
            <div class="td">Arrow 6</div>
            <div class="td"></div>
          </div>
        </div>
      ";
        $query = "SELECT `EndCount` FROM RoundRange WHERE `range_number` = $RangeNum AND `round_def_id` = '$Round'";
          $EndCount = mysqli_query($conn, $query);
          echo " 
            <div class="tbody">
          ";
          for($EndNum=0; $EndNum<=$EndCount; $EndNum++)
          {
              echo " <form class="tr"> 
                    <div class="th">End $EndNum</div>
                     <div class="td">Arrow 1</div>
                     <div class="td">Arrow 2</div>
                     <div class="td">Arrow 3</div>
                     <div class="td">Arrow 4</div>
                     <div class="td">Arrow 5</div>
                     <div class="td">Arrow 6</div>
                     <div class="td action"><button type="button" onclick="edit(this);">edit</button></div>
              ";
              
          }
         echo " 
                </div>
            </div>
          ";
    }
    ?>

  </body>
</html>
