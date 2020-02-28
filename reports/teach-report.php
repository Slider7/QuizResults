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
         " WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' group by teacher, quiz_code, gruppa " . 
         "ORDER BY teacher, gruppa, quiz_code";
  $result = $conn->query($sql);
  //loop the query data to the table in same order as the headers
  if ($result->num_rows > 0) {
    echo "<h3>Средний балл по преподавателям, программам и группам:</h3>";
    echo "<table id='teacher-avg' class='qr-detail-table rep-table'><thead><tr><th>№</th><th>Преподаватель</th><th>Группа</th><th>Program</th><th>Level</th><th>Unit</th><th>Средний балл(%)</th>".
        "</tr></thead><tbody class='rep-body'>";
    // output data of each row
      $idx = 1; $teacher = ''; $teach_avg = 0; $gruppa = ''; $gr_avg = 0;
      $count = $result->num_rows;

      while($row = $result->fetch_assoc()) {
        if ($idx == 1) {
          $teacher = $row["teacher"];
          $teach_avg = 0;
          $gruppa = $row["gruppa"];
          $gr_avg = 0;
        };

        /*-------------------------среднее по группе----------------------------------------*/
        if ($row["gruppa"] != $gruppa){
          echo "<tr class='gruppa-avg'><td></td><td colspan='5'>" . $teacher . ', средний % по группе №' . "$gruppa</td><td>" . round($gr_avg / $g, 2) . "</td></tr>";  
          $gruppa = $row["gruppa"];
          $gr_avg = $row["avg_prc"];
          $g = 1;
        } else {
          $gr_avg += $row["avg_prc"];
          $g++;
        };

        /*-------------------------среднее по учителю----------------------------------------*/
        if ($row["teacher"] != $teacher){
          echo "<tr class='teach-avg'><td></td><td colspan='5'>" . $teacher . ', средний % по всем группам: ' . "</td><td>" . round($teach_avg / $k, 2) . "</td></tr>";  
          $teacher = $row["teacher"];
          $teach_avg = $row["avg_prc"];
          $k = 1;
        } else {
          $teach_avg += $row["avg_prc"];
          $k++;
        };
        /*------------------------------------строки из запроса------------------------------------------------*/
        $parts = explode('_', $row["quiz_code"]);
        $program = substr($parts[0], 0, strlen($parts[0]) - 1);
        $level = substr($parts[0], strlen($parts[0]) - 1);
        $unit = $parts[1];
        echo "<tr><td>$idx</td><td>" . $row["teacher"]. "</td><td>" . $row["gruppa"]. 
             "</td><td>$program</td><td>$level</td><td>$unit</td><td>" . $row["avg_prc"]. "</td></tr>";
        
        /*------------------среднее - последняя запись по учителю------------------------------------*/
        if ($count == $idx){
          echo "<tr class='gruppa-avg'><td></td><td colspan='5'>" . $teacher . ', средний % по группе №' . "$gruppa</td><td>" . round($gr_avg / $g, 2) . "</td></tr>";  
          echo "<tr class='teach-avg'><td></td><td colspan='5'>" . $teacher . ', средний % по всем группам: ' . "</td><td>" . round($teach_avg / $k, 2) . "</td></tr>";  
        };

        $idx += 1;
      }
      echo "</tbody></table>";
    } else {
    echo "0 results";
  }
?>