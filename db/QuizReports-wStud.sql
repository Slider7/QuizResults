-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 11 2019 г., 09:26
-- Версия сервера: 5.6.37
-- Версия PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `QuizReports`
--

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `all_quiz_details`
--
CREATE TABLE IF NOT EXISTS `all_quiz_details` (
`qr_id` int(11)
,`quiz_code` varchar(20)
,`teacher` varchar(80)
,`q_text` varchar(200)
,`q_id` int(11)
,`award_points` float
,`result` int(1)
,`user_resp` varchar(80)
,`fio` varchar(120)
,`stud_code` varchar(20)
,`finished_at` datetime
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `all_quiz_res`
--
CREATE TABLE IF NOT EXISTS `all_quiz_res` (
`quiz_code` varchar(30)
,`fio` varchar(120)
,`stud_code` varchar(20)
,`teacher` varchar(80)
,`user_score` float
,`pass_score` float
,`finished_at` datetime
,`quiz_time` varchar(80)
,`stud_percent` float
,`qr_id` int(11)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `all_quiz_results`
--
CREATE TABLE IF NOT EXISTS `all_quiz_results` (
`quiz_code` varchar(30)
,`fio` varchar(120)
,`stud_code` varchar(20)
,`teacher` varchar(80)
,`user_score` float
,`pass_score` float
,`finished_at` datetime
,`quiz_time` varchar(80)
,`qr_id` int(11)
);

-- --------------------------------------------------------

--
-- Структура таблицы `answers`
--

CREATE TABLE IF NOT EXISTS `answers` (
  `ans_id` int(11) NOT NULL,
  `qr_id` int(11) NOT NULL,
  `q_id` int(11) NOT NULL,
  `award_points` float NOT NULL DEFAULT '0',
  `user_resp` varchar(80) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `avg_points_quiz`
--
CREATE TABLE IF NOT EXISTS `avg_points_quiz` (
`quiz_code` varchar(30)
,`avg(stud_percent)` double
,`qr_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `avg_points_teacher`
--
CREATE TABLE IF NOT EXISTS `avg_points_teacher` (
`teacher` varchar(80)
,`avg(stud_percent)` double
,`qr_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Структура таблицы `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `q_id` int(11) NOT NULL,
  `q_text` varchar(200) DEFAULT NULL,
  `corr_resp` varchar(80) NOT NULL,
  `quiz_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `question`
--

INSERT INTO `question` (`q_id`, `q_text`, `corr_resp`, `quiz_code`) VALUES
(47, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest'),
(48, 'In 1856, during the Great Trigonometrical Survey of India, the first published height of Everest was established at 29,002 feet (8,840 m). \r\nHowever, the official height of Everest was later set at...', '29,029 feet (8,848 m)', 'Everest'),
(49, 'Everest isn''t the furthest summit from the estimated center of our planet.', 'True', 'Everest'),
(50, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest2');

-- --------------------------------------------------------

--
-- Структура таблицы `Quiz`
--

CREATE TABLE IF NOT EXISTS `Quiz` (
  `quiz_id` int(11) NOT NULL,
  `quiz_name` varchar(100) DEFAULT NULL,
  `quiz_code` varchar(30) NOT NULL,
  `Program` varchar(60) DEFAULT NULL,
  `Unit` varchar(60) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Quiz`
--

INSERT INTO `Quiz` (`quiz_id`, `quiz_name`, `quiz_code`, `Program`, `Unit`) VALUES
(1, 'Sample Quiz Everest', 'Everest2', 'English Test', 'Unit1'),
(3, 'Everest Sample Quiz', 'Everest-1', 'English Test 1', 'Unit1'),
(4, 'FF1_Unit1', 'FF1_1', 'FF1', '1');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `quiz_details`
--
CREATE TABLE IF NOT EXISTS `quiz_details` (
`qr_id` int(11)
,`quiz_code` varchar(20)
,`q_text` varchar(200)
,`q_id` int(11)
,`award_points` float
,`result` int(1)
,`user_resp` varchar(80)
,`fio` varchar(120)
,`stud_code` varchar(20)
,`finished_at` datetime
);

-- --------------------------------------------------------

--
-- Структура таблицы `quiz_result`
--

CREATE TABLE IF NOT EXISTS `quiz_result` (
  `qr_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `stud_id` int(11) NOT NULL,
  `teacher` varchar(80) DEFAULT NULL,
  `user_score` float DEFAULT NULL,
  `pass_score` float DEFAULT NULL,
  `quiz_time` varchar(80) DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `stud_percent` float DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `stud_id` int(11) NOT NULL,
  `fio` varchar(120) DEFAULT NULL,
  `stud_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `student`
--
-- --------------------------------------------------------

--
-- Структура для представления `all_quiz_details`
--
DROP TABLE IF EXISTS `all_quiz_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`all_quiz_details` AS select `qr`.`qr_id` AS `qr_id`,`q`.`quiz_code` AS `quiz_code`,`qr`.`teacher` AS `teacher`,`q`.`q_text` AS `q_text`,`q`.`q_id` AS `q_id`,`a`.`award_points` AS `award_points`,if((`a`.`award_points` > 0),1,0) AS `result`,`a`.`user_resp` AS `user_resp`,`s`.`fio` AS `fio`,`s`.`stud_code` AS `stud_code`,`qr`.`finished_at` AS `finished_at` from (((`quizreports`.`answers` `a` join `quizreports`.`student` `s`) join `quizreports`.`question` `q`) join `quizreports`.`quiz_result` `qr`) where ((`a`.`qr_id` = `qr`.`qr_id`) and (`a`.`q_id` = `q`.`q_id`) and (`s`.`stud_id` = `qr`.`stud_id`));

-- --------------------------------------------------------

--
-- Структура для представления `all_quiz_res`
--
DROP TABLE IF EXISTS `all_quiz_res`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`all_quiz_res` AS select `q`.`quiz_code` AS `quiz_code`,`s`.`fio` AS `fio`,`s`.`stud_code` AS `stud_code`,`qr`.`teacher` AS `teacher`,`qr`.`user_score` AS `user_score`,`qr`.`pass_score` AS `pass_score`,`qr`.`finished_at` AS `finished_at`,`qr`.`quiz_time` AS `quiz_time`,`qr`.`stud_percent` AS `stud_percent`,`qr`.`qr_id` AS `qr_id` from ((`quizreports`.`quiz` `q` join `quizreports`.`student` `s`) join `quizreports`.`quiz_result` `qr`) where ((`q`.`quiz_id` = `qr`.`quiz_id`) and (`s`.`stud_id` = `qr`.`stud_id`));

-- --------------------------------------------------------

--
-- Структура для представления `all_quiz_results`
--
DROP TABLE IF EXISTS `all_quiz_results`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`all_quiz_results` AS select `q`.`quiz_code` AS `quiz_code`,`s`.`fio` AS `fio`,`s`.`stud_code` AS `stud_code`,`qr`.`teacher` AS `teacher`,`qr`.`user_score` AS `user_score`,`qr`.`pass_score` AS `pass_score`,`qr`.`finished_at` AS `finished_at`,`qr`.`quiz_time` AS `quiz_time`,`qr`.`qr_id` AS `qr_id` from ((`quizreports`.`quiz` `q` join `quizreports`.`student` `s`) join `quizreports`.`quiz_result` `qr`) where ((`q`.`quiz_id` = `qr`.`quiz_id`) and (`s`.`stud_id` = `qr`.`stud_id`));

-- --------------------------------------------------------

--
-- Структура для представления `avg_points_quiz`
--
DROP TABLE IF EXISTS `avg_points_quiz`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`avg_points_quiz` AS select `all_quiz_res`.`quiz_code` AS `quiz_code`,avg(`all_quiz_res`.`stud_percent`) AS `avg(stud_percent)`,count(0) AS `qr_count` from `quizreports`.`all_quiz_res` group by `all_quiz_res`.`quiz_code`;

-- --------------------------------------------------------

--
-- Структура для представления `avg_points_teacher`
--
DROP TABLE IF EXISTS `avg_points_teacher`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`avg_points_teacher` AS select `all_quiz_res`.`teacher` AS `teacher`,avg(`all_quiz_res`.`stud_percent`) AS `avg(stud_percent)`,count(0) AS `qr_count` from `quizreports`.`all_quiz_res` group by `all_quiz_res`.`teacher`;

-- --------------------------------------------------------

--
-- Структура для представления `quiz_details`
--
DROP TABLE IF EXISTS `quiz_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`quiz_details` AS select `qr`.`qr_id` AS `qr_id`,`q`.`quiz_code` AS `quiz_code`,`q`.`q_text` AS `q_text`,`q`.`q_id` AS `q_id`,`a`.`award_points` AS `award_points`,if((`a`.`award_points` > 0),1,0) AS `result`,`a`.`user_resp` AS `user_resp`,`s`.`fio` AS `fio`,`s`.`stud_code` AS `stud_code`,`qr`.`finished_at` AS `finished_at` from (((`quizreports`.`answers` `a` join `quizreports`.`student` `s`) join `quizreports`.`question` `q`) join `quizreports`.`quiz_result` `qr`) where ((`a`.`qr_id` = `qr`.`qr_id`) and (`a`.`q_id` = `q`.`q_id`) and (`s`.`stud_id` = `qr`.`stud_id`));

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`ans_id`),
  ADD KEY `answers_ibfk_1` (`qr_id`),
  ADD KEY `answers_ibfk_2` (`q_id`);

--
-- Индексы таблицы `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`q_id`);

--
-- Индексы таблицы `Quiz`
--
ALTER TABLE `Quiz`
  ADD PRIMARY KEY (`quiz_id`),
  ADD UNIQUE KEY `quiz_code_idx` (`quiz_code`);

--
-- Индексы таблицы `quiz_result`
--
ALTER TABLE `quiz_result`
  ADD PRIMARY KEY (`qr_id`),
  ADD KEY `quiz_res_quiz_fk_1` (`quiz_id`),
  ADD KEY `fk_qr_stud_1` (`stud_id`);

--
-- Индексы таблицы `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`stud_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `answers`
--
ALTER TABLE `answers`
  MODIFY `ans_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=136;
--
-- AUTO_INCREMENT для таблицы `question`
--
ALTER TABLE `question`
  MODIFY `q_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT для таблицы `Quiz`
--
ALTER TABLE `Quiz`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT для таблицы `quiz_result`
--
ALTER TABLE `quiz_result`
  MODIFY `qr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=77;
--
-- AUTO_INCREMENT для таблицы `student`
--
ALTER TABLE `student`
  MODIFY `stud_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`qr_id`) REFERENCES `quiz_result` (`qr_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`q_id`) REFERENCES `question` (`q_id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `quiz_result`
--
ALTER TABLE `quiz_result`
  ADD CONSTRAINT `fk_qr_stud_1` FOREIGN KEY (`stud_id`) REFERENCES `student` (`stud_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `quiz_res_quiz_fk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`quiz_id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
