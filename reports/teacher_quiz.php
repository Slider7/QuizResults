<?php
  $teacher = $_GET['teacher'];
  $d1 = $_GET['d1'];
  $d2 = $_GET['d2'];

	error_reporting(E_ALL);

	$err_msq = 'OK';
	$db = parse_ini_file('../../../conf/connect.ini');
	// Create connection
	$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	};
  if ($teacher == 'all') {
    $teacher = '%%';
  };
  if (isset($d1) && isset($d2)){
    $sql = "SELECT teacher, quiz_code, gruppa, count(*) as qr_cnt, FORMAT(avg(stud_percent), 2) as avg_prc FROM all_quiz_res " . 
         " WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2'  AND teacher like '$teacher' group by teacher, quiz_code, gruppa order by teacher, quiz_code";
  } else {
    $sql = "SELECT teacher, quiz_code, gruppa, count(*) as qr_cnt, FORMAT(avg(stud_percent), 2) as avg_prc FROM all_quiz_res " . 
         " WHERE teacher like '$teacher' group by teacher, quiz_code, gruppa order by teacher, quiz_code";
  };
  //echo $sql;
  $result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table id='teach-quiz-table'><thead><tr><th>№</th><th> Преподаватель </th><th>Program</th><th>Level</th><th>Unit</th>" .
           "<th>Группа</th><th>Кол-во <br> тестов</th><th>Прогресс(сред.%)</th></tr></thead><tbody id='qr-body'>";
      /*группа - програм - юнит*/
      while($row = $result->fetch_assoc()) {
        $parts = explode('_', $row["quiz_code"]);
        $program = substr($parts[0], 0, 2);
        $level = substr($parts[0], 2);
        $unit = $parts[1];
        echo "<tr><td>$idx</td><td>" . $row["teacher"] . "</td><td> $program </td><td> $level </td><td> $unit </td><td>" . $row["gruppa"] . "</td><td>" . $row["qr_cnt"] . "</td><td>" . $row["avg_prc"] . "</td></tr>";
        $idx += 1;
      }
        echo "</tbody></table>";
      } else {
        echo "0 results";
      }

	$conn->close();
?>