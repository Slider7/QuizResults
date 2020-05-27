<?php
  $q_name = $_POST['q-name'];
  $q_program = $_POST['q-program'];
  $q_unit = $_POST['q-unit'];
  $q_code = $_POST['q-code'];

  $err_msq = 'OK';

        $err_msq = '';
        $db = parse_ini_file('../../../conf/connect.ini');
		// Create connection
		$conn = new mysqli($db['host'], $db['user'], $db['pass'], $db['name']);
		if ($conn->connect_error) {
			die("Connection failed: " . $conn->connect_error);
		};

  $sql = "INSERT INTO Quiz(`quiz_id`, `quiz_name`, `quiz_code`, `Program`, `Unit`) VALUES (NULL, '$q_name', '$q_code', '$q_program', '$q_unit');";
  if ($conn->query($sql) === TRUE) {
    echo "<p>Quiz с кодом $q_code успешно добавлен.</p>";
  } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
  };
	$conn->close();
?>