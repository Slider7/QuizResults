<?php
  $teacher = $_GET['teacher'];
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

  if (isset($d1) && isset($d2)){
    $sql = "SELECT quiz_name, quiz_code, count(*) as qr_cnt FROM all_quiz_res " . 
    "WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' AND teacher like '$teacher' group by teacher order by quiz_code";
  } else {
    $sql = "SELECT quiz_name, quiz_code, count(*) as qr_cnt FROM all_quiz_res " . 
    "WHERE teacher like '$teacher' group by teacher order by quiz_code";
  };
  //echo $sql;
  $result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table id='teach-quiz-table'><thead><tr><th>№</th><th>Название quiz-а</th><th>Код quiz-а</th><th>Количество тестирований</th></tr></thead><tbody id='qr-body'>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          echo "<tr><td>$idx</td><td>" . $row["quiz_name"] . "</td><td>" . $row["quiz_code"]. "</td><td>" . $row["qr_cnt"]. "</td></tr>";
          $idx += 1;
        }
          echo "</tbody></table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>