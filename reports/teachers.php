<?php
  $err_msq = 'OK';
  $db = parse_ini_file('../../../conf/connect.ini');
  // Create connection
  $conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
  if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error . $db['host']);
  };

  $sql = "select DISTINCT teacher from quiz_results order by teacher";
  $result = $conn->query($sql);
  $teachers = [];
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      array_push($teachers, $row['teacher']);
    }
    echo json_encode($teachers);
  } else {
    echo "0 results";
  }

	$conn->close();
?>