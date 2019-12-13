<?php

include_once("xlsxwriter.class.php");
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);

$filename = "all-quest-report.xlsx";

header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($filename).'"');
header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
header('Content-Transfer-Encoding: binary');
header('Cache-Control: must-revalidate');
header('Pragma: public');

$header = array(
  '№',
  'Quiz-код',
  'Преподаватель',
  'Текст вопроса',
  'Процент успешных ответов'
);

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

  $sql = "SELECT q.q_id, q.quiz_code, q.teacher, q.q_text, FORMAT(avg(q.result), 2, 'ru_RU') as avg_prc FROM quiz_detail q " .
          " WHERE CAST(q.finished_at AS DATE) BETWEEN '$d1' AND '$d2' group by q.teacher, q.q_id order by q.quiz_code, q.teacher, q.q_id";
          
  $result = $conn->query($sql);
  array_push($rows, ["Данные по всем тестам за период с $d1 по $d2:"]);
  array_push($rows, []);

  $writer = new XLSXWriter();
  array_push($rows, $header);
  if ($result->num_rows > 0) {
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        array_push($rows, ["$idx", $row["quiz_code"], $row["teacher"], $row["q_text"],  $row["avg_prc"]]);
        $idx += 1;
      }
    } else {
      array_push($rows, ["0 results"]);
  }
  $writer->writeSheet($rows, 'Report');
  
  $writer->writeToStdOut();

  $conn->close();
?>