<?php
$d1 = $_GET['d1'];
$d2 = $_GET['d2'];

header("Content-Type: application/xls");
header("Content-Disposition: attachment; filename=filename.xls");  
header("Pragma: no-cache"); 
header("Expires: 0");

  $servername = "localhost";
  $username = "root";
  $password = "mysql";
  $dbname = "QuizReports";
        
  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
	if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
	}

  $sql = "SELECT teacher, quiz_code, cast(avg(stud_percent) as decimal(6, 3)) as avg_prc FROM all_quiz_res " . 
         " WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' group by teacher";
  $result = $conn->query($sql);
  //loop the query data to the table in same order as the headers
  if ($result->num_rows > 0) {
    echo "<table class='qr-detail-table rep-table'><thead><tr><th>№</th><th>Преподаватель</th><th>Quiz-код</th><th>Средний балл(%)</th>".
        "</tr></thead><tbody class='rep-body'>";
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        echo "<tr><td>$idx</td><td>" . $row["teacher"]. "</td><td>" . $row["quiz_code"]. "</td><td>" .  $row["avg_prc"]. "</td></tr>";
        $idx += 1;
      }
      echo "</tbody></table>";
    } else {
    echo "0 results";
  }
?>