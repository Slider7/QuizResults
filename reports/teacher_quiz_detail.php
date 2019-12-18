<?php
  $quiz_code = $_GET['quiz_code'];
  $teacher = $_GET['teacher'];

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

  $sql = "SELECT * FROM `quiz_detail` WHERE quiz_code = '$quiz_code' and teacher like '$teacher' order by q_id";
  //echo $sql;
	$result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
    echo "<p>Данные тестирования - вопросы и ответы: </p>";
      echo "<table class='resizable qr-detail-table'><thead><tr><th>№</th><th>Quiz-код</th><th>ФИО студента</th><th>Текст вопроса</th>".
          "<th>Ответ</th><th>Баллы за ответ</th></tr></thead>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          $resp_type = $row["award_points"] == 0 ? 'bad' : 'good';
          echo "<tr class='detail-row'><td>$idx</td><td>" . $row["quiz_code"]. "</td><td>" . $row["fio"]. "</td><td class='qtext'>" .
          $row["q_text"] . "</td><td class='user-resp'>" . $row["user_resp"] . "</td>" . 
          "<td class='award-p $resp_type'>" . $row["award_points"] . "</td></tr>";
          $idx += 1;
        }
          echo "</table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>