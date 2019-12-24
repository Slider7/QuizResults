<?php

include_once("xlsxwriter.class.php");
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);

$rows = [];
$d1 = $_GET['d1'];
$d2 = $_GET['d2'];

$filename = "all-test-report-$d2.xlsx";

header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($filename).'"');
header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
header('Content-Transfer-Encoding: binary');
header('Cache-Control: must-revalidate');
header('Pragma: public');

$header = array('№', 'ФИО курсанта', 'Преподаватель', 'Program', 'Level', 'Group', 
                'Unit', 'Progress', 'Дата', 'Затраченное время');



  $servername = "localhost";
  $username = "root";
  $password = "mysql";
  $dbname = "QuizReports";
        
  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM all_quiz_res WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' ORDER BY teacher, quiz_code, gruppa, stud_name";
          
  $result = $conn->query($sql);
  array_push($rows, ["Список тестирований за период с $d1 по $d2:"]);
  array_push($rows, []);

  $writer = new XLSXWriter();
  array_push($rows, $header);
  if ($result->num_rows > 0) {
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        $parts = explode('_', $row["quiz_code"]);
        $program = substr($parts[0], 0, 2);
        $level = substr($parts[0], 2);
        $unit = $parts[1];
        
        array_push($rows, [$idx, $row["stud_name"], $row["teacher"], $program, $level, $row["gruppa"], $unit, 
              $row["stud_percent"], $row["finished_at"], $row["quiz_time"]]);
        $idx += 1;
      }
    } else {
      array_push($rows, ["0 results"]);
  }
  $writer->writeSheet($rows, 'Анализ результатов');
  
  $writer->writeToStdOut();

  $conn->close();
?>