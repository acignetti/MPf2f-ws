
CREATE TABLE `MPF2F_user_session` (
  
  `user` varchar(100) NOT NULL ,
  `session_key` varchar(100) NOT NULL,
  `date_start` varchar(255) NOT NULL,
  `date_end` varchar(255) NOT NULL,
  `valid` boolean DEFAULT 1,
  PRIMARY KEY (`user`, `session_key`),
  INDEX `key_index` USING BTREE (`session_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;