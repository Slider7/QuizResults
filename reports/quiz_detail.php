<?php
  $qr_id = $_GET['qr_id'];

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

  $sql = "SELECT * FROM `quiz_details` WHERE qr_id = '$qr_id'";
  //echo $sql;
	$result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table id='qr-detail-table'><tr><th>№</th><th>Quiz-код</th><th>ФИО студента</th><th>Код студента</th><th>Текст вопроса</th>".
          "<th>Ответ</th><th>Баллы за ответ</th></tr>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          echo "<tr class='detail-row'><td>$idx</td><td>" . $row["quiz_code"]. "</td><td>" . $row["fio"]. "</td><td>" . $row["stud_code"]. "</td><td class='qtext'>" .
          $row["q_text"] . "</td><td class='user-resp'>" . $row["user_resp"] . "</td><td class='award-p'>" . $row["award_points"] . "</td></tr>";
          $idx += 1;
        }
          echo "</table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>