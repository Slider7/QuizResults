<?php
  $d1 = $_GET['d1'];
  $d2 = $_GET['d2'];
  $teacher = $_GET['teacher'];
  if ($teacher == 'all') $teacher = '%%';

	error_reporting(E_ALL);

	$err_msq = 'OK';
	$db = parse_ini_file('../../../conf/connect.ini');
	// Create connection
	$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	};

  $sql = "SELECT * FROM all_quiz_res WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' AND teacher like '$teacher' " . 
         " ORDER BY teacher, quiz_code, gruppa, stud_name";
  //echo $sql;
  $result = $conn->query($sql);
  $idx = 1;
  if ($result->num_rows > 0) {
      echo "<table id='qr-table'><thead><tr><th>№</th><th>ФИО курсанта</th><th>Преподаватель</th><th>Программа</th>".
          "<th>Уровень</th><th>Группа</th><th>Unit</th><th>Оценка(%)</th><th>Дата</th><th colspan='2'>Затраченное время</th></tr></thead><tbody id='qr-body'>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          $parts = explode('_', $row["quiz_code"]);
          $program = substr($parts[0], 0, 2);
          $level = substr($parts[0], 2);
          $unit = $parts[1];
          echo "<tr><td>$idx</td><td>" . $row["stud_name"] . "</td><td>" . $row["teacher"] . "</td><td> $program </td><td> $level </td><td>" . 
          $row["gruppa"] . "</td><td> $unit </td><td>" . $row["stud_percent"] . "</td><td>" .
          $row["finished_at"] . "</td><td>" . $row["quiz_time"] . "</td><td class='none'>" . $row["qr_id"] . "</td></tr>";
          $idx += 1;
        }
          echo "</tbody></table>";
        } else {
        echo "0 results";
      }

	$conn->close();
?>