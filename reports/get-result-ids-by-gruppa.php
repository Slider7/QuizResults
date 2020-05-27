<?php
  $quiz_code = $_GET['quiz_code'];
  $teacher = $_GET['teacher'];
  $gruppa = $_GET['gruppa'];
  $d1 = $_GET['d1'];
  $d2 = $_GET['d2'];

  $err_msq = 'OK';
  $ids = [];      
	$db = parse_ini_file('../../../conf/connect.ini');
	// Create connection
	$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	};
  if (isset($d1) && isset($d2)){
    $sql = "SELECT qr_id, stud_name, user_score, stud_percent, pass_score FROM `quiz_results` WHERE teacher like '$teacher' AND CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' " . 
           " AND quiz_id = (select DISTINCT quiz_id from Quiz where quiz_code = '$quiz_code') and gruppa = $gruppa order by stud_name";
  } else {
    $sql = "SELECT qr_id, stud_name, user_score, stud_percent, pass_score FROM `quiz_results` WHERE teacher like '$teacher' " . 
           " AND quiz_id = (select DISTINCT quiz_id from Quiz where quiz_code = '$quiz_code') and gruppa = $gruppa order by stud_name";
  };
	$result = $conn->query($sql);
  if ($result->num_rows > 0) {
      while($row = $result->fetch_assoc()) {
        array_push($ids, [$row['qr_id'], $row['stud_name'], $row['stud_percent'], $row['user_score'], $row['pass_score']]);
      };
  } else {
    array_push($ids, [-1, '']);
  }
  echo(json_encode($ids));
	$conn->close();
?>