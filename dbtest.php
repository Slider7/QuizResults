<?php
error_reporting(E_ALL);

$qd = ['quiz_code'=>'Everest', 'stud_name'=>'RealTester2', 'stud_code'=>'st0005', 'program'=>'English Test', 'teacher'=>'Ivanov P.', 'user_score'=>'10 / 30 (33.33%)', 'pass_score'=>'15 (50%)', 'quiz_time'=>'00:00:06'];

$q = [["The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.","True","False","0"],["In 1856, during the Great Trigonometrical Survey of India, the first published height of Everest was established at 29,002 feet (8,840 m). \r\nHowever, the official height of Everest was later set at...","29,029 feet (8,848 m)","29,029 feet (8,848 m)","10"],["Everest isn't the furthest summit from the estimated center of our planet.","True","False","0"]];

echo saveQuizToDB($qd, $q);

function saveQuizToDB($quizData, $quests)
    {
        $servername = "localhost";
        $username = "root";
        $password = "mysql";
        $dbname = "QuizReports";
        $db_result = true;
        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);
        // Check connection 
        if ($conn->connect_error) {
          $db_result = false;
        }
        
     //---------STUDENT CHECK & SAVE------------
        $studCode = $quizData['stud_code'];
        $studName = $conn->real_escape_string($quizData['stud_name']);
        $stud_id = 0;
        $sql = "SELECT stud_id FROM student WHERE stud_code = '$studCode'";
        $temp_data = $conn->query($sql);
        if ($temp_data->num_rows > 0) {
           $stud_id = $temp_data->fetch_object()->stud_id;
        } else {
            $sql = "INSERT INTO student (FIO, stud_code) VALUES ('$studName', '$studCode')";
            if ($conn->query($sql) === TRUE) {
                    $stud_id = $conn->insert_id;
                } else {
                    echo "Error: " . $sql . "<br>" . $conn->error;
                }
        }

        //---------QUIZRESULT SAVE------------
        $quiz_id = -1;
        $qr_id = -1;
        $quiz_code = $conn->real_escape_string($quizData['quiz_code']);
        $user_score = $quizData['user_score'];
        $pass_score = $quizData['pass_score'];
        $quiz_time = $quizData['quiz_time'];
        date_default_timezone_set('Asia/Almaty');
        $finished_at = date("Y-m-d H:i:s"); 
        //$quizData['finished_at']; 
        $teacher = $conn->real_escape_string($quizData['teacher']);

        $sql = "SELECT quiz_id FROM Quiz WHERE quiz_code = '$quiz_code'";
        $temp_data = $conn->query($sql);
        if ($temp_data->num_rows > 0) {
           $quiz_id = $temp_data->fetch_object()->quiz_id;
        };
        
        $sql = "INSERT INTO quiz_result (quiz_id, stud_id, teacher, user_score, pass_score, quiz_time, finished_at) " .
               " VALUES ('$quiz_id', '$stud_id', '$teacher', '$user_score', '$pass_score', '$quiz_time', '$finished_at')";
          if ($conn->query($sql) === TRUE) {
            $qr_id = $conn->insert_id;
          } else {
              echo "Error: " . $sql . "<br>" . $conn->error;
          };

        //---------QUESTIONS SAVE------------
        foreach ($quests as $quest)
        {
          $qtext = $conn->real_escape_string($quest[0]);
          $corr_resp = $conn->real_escape_string($quest[1]);
          $q_id = -1;
          $sql = "SELECT q_id FROM question WHERE q_text like '$qtext' and quiz_code like '$quiz_code'" ;
          $temp_data = $conn->query($sql);
          if ($temp_data->num_rows > 0) {
            $q_id = $temp_data->fetch_object()->q_id;
          } else {
            $sql = "INSERT INTO question (q_text, corr_resp, quiz_code) VALUES ('$qtext', '$corr_resp', '$quiz_code')";
            if ($conn->query($sql) === TRUE) {
              $q_id = $conn->insert_id;
            } else {
              echo "Error: " . $sql . "<br>" . $conn->error;
            };
          };
        }

        $conn->close();

        return $db_result;
    }
?>