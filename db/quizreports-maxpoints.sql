SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE IF NOT EXISTS question (
  q_id int(11) NOT NULL,
  q_text varchar(200) DEFAULT NULL,
  corr_resp varchar(80) NOT NULL,
  quiz_code varchar(20) DEFAULT NULL,
  maxpoint int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `quiz_detail2` (
`qr_id` int(11)
,`quiz_code` varchar(20)
,`teacher` varchar(80)
,`q_text` varchar(200)
,`q_id` int(11)
,`award_points` float
,`maxpoint` int(11)
,`result` int(1)
,`user_resp` varchar(80)
,`finished_at` datetime
);
DROP TABLE IF EXISTS `quiz_detail2`;

CREATE ALGORITHM=UNDEFINED DEFINER=root@localhost SQL SECURITY DEFINER VIEW quizreports.quiz_detail2 AS select qr.qr_id AS qr_id,q.quiz_code AS quiz_code,qr.teacher AS teacher,q.q_text AS q_text,q.q_id AS q_id,a.award_points AS award_points,q.maxpoint AS maxpoint,if((a.award_points >= q.maxpoint),1,0) AS result,a.user_resp AS user_resp,qr.finished_at AS finished_at from ((quizreports.answers a join quizreports.question q) join quizreports.quiz_results qr) where ((a.qr_id = qr.qr_id) and (a.q_id = q.q_id)) order by q.quiz_code,qr.teacher,qr.stud_name;


ALTER TABLE question
  ADD PRIMARY KEY (q_id);


ALTER TABLE question
  MODIFY q_id int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
