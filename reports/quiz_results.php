<?php
  $d1 = $_GET['d1'];
  $d2 = $_GET['d2'];

	error_reporting(E_ALL);

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

  $sql = "SELECT * FROM all_quiz_res WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' ORDER BY quiz_code, teacher, fio";
  //echo $sql;
	$result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table id='qr-table'><thead><tr><th>№</th><th>Quiz-код</th><th>Преподаватель</th><th>ФИО студента</th><th>Код студента</th>".
          "<th>Баллы</th><th>Проходной балл</th><th>Оценка %</th><th>Дата</th><th colspan='2'>Затраченное время</th></tr></thead><tbody id='qr-body'>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          echo "<tr><td>$idx</td><td>" . $row["quiz_code"]. "</td><td>" . $row["teacher"]. "</td><td>" . $row["fio"]. "</td><td>" .
          $row["stud_code"] . "</td><td>" . $row["user_score"] . "</td><td>" . $row["pass_score"] . "</td><td>" . $row["stud_percent"] . "</td><td>" .
          $row["finished_at"] . "</td><td>" . $row["quiz_time"] . "</td><td class='hidden'>" . $row["qr_id"] . "</td></tr>";
          $idx += 1;
        }
          echo "</tbody></table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>