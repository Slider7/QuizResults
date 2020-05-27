<?php

error_reporting(E_ALL);

class QuizReportGenerator
{
    const PASSED = "passed";
    const FAILED = "failed";

    private $quizResults;

    var $quizData = [], $quests = [], $temp = [];

    /** @var QuizTakerInfo|null */
    private $takerInfo;

    public function __construct(QuizResults $quizResults, $requestParams)
    {
        $this->quizResults = $quizResults;
    }

    public function createReport()
    {
        global $quizData, $quests, $temp;

        $report = $this->fetchTemplateHeader();
        $details = $this->quizResults->detailResult;
        if ($details)
        {
            $questions = $details->questions; // array of questions
            $k = 0;        
            foreach ($questions as $question)
            {
                $k = $k + 1;
                $report .= "***QUESTION-$k". PHP_EOL . $this->prepareQuestion($question, $k - 1) . PHP_EOL;
            }
        }
/*---------------SAVE TO DB-----------------------------------------*/
        $db_msg = $this->saveQuizToDB($quizData, $quests);
//--------------------------------------------------------------------        

        return $report . PHP_EOL . $db_msg;
        /*. PHP_EOL . 'DB DATA: '. json_encode($quizData) . PHP_EOL . json_encode($quests) . PHP_EOL . '!!!Questions: ' .json_encode($temp); */
    }


    private function fetchTemplateHeader()
    {
        $header = '***QuizName: ' . $this->quizResults->quizTitle . PHP_EOL;
        
        global $quizData;

        $quizData['stud_name'] =  $this->quizResults->studentName;
        //$quizData['group'] =  $this->quizResults->studCode;

        // Some old quiz versions don't contain the student name and email
        // in the taker info fields, instead the name and email are sent
        // using special request parameters. The following code compensates
        // for that case.
        if (!$this->doesQuizTakerInfoContainEmail())
        {
            if ($this->quizResults->studentName)
            {
                $header .= '***UserName: ' . $this->quizResults->studentName . PHP_EOL;
            }
            if ($this->quizResults->studentEmail)
            {
                $header .= '***UserEmail: ' . $this->quizResults->studentEmail . PHP_EOL;
            }
        }

        $header .= $this->getTakerInfoFields();

        if ($this->quizResults->quizType == QuizType::GRADED)
        {
            $header .= 'Result: ' . $this->quizResults->formatStatus() . PHP_EOL;
            $header .= 'User Score: ' . $this->quizResults->formatUserScore() . PHP_EOL;
            $header .= 'Passing Score: ' . $this->quizResults->formatPassingScore() . PHP_EOL;
            
            $quizData['user_score'] = $this->quizResults->formatUserScore();
            $quizData['pass_score'] = $this->quizResults->formatPassingScore();
            $quizData['stud_percent'] = $this->quizResults->studentPercents;
        }

        if ($this->quizResults->formattedQuizTakingTime)
        {
            $header .= 'Quiz Taking Time: ' . $this->quizResults->formattedQuizTakingTime . PHP_EOL;
            $quizData['quiz_time'] = $this->quizResults->formattedQuizTakingTime;
        }

        if ($this->quizResults->detailResult->finishedAt)
        {
            $header .= "Quiz Finished At: " . $this->quizResults->detailResult->finishedAt . PHP_EOL;
        }

        return $header;
    }

    private function prepareQuestion(Question $question, $k)
    {
        global $quests;
        $item = [];

        $text = $question->direction . PHP_EOL;

        if ($question->isGraded())
        {
            $text .= '***Awarded Points: ' . $question->awardedPoints . PHP_EOL;
            if (!empty($question->correctAnswer))
            {
                $text .= '***Correct Response: ' . $question->correctAnswer . PHP_EOL;
            }
        }

        $text .= '***User Response: ' . $question->userAnswer . PHP_EOL;

        $item[0] = $question->direction;
        $item[1] = $question->correctAnswer;
        $item[2] = $question->userAnswer;
        $item[3] = $question->awardedPoints;
        $item[4] = $question->maxPoints;

        $quests[$k] = $item;

        return $text;
    }

    /**
     * @param QuizTakerInfo $takerInfo
     */
    public function setTakerInfo(QuizTakerInfo $takerInfo = null)
    {
        $this->takerInfo = $takerInfo;
    }

    /**
     * @return string
     */
    private function getTakerInfoFields()
    {
        global $quizData;

        $result = '';
        $fields = $this->takerInfo ? $this->takerInfo->getFields() : [];
        foreach ($fields as $field)
        {
            $result .= "{$field->getTitle()}: {$field->getValue()}" . PHP_EOL;
            //-----------------------------
            if ($field->getTitle() === 'Program') {$quizData['program'] =  $field->getValue();};
            if ($field->getTitle() === 'Teacher') {$quizData['teacher'] =  $field->getValue();};
            if ($field->getTitle() === 'Unit') {$quizData['unit'] =  $field->getValue();};
            if ($field->getTitle() === 'Group') {$quizData['gruppa'] =  $field->getValue();};
            if ($field->getTitle() === 'Age') {$quizData['age'] =  $field->getValue();};
            if ($field->getTitle() === 'Phone') {$quizData['phone'] =  $field->getValue();};
            if ($field->getTitle() === 'Email') {$quizData['email'] =  $field->getValue();};
            //-------------------------------------
        }
        return $result;
    }

    /**
     * @return bool
     */
    private function doesQuizTakerInfoContainEmail()
    {
        return $this->takerInfo && $this->takerInfo->doesContainUserEmail();
    }

private function saveQuizToDB($quizData, $quests)
    {   
        $err_msq = '';
        $db = parse_ini_file('../../conf/connect.ini');
        $user = $db['user'];
        $pass = $db['pass'];
        $dbname = $db['name'];
        $host = $db['host'];
        // Create connection
        $conn = new mysqli($host, $user, $pass, $dbname);
        // Check connection 
        if ($conn->connect_error) {
          $err_msq = 'Error on connecting to MySQL DB.';
        }
        
        //---------QUIZRESULT SAVE------------
        $studName = $conn->real_escape_string($quizData['stud_name']);
        $gruppa = $quizData['gruppa']; 
        $age = isset($quizData['age']) ? $quizData['age'] : -1;
        $phone = isset($quizData['phone']) ? $quizData['phone'] : 'none';
        $email = isset($quizData['email']) ? $quizData['email'] : 'none';
        $quiz_id = -1;
        $qr_id = -1;
        $quiz_code = $quizData['program'] . '_' . $quizData['unit'];
        $user_score = $quizData['user_score'];
        $pass_score = $quizData['pass_score'];
        $quiz_time = $quizData['quiz_time'];
        date_default_timezone_set('Asia/Almaty');
        $finished_at = date("Y-m-d H:i:s"); 
        $stud_percent = $quizData['stud_percent'];
        $teacher = $conn->real_escape_string($quizData['teacher']);

        $sql = "SELECT quiz_id FROM Quiz WHERE quiz_code = '$quiz_code'";
        $temp_data = $conn->query($sql);
        if ($temp_data->num_rows > 0) {
           $quiz_id = $temp_data->fetch_object()->quiz_id;
        };
        
        // $sql = "INSERT INTO quiz_result (quiz_id, stud_id, teacher, user_score, pass_score, quiz_time, finished_at, stud_percent) " .
        
        /*-----------------Проверка повторной отправки-----------------*/
        /* $_SERVER['REMOTE_ADDR'] */
        $sqlcheck = "SELECT * FROM quiz_results WHERE quiz_id = '$quiz_id' and stud_name like '$studName' " . 
                    "and teacher = '$teacher' and finished_at > DATE_SUB(NOW(), INTERVAL 5 MINUTE)";
        $temp_data = $conn->query($sqlcheck);
        if ($temp_data->num_rows > 0) { 
            exit('duplicate results!'); 
        };

        $sql = "INSERT INTO quiz_results (quiz_id, teacher, stud_name, user_score, pass_score, quiz_time, finished_at, stud_percent, gruppa, age, phone, email) " .
               " VALUES ('$quiz_id', '$teacher', '$studName', '$user_score', '$pass_score', '$quiz_time',
                         '$finished_at', '$stud_percent', '$gruppa', '$age', '$phone', '$email' )";
          if ($conn->query($sql) === TRUE) {
            $qr_id = $conn->insert_id;
          } else {
              $err_msq = $err_msq . PHP_EOL . "Error: " . $sql . "<br>" . $conn->error;
          };

        //---------QUESTIONS & ANSWERS SAVE------------
        foreach ($quests as $quest)
        {
          $qtext = $conn->real_escape_string($quest[0]);
          $qtext = substr($qtext, 0, 80) . 'n...'; //Проверить!!!
          $corr_resp = $conn->real_escape_string($quest[1]);
          $user_resp = $conn->real_escape_string($quest[2]);
          $award_points = $quest[3];
          $max_points = $quest[4];

          $q_id = -1;
          //--------------------QUESTIONS--------------------------
          $sql = "SELECT DISTINCT q_id FROM question WHERE q_text like '$qtext%' and quiz_code = '$quiz_code'" ;
          $temp_data = $conn->query($sql);
          $err_msq = $err_msq . PHP_EOL . $sql . ' $$$data: '. json_encode($temp_data->num_rows) . ' $$$db: '. json_encode($db);
          if ($temp_data->num_rows > 0) {
            $q_id = $temp_data->fetch_object()->q_id;
          } else {
            $sql = "INSERT INTO question (q_text, corr_resp, quiz_code, maxpoint) VALUES ('$qtext', '$corr_resp', '$quiz_code', '$max_points')";
            if ($conn->query($sql) === TRUE) {
              $q_id = $conn->insert_id;
              $err_msq = $err_msq . PHP_EOL . 'Q_ID:' . $q_id;
            } else {
              $err_msq = $err_msq . PHP_EOL . "Error: " . $sql . "<br>" . $conn->error;
            };
          };
          //--------------------ANSWERS--------------------------
          if ($q_id > 0 ) {
            $sql = "INSERT INTO answers (qr_id, q_id, award_points, user_resp) VALUES ('$qr_id', '$q_id', '$award_points', '$user_resp')";
            $err_msq = $err_msq . PHP_EOL . $sql . ' $$$data-Q_ID: '. $q_id;
            if ($conn->query($sql) === TRUE) {
              $err_msq = $err_msq . 'ans_id = ' . $conn->insert_id . PHP_EOL;
            } else {
              $err_msq = $err_msq . PHP_EOL . "Error: " . $sql . "<br>" . $conn->error;
            };
          }
        }

        $conn->close();

        return $err_msq;
    }
}