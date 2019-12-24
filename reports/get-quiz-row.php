<?php
  $qr_id = $_GET['qr_id'];
  $is_header = $_GET['is_header'];

  $err_msq = 'OK';
  $servername = "localhost";
  $username = "root";
  $password = "mysql";
  $dbname = "QuizReports";
        
  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
	if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
	}

  $sql = "SELECT SUBSTRING(q_text, 1, 3) as qtext, result FROM quiz_detail WHERE qr_id = '$qr_id' order by q_text";
  //echo $sql;
	$result = $conn->query($sql);
  if ($result->num_rows > 0) {
      $tablerow = '';
      $isOk = 'ok';
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        if ($row["result"] == 0){
          $isOk = 'err';
        } else { $isOk = 'ok'; };
        if (isset($is_header) && $is_header == 1) {
          $tablerow .= "<th class='matrix-th'>&nbsp&nbsp&nbsp $idx &nbsp&nbsp&nbsp</th>";
        } else {
          $tablerow .= "<td class='$isOk'>" . $row["result"] . "</td>";
        }
        $idx++;
      }
      echo $tablerow;
  } else {
    echo "0 results";
  }

	$conn->close();
?>