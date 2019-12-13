<?php

include_once("xlsxwriter.class.php");
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);

$filename = "all-test-report.xlsx";

header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($filename).'"');
header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
header('Content-Transfer-Encoding: binary');
header('Cache-Control: must-revalidate');
header('Pragma: public');

$header = array('№', 'Название quiz-а', 'Код', 'Преподаватель', 'ФИО студента', 'Баллы', 
                'Проходной балл', 'Оценка %', 'Дата', 'Затраченное время');

$rows = [];
$d1 = $_GET['d1'];
$d2 = $_GET['d2'];

  $servername = "localhost";
  $username = "root";
  $password = "mysql";
  $dbname = "QuizReports";
        
  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM all_quiz_res WHERE CAST(finished_at AS DATE) BETWEEN '$d1' AND '$d2' ORDER BY quiz_code, teacher, stud_name";
          
  $result = $conn->query($sql);
  array_push($rows, ["Список тестирований за период с $d1 по $d2:"]);
  array_push($rows, []);

  $writer = new XLSXWriter();
  array_push($rows, $header);
  if ($result->num_rows > 0) {
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        array_push($rows, ["$idx", $row["quiz_name"] , $row["quiz_code"], $row["teacher"], $row["stud_name"], $row["user_score"], 
                            $row["pass_score"], $row["stud_percent"], $row["finished_at"], $row["quiz_time"]]);
        $idx += 1;
      }
    } else {
      array_push($rows, ["0 results"]);
  }
  $writer->writeSheet($rows, 'Report-all-quiz');
  
  $writer->writeToStdOut();

  $conn->close();
?>