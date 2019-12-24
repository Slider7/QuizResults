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
-- Структура таблицы `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `q_id` int(11) NOT NULL,
  `q_text` varchar(200) DEFAULT NULL,
  `corr_resp` varchar(80) NOT NULL,
  `quiz_code` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `Quiz` (
  `quiz_id` int(11) NOT NULL,
  `quiz_name` varchar(100) DEFAULT NULL,
  `quiz_code` varchar(30) NOT NULL,
  `Program` varchar(60) DEFAULT NULL,
  `Unit` varchar(60) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


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
-- Ограничения внешнего ключа таблицы `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`qr_id`) REFERENCES `quiz_results` (`qr_id`) ON UPDATE CASCADE;

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

INSERT INTO `Quiz` (`quiz_id`, `quiz_name`, `quiz_code`, `Program`, `Unit`) VALUES
(1, 'Sample Quiz Everest', 'Everest2', 'English Test', 'Unit1'),
(3, 'Everest Sample Quiz', 'Everest-1', 'English Test 1', 'Unit1'),
(4, 'FF1_Unit1', 'FF1_1', 'FF1', '1');


CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`all_quiz_res` AS select `q`.`quiz_name` AS `quiz_name`,`q`.`quiz_code` AS `quiz_code`,`qr`.`stud_name` AS `stud_name`,`qr`.`stud_percent` AS `stud_percent`,`qr`.`teacher` AS `teacher`,`qr`.`user_score` AS `user_score`,`qr`.`pass_score` AS `pass_score`,`qr`.`finished_at` AS `finished_at`,`qr`.`quiz_time` AS `quiz_time`,`qr`.`qr_id` AS `qr_id` from (`quizreports`.`quiz` `q` join `quizreports`.`quiz_results` `qr`) where (`q`.`quiz_id` = `qr`.`quiz_id`);

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`avg_points_quiz` AS select `all_quiz_res`.`quiz_code` AS `quiz_code`,avg(`all_quiz_res`.`stud_percent`) AS `avg(stud_percent)`,count(0) AS `qr_count` from `quizreports`.`all_quiz_res` group by `all_quiz_res`.`quiz_code`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`avg_points_teacher` AS select `all_quiz_res`.`teacher` AS `teacher`,avg(`all_quiz_res`.`stud_percent`) AS `avg(stud_percent)`,count(0) AS `qr_count` from `quizreports`.`all_quiz_res` group by `all_quiz_res`.`teacher`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quizreports`.`quiz_detail` AS select `qr`.`qr_id` AS `qr_id`,`q`.`quiz_code` AS `quiz_code`,`qr`.`teacher` AS `teacher`,`q`.`q_text` AS `q_text`,`q`.`q_id` AS `q_id`,`a`.`award_points` AS `award_points`,if((`a`.`award_points` > 0),1,0) AS `result`,`a`.`user_resp` AS `user_resp`,`qr`.`stud_name` AS `fio`,`qr`.`finished_at` AS `finished_at` from ((`quizreports`.`answers` `a` join `quizreports`.`question` `q`) join `quizreports`.`quiz_results` `qr`) where ((`a`.`qr_id` = `qr`.`qr_id`) and (`a`.`q_id` = `q`.`q_id`)) order by `q`.`quiz_code`,`qr`.`teacher`,`qr`.`stud_name`;

