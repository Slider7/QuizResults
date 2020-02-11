<?php
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