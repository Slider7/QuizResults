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

  $sql = "SELECT teacher, quiz_code, gruppa, cast(avg(stud_percent) as decimal(6, 3)) as avg_prc FROM all_quiz_res " . 
         " WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' group by teacher, quiz_code, gruppa";
  $result = $conn->query($sql);
  //loop the query data to the table in same order as the headers
  if ($result->num_rows > 0) {
    echo "<h3>Средний балл по преподавателям, программам и группам:</h3>";
    echo "<table class='qr-detail-table rep-table'><thead><tr><th>№</th><th>Преподаватель</th><th>Группа</th><th>Program</th><th>Level</th><th>Unit</th><th>Средний балл(%)</th>".
        "</tr></thead><tbody class='rep-body'>";
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        $parts = explode('_', $row["quiz_code"]);
        $program = substr($parts[0], 0, 2);
        $level = substr($parts[0], 2);
        $unit = $parts[1];
        echo "<tr><td>$idx</td><td>" . $row["teacher"]. "</td><td>" . $row["gruppa"]. 
             "</td><td>$program</td><td>$level</td><td>$unit</td><td>" . $row["avg_prc"]. "</td></tr>";
        $idx += 1;
      }
      echo "</tbody></table>";
    } else {
    echo "0 results";
  }
?>