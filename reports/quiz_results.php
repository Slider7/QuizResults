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

  $sql = "SELECT * FROM all_quiz_results WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2'";
  //echo $sql;
	$result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table id='qr-table'><tr><th>№</th><th>Quiz-код</th><th>ФИО студента</th><th>Код студента</th><th>Преподаватель</th>".
          "<th>Оценка</th><th>Проходной балл</th><th>Дата</th><th colspan='2'>Затраченное время</th></tr>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          echo "<tr><td>$idx</td><td>" . $row["quiz_code"]. "</td><td>" . $row["fio"]. "</td><td>" . $row["stud_code"]. "</td><td>" .
          $row["teacher"] . "</td><td>" . $row["user_score"] . "</td><td>" . $row["pass_score"] . "</td><td>" . 
          $row["finished_at"] . "</td><td>" . $row["quiz_time"] . "</td><td class='hidden'>" . $row["qr_id"] . "</td></tr>";
          $idx += 1;
        }
          echo "</table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>