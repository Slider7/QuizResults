-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 13 2019 г., 09:47
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
-- Дублирующая структура для представления `all_quiz_res`
--
CREATE TABLE IF NOT EXISTS `all_quiz_res` (
`quiz_name` varchar(100)
,`quiz_code` varchar(30)
,`stud_name` varchar(80)
,`stud_percent` float
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
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `answers`
--

INSERT INTO `answers` (`ans_id`, `qr_id`, `q_id`, `award_points`, `user_resp`) VALUES
(126, 1, 66, 0, '1. Option 2; 2. Option 1; 3. Option 4; 4. Option 3'),
(127, 1, 67, 0, 'Option 3'),
(128, 1, 68, 0, 'places; words'),
(129, 1, 67, 0, 'Option 3'),
(130, 1, 69, 0, 'Option 2'),
(131, 1, 70, 0, '1'),
(132, 1, 68, 12, 'words; places'),
(133, 1, 71, 0, '2'),
(134, 1, 72, 0, 'False'),
(135, 1, 73, 0, 'Answer 2'),
(216, 4, 69, 5, 'Option 1'),
(217, 4, 68, 8, 'words; places'),
(218, 4, 71, 0, '1'),
(219, 4, 70, 0, '2'),
(220, 4, 73, 8, 'Answer 1'),
(221, 4, 67, 5, 'Option 1'),
(222, 4, 66, 0, '1. Option 3; 2. Option 4; 3. Option 2; 4. Option 1'),
(223, 4, 72, 4, 'True'),
(224, 4, 68, 12, 'words; places'),
(225, 4, 67, 4, 'Option 1'),
(226, 5, 70, 0, '1'),
(227, 5, 67, 4, 'Option 1'),
(228, 5, 72, 0, 'False'),
(229, 5, 66, 0, '1. Option 4; 2. Option 3; 3. Option 2; 4. Option 1'),
(230, 5, 68, 8, 'words; places'),
(231, 5, 69, 5, 'Option 1'),
(232, 5, 73, 0, 'Answer 2'),
(233, 5, 68, 12, 'words; places'),
(234, 5, 67, 5, 'Option 1'),
(235, 5, 71, 0, '2');

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
(50, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest2'),
(51, 'Everest isn''t the furthest summit from the estimated center of our planet.', 'True', 'Everest2'),
(52, 'Everest''s summit point is located on the international border between these countries:', 'China and Nepal', 'Everest2'),
(53, 'One of the two main climbing routes approaches the summit from the southeast in Nepal. What challenges do climbers face while climbing this route?', 'altitude sickness; weather and wind', 'Everest2'),
(54, 'The mountain was officially named after George Everest, a retired Surveyor General who never even saw the peak.', 'True', 'Everest-1'),
(55, 'Everest isn''t the furthest summit from the estimated center of our planet.', 'True', 'Everest-1'),
(56, 'Everest''s summit point is located on the international border between these countries:', 'China and Nepal', 'Everest-1'),
(57, 'One of the two main climbing routes approaches the summit from the southeast in Nepal. What challenges do climbers face while climbing this route?', 'altitude sickness; weather and wind', 'Everest-1'),
(58, 'Select one or more correct answers:', 'Option 1', '_'),
(59, 'Drag and drop the words to their places:', 'words; places', '_'),
(60, 'Arrange the following items in the correct order:', '1. Option 1; 2. Option 2; 3. Option 3; 4. Option 4', '_'),
(61, 'Choose whether the statement is true or false:', 'True', '_'),
(62, 'Fill in the blank fields in this text:', 'blanks', '_'),
(63, 'Choose the correct answer in each drop-down list:', 'Answer 1', '_'),
(64, 'Select the correct answer option:', 'Option 1', '_'),
(65, 'Type your response:', '= 0', '_'),
(66, 'Arrange the following items in the correct order:', '1. Option 1; 2. Option 2; 3. Option 3; 4. Option 4', 'FF1_1'),
(67, 'Select the correct answer option:', 'Option 1', 'FF1_1'),
(68, 'Drag and drop the words to their places:', 'words; places', 'FF1_1'),
(69, 'Select one or more correct answers:', 'Option 1', 'FF1_1'),
(70, 'Fill in the blank fields in this text:', 'blanks', 'FF1_1'),
(71, 'Type your response:', '= 0', 'FF1_1'),
(72, 'Choose whether the statement is true or false:', 'True', 'FF1_1'),
(73, 'Choose the correct answer in each drop-down list:', 'Answer 1', 'FF1_1');

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
-- Дублирующая структура для представления `quiz_detail`
--
CREATE TABLE IF NOT EXISTS `quiz_detail` (
`qr_id` int(11)
,`quiz_code` varchar(20)
,`teacher` varchar(80)
,`q_text` varchar(200)
,`q_id` int(11)
,`award_points` float
,`result` int(1)
,`user_resp` varchar(80)
,`fio` varchar(80)
,`finished_at` datetime
);

-- --------------------------------------------------------

--
-- Структура таблицы `quiz_results`
--

CREATE TABLE IF NOT EXISTS `quiz_results` (
  `qr_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `teacher` varchar(80) DEFAULT NULL,
  `stud_name` varchar(80) DEFAULT NULL,
  `user_score` float DEFAULT NULL,
  `pass_score` float DEFAULT NULL,
  `quiz_time` varchar(80) DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `stud_percent` float DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `quiz_results`
--

INSERT INTO `quiz_results` (`qr_id`, `quiz_id`, `teacher`, `stud_name`, `user_score`, `pass_score`, `quiz_time`, `finished_at`, `stud_percent`) VALUES
(1, 4, 'Seisembekova', 'ÐŸÑ€Ð¾Ð²ÐµÑ€ÐºÐ¸Ð½ Ð¢ÐµÑÑ‚', 33, 60, '27 sec', '2019-12-12 10:26:14', 39),
(2, 4, 'Seisembekova', 'Ð˜ÑÐ°ÐµÐ² ÐœÐ°ÐºÑÐ¸Ð¼', 38, 60, '30 sec', '2019-12-12 11:45:25', 45),
(3, 4, 'Zinatullina', 'Ð˜Ð²Ð°Ð½Ð¾Ð² ÐŸÐµÑ‚Ñ€ Ð¡Ð¸Ð´Ð¾Ñ€Ð¾Ð²Ð¸Ñ‡', 33, 60, '31 sec', '2019-12-13 11:31:00', 39),
(4, 4, 'Kaipov', 'Ð¢ÐµÑÑ‚Ð¾Ð² Ð¢ÐµÑÑ‚ÐµÑ€', 46, 60, '38 sec', '2019-12-13 12:02:38', 55),
(5, 4, 'Seisembekova', 'Ð¢ÐµÑÑ‚ÐµÑ€Ð¾Ð²', 34, 60, '25 sec', '2019-12-13 14:32:41', 40);

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
-- Структура для представления `all_quiz_res`
--
DROP TABLE IF EXISTS `all_quiz_res`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`all_quiz_res` AS select `q`.`quiz_name` AS `quiz_name`,`q`.`quiz_code` AS `quiz_code`,`qr`.`stud_name` AS `stud_name`,`qr`.`stud_percent` AS `stud_percent`,`qr`.`teacher` AS `teacher`,`qr`.`user_score` AS `user_score`,`qr`.`pass_score` AS `pass_score`,`qr`.`finished_at` AS `finished_at`,`qr`.`quiz_time` AS `quiz_time`,`qr`.`qr_id` AS `qr_id` from (`quizreports`.`quiz` `q` join `quizreports`.`quiz_results` `qr`) where (`q`.`quiz_id` = `qr`.`quiz_id`);

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
-- Структура для представления `quiz_detail`
--
DROP TABLE IF EXISTS `quiz_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`quiz_detail` AS select `qr`.`qr_id` AS `qr_id`,`q`.`quiz_code` AS `quiz_code`,`qr`.`teacher` AS `teacher`,`q`.`q_text` AS `q_text`,`q`.`q_id` AS `q_id`,`a`.`award_points` AS `award_points`,if((`a`.`award_points` > 0),1,0) AS `result`,`a`.`user_resp` AS `user_resp`,`qr`.`stud_name` AS `fio`,`qr`.`finished_at` AS `finished_at` from ((`quizreports`.`answers` `a` join `quizreports`.`question` `q`) join `quizreports`.`quiz_results` `qr`) where ((`a`.`qr_id` = `qr`.`qr_id`) and (`a`.`q_id` = `q`.`q_id`)) order by `q`.`quiz_code`,`qr`.`teacher`,`qr`.`stud_name`;

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
-- Индексы таблицы `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`qr_id`),
  ADD KEY `quiz_results_quiz_fk_1` (`quiz_id`);

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
  MODIFY `ans_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=236;
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
-- AUTO_INCREMENT для таблицы `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `qr_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
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
  ADD CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`q_id`) REFERENCES `question` (`q_id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `quiz_results_quiz_fk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`quiz_id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
