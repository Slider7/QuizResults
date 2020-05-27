<?php
  $qr_id = $_GET['qr_id'];
  $fio = $_GET['fio'];
  $err_msq = 'OK';
	$db = parse_ini_file('../../../conf/connect.ini');
	// Create connection
	$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	};

  $sql = "SELECT * FROM `quiz_detail2` WHERE qr_id = '$qr_id' order by q_id";
  //echo $sql;
	$result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
    echo "<p class='rep-title'>Данные тестирования, студент $fio - вопросы и ответы: </p>";
      echo "<table class='resizable qr-detail-table'><thead><tr><th>№</th><th>Quiz-код</th><th>Текст вопроса</th>".
          "<th>Ответ</th><th>Набрано баллов</th><th>Пороговый балл</th></tr></thead>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          $resp_type = $row["award_points"] < $row["maxpoint"] ? 'bad' : 'good';
          echo "<tr class='detail-row'><td>$idx</td><td>" . $row["quiz_code"]. "</td><td class='qtext'>" .
          $row["q_text"] . "</td><td class='user-resp'>" . $row["user_resp"] . "</td>" . 
          "<td class='award-p $resp_type'>" . $row["award_points"] . "</td>" .
          "<td class='award-p'>" . $row["maxpoint"] . "</td></tr>";
          $idx += 1;
        }
          echo "</table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>