<?php

header("Content-Type: application/vnd.ms-excel; charset=utf-8");
header("Content-Disposition: attachment; filename=quest-report.xls");
header("Expires: 0");
header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
header("Cache-Control: private",false);

$d1 = $_GET['d1'];
$d2 = $_GET['d2'];


  $servername = "localhost";
  $username = "root";
  $password = "mysql";
  $dbname = "QuizReports";
        
  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
	if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
	}

  $sql = "SELECT q.q_id, q.quiz_code, q.q_text, avg(q.award_points) as avg_prc FROM `quiz_details` q " .
         " WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' group by q.q_id order by q.quiz_code, q.q_id";
  $result = $conn->query($sql);
  //loop the query data to the table in same order as the headers
  if ($result->num_rows > 0) {
    echo "<table class='qr-detail-table rep-table'><thead><tr><th>№</th><th>Quiz-код(курс)</th><th>Текст вопроса</th><th>Средний балл(%)</th>".
        "</tr></thead><tbody class='rep-body'>";
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        echo "<tr><td>$idx</td><td>" . $row["quiz_code"]. "</td><td>" . $row["q_text"]. "</td><td>" .  $row["avg_prc"]. "</td></tr>";
        $idx += 1;
      }
      echo "</tbody></table>";
    } else {
    echo "0 results";
  }

  $conn->close();
?>