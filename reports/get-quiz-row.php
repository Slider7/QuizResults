<?php
  $qr_id = $_GET['qr_id'];
  $is_header = $_GET['is_header'];

  $err_msq = 'OK';
	$db = parse_ini_file('../../../conf/connect.ini');
	// Create connection
	$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	};

  $sql = "SELECT SUBSTRING(q_text, 1, 3) as qtext,  concat(award_points, '/', maxpoint) as points, result FROM quiz_detail2 WHERE qr_id = '$qr_id' order by q_text";
  //echo $sql;
	$result = $conn->query($sql);
  if ($result->num_rows > 0) {
      $tablerow = '';
      $isOk = 'ok ans';
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        if ($row["result"] == 0){
          $isOk = 'err ans';
        } else { $isOk = 'ok ans'; };
        if (isset($is_header) && $is_header == 1) {
          $tablerow .= "<th class='matrix-th'>&nbsp&nbsp&nbsp$idx&nbsp&nbsp&nbsp</th>";
        } else {
          $tablerow .= "<td class='$isOk'>" . $row["points"] . "</td>";
        }
        $idx++;
      }
      echo $tablerow;
  } else {
    echo "0 results";
  }

	$conn->close();
?>