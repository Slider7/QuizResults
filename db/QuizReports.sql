-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 09 2019 г., 08:52
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
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `answers`
--

INSERT INTO `answers` (`ans_id`, `qr_id`, `q_id`, `award_points`, `user_resp`) VALUES
(54, 61, 50, 10, 'True'),
(55, 61, 51, 10, 'True'),
(56, 61, 52, 10, 'China and Nepal'),
(57, 61, 53, 10, 'altitude sickness; weather and wind'),
(58, 62, 50, 10, 'True'),
(59, 62, 51, 0, 'False'),
(60, 62, 52, 10, 'China and Nepal'),
(61, 62, 53, 0, 'weather and wind'),
(62, 63, 50, 10, 'True'),
(63, 63, 51, 10, 'True'),
(64, 63, 52, 0, 'China and Tibet'),
(65, 63, 53, 0, 'substantial technical climbing challenges'),
(66, 64, 50, 10, 'True'),
(67, 64, 51, 10, 'True'),
(68, 64, 52, 0, 'Nepal and Bhutan'),
(69, 64, 53, 10, 'altitude sickness; weather and wind'),
(70, 65, 50, 10, 'True'),
(71, 65, 51, 0, 'False'),
(72, 65, 52, 0, 'Tibet and India'),
(73, 65, 53, 0, 'weather and wind'),
(74, 66, 50, 0, 'False'),
(75, 66, 51, 10, 'True'),
(76, 66, 52, 10, 'China and Nepal'),
(77, 66, 53, 0, 'altitude sickness'),
(78, 67, 50, 0, 'False'),
(79, 67, 51, 0, 'False'),
(80, 67, 52, 10, 'China and Nepal'),
(81, 67, 53, 0, 'weather and wind'),
(82, 68, 50, 10, 'True'),
(83, 68, 51, 10, 'True'),
(84, 68, 52, 10, 'China and Nepal'),
(85, 68, 53, 0, 'altitude sickness'),
(94, 71, 54, 10, 'True'),
(95, 71, 55, 10, 'True'),
(96, 71, 56, 10, 'China and Nepal'),
(97, 71, 57, 10, 'altitude sickness; weather and wind'),
(98, 72, 54, 10, 'True'),
(99, 72, 55, 10, 'True'),
(100, 72, 56, 0, 'China and India'),
(101, 72, 57, 0, 'altitude sickness'),
(102, 73, 54, 10, 'True'),
(103, 73, 55, 0, 'False'),
(104, 73, 56, 10, 'China and Nepal'),
(105, 73, 57, 10, 'altitude sickness; weather and wind');

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `question`
--

INSERT INTO `question` (`q_id`, `q_text`, `corr_resp`, `quiz_code`) VALUES
(47, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest'),
(48, 'In 1856, during the Great Trigonometrical Survey of India, the first published height of Everest was established at 29,002 feet (8,840 m). \r\nHowever, the official height of Everest was later set at...', '29,029 feet (8,848 m)', 'Everest'),
(49, 'Everest isn''t the furthest summit from the estimated center of our planet.', 'True', 'Everest'),
(50, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest2'),
(51, 'Everest isn''t the furthest summit from the estimated center of our planet.', 'True', 'Everest2'),
(52, 'Everest''s summit point is located on the international border between these countries:', 'China and Nepal', 'Everest2'),
(53, 'One of the two main climbing routes approaches the summit from the southeast in Nepal. What challenges do climbers face while climbing this route?', 'altitude sickness; weather and wind', 'Everest2'),
(54, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest-1'),
(55, 'Everest isn''t the furthest summit from the estimated center of our planet.', 'True', 'Everest-1'),
(56, 'Everest''s summit point is located on the international border between these countries:', 'China and Nepal', 'Everest-1'),
(57, 'One of the two main climbing routes approaches the summit from the southeast in Nepal. What challenges do climbers face while climbing this route?', 'altitude sickness; weather and wind', 'Everest-1');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Quiz`
--

INSERT INTO `Quiz` (`quiz_id`, `quiz_name`, `quiz_code`, `Program`, `Unit`) VALUES
(1, 'Sample Quiz Everest', 'Everest2', 'English Test', 'Unit1'),
(3, 'Everest Sample Quiz', 'Everest-1', 'English Test 1', 'Unit1');

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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `quiz_result`
--

INSERT INTO `quiz_result` (`qr_id`, `quiz_id`, `stud_id`, `teacher`, `user_score`, `pass_score`, `quiz_time`, `finished_at`, `stud_percent`) VALUES
(61, 1, 29, 'Ivanov P.A.', 40, 20, '00:00:09', '2019-12-03 14:11:04', 100),
(62, 1, 30, 'Ivanov P.A.', 20, 20, '00:00:08', '2019-12-03 14:11:34', 50),
(63, 1, 31, 'Ð’Ð°ÑÐ¸Ð»ÑŒÐµÐ²Ð° Ðœ.Ðš.', 20, 20, '00:00:06', '2019-12-03 14:12:22', 50),
(64, 1, 32, 'Ð’Ð°ÑÐ¸Ð»ÑŒÐµÐ²Ð° Ðœ.Ðš.', 30, 20, '00:00:11', '2019-12-03 14:13:39', 75),
(65, 1, 33, 'Ð’Ð°ÑÐ¸Ð»ÑŒÐµÐ²Ð° Ðœ.Ðš.', 10, 20, '00:00:07', '2019-12-03 14:14:16', 25),
(66, 1, 34, 'Ivanov P.A.', 20, 20, '00:00:07', '2019-12-03 14:14:47', 50),
(67, 1, 35, 'Ð˜Ð²Ð°Ð½Ð¾Ð²Ð° Ð¡.ÐŸ.', 10, 20, '00:00:14', '2019-12-03 14:15:53', 25),
(68, 1, 36, 'Ð˜Ð²Ð°Ð½Ð¾Ð²Ð° Ð¡.ÐŸ.', 30, 20, '00:00:10', '2019-12-03 14:16:51', 75),
(71, 3, 38, 'Ð˜Ð²Ð°Ð½Ð¾Ð²Ð° Ð¡.ÐŸ.', 40, 20, '00:00:09', '2019-12-05 16:07:26', 100),
(72, 3, 39, 'Ð˜Ð²Ð°Ð½Ð¾Ð²Ð° Ð¡.ÐŸ.', 20, 20, '00:00:08', '2019-12-05 16:12:57', 50),
(73, 3, 40, 'Ð˜Ð²Ð°Ð½Ð¾Ð²Ð° Ð¡.ÐŸ.', 30, 20, '00:00:12', '2019-12-09 09:37:22', 75);

-- --------------------------------------------------------

--
-- Структура таблицы `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `stud_id` int(11) NOT NULL,
  `fio` varchar(120) DEFAULT NULL,
  `stud_code` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `student`
--

INSERT INTO `student` (`stud_id`, `fio`, `stud_code`) VALUES
(29, 'ÐŸÐµÑ‚Ñ€Ð¾Ð² Ð˜.', 'st0001'),
(30, 'Ð¡Ð¸Ð´Ð¾Ñ€Ð¾Ð²', 'st0002'),
(31, 'Ð¡Ð¸Ð´Ð¾Ñ€Ð¾Ð²Ð° Ðš.', 'st0003'),
(32, 'Ð˜ÑÐ°ÐµÐ² Ðœ.', 'st0004'),
(33, 'ÐÐ»Ð¸Ð±Ð°ÐµÐ² Ðœ.', 'st0005'),
(34, 'ÐŸÐµÑ‚Ñ€ÐµÐ½ÐºÐ¾ Ð’.', 'st0006'),
(35, 'Ð¡Ð¼Ð¸Ñ‚ Ð.', 'st0007'),
(36, 'ÐšÐ»Ð¸Ð¼Ð¾Ð² ÐŸ.', 'st0008'),
(37, 'Ð¢ÐµÑÑ‚ÐµÑ€', ''),
(38, 'Ð¢ÐµÑÑ‚ÐµÑ€-2', 'st0102'),
(39, 'Ð¤Ð¾Ð¼Ð¸Ð½ Ð.', 'st0203'),
(40, 'Ð¡Ð°Ð²Ñ‡ÐµÐ½ÐºÐ¾ Ð’.', 'st0301');

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
  MODIFY `ans_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=106;
--
-- AUTO_INCREMENT для таблицы `question`
--
ALTER TABLE `question`
  MODIFY `q_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT для таблицы `Quiz`
--
ALTER TABLE `Quiz`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `quiz_result`
--
ALTER TABLE `quiz_result`
  MODIFY `qr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=74;
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
