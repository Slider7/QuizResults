<?php
  $quiz_code = $_GET['quiz_code'];
  $teacher = $_GET['teacher'];
  $d1 = $_GET['d1'];
  $d2 = $_GET['d2'];


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
  
  if (isset($d1) && isset($d2)){
    $sql = "SELECT * FROM `quiz_results` WHERE teacher like '$teacher' AND CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' " . 
    " AND quiz_id = (select DISTINCT quiz_id from quiz where quiz_code = '$quiz_code') order by qr_id";
  } else {
    $sql = "SELECT * FROM `quiz_results` WHERE teacher like '$teacher' " . 
           "AND quiz_id = (select DISTINCT quiz_id from quiz where quiz_code = '$quiz_code') order by qr_id";
  };
	$result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table class='resizable' id='qr-detail-table'><thead><tr><th>№</th><th>Преподаватель</th><th>ФИО студента</th><th>Набрано баллов</th>".
          "<th>Проходной балл</th><th>Результат-%</th><th>Длительность</th><th colspan='2'>Время завершения</th></tr></thead><tbody id='stud-list-body'>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          $resp_type = $row["user_score"] < $row["pass_score"] ? 'bad' : 'good';
          echo "<tr class='detail-row $resp_type'><td>$idx</td><td>" . $row["teacher"]. "</td><td>" . $row["stud_name"]. "</td><td>" .
          $row["user_score"] . "</td><td>" . $row["pass_score"] . "</td><td>" . $row["stud_percent"] . "</td>" .
          "<td>" . $row["quiz_time"] . "</td><td>" . $row["finished_at"] . "</td><td class='none'>" . $row["qr_id"] . "</td></tr>";
          $idx += 1;
        }
          echo "</tbody></table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>