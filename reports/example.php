<?php

include_once("xlsxwriter.class.php");
ini_set('display_errors', 1);
ini_set('log_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);

$filename = "example.xlsx";
header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($filename).'"');
header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
header('Content-Transfer-Encoding: binary');
header('Cache-Control: must-revalidate');
header('Pragma: public');

$rows = array();

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
         " WHERE CAST(q.finished_at AS DATE) BETWEEN '$d1' AND '$d2' group by q.q_id order by q.quiz_code, q.q_id";
  $result = $conn->query($sql);
  //loop the query data to the table in same order as the headers
  array_push($rows, "<h4>Данные по всем тестам за период с $d1 по $d2: </h4>");
  array_push($rows, " ");
  if ($result->num_rows > 0) {
    array_push($rows, "<table class='qr-detail-table rep-table'><thead><tr><th>№</th><th>Quiz-код(курс)</th><th>Текст вопроса</th><th>Средний балл(%)</th>".
        "</tr></thead><tbody class='rep-body'>");
    // output data of each row
      $idx = 1;
      while($row = $result->fetch_assoc()) {
        array_push($rows, "<tr><td>$idx</td><td>" . $row["quiz_code"]. "</td><td>" . $row["teacher"]. "</td><td>" . $row["q_text"]. "</td><td>" .  $row["avg_prc"] . "</td></tr>");
        $idx += 1;
      }
      array_push($rows, "</tbody></table>");
    } else {
      array_push($rows, "0 results");
  }
  $conn->close();

  $writer = new XLSXWriter();
  foreach($rows as $row)
    $writer->writeSheetRow('Отчет по вопросам', $row);
  $writer->writeToStdOut();
  //$writer->writeToFile('example.xlsx');
  //echo $writer->writeToString();
  exit(0);

?>
