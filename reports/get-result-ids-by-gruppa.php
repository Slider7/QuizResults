<?php
  $quiz_code = $_GET['quiz_code'];
  $teacher = $_GET['teacher'];
  $gruppa = $_GET['gruppa'];
  $d1 = $_GET['d1'];
  $d2 = $_GET['d2'];

  $err_msq = 'OK';
  $servername = "localhost";
  $username = "root";
  $password = "mysql";
  $dbname = "QuizReports";
  $ids = [];      
  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
	if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
	}
  
  if (isset($d1) && isset($d2)){
    $sql = "SELECT qr_id, stud_name, stud_percent FROM `quiz_results` WHERE teacher like '$teacher' AND CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' " . 
           " AND quiz_id = (select DISTINCT quiz_id from quiz where quiz_code = '$quiz_code') and gruppa = $gruppa order by stud_name";
  } else {
    $sql = "SELECT qr_id, stud_name, stud_percent FROM `quiz_results` WHERE teacher like '$teacher' " . 
           " AND quiz_id = (select DISTINCT quiz_id from quiz where quiz_code = '$quiz_code') and gruppa = $gruppa order by stud_name";
  };
	$result = $conn->query($sql);
  if ($result->num_rows > 0) {
      while($row = $result->fetch_assoc()) {
        array_push($ids, [$row['qr_id'], $row['stud_name'], $row['stud_percent']]);
      };
  } else {
    array_push($ids, [-1, '']);
  }
  echo(json_encode($ids));
	$conn->close();
?>