
CREATE TABLE `MPF2F_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(100) NOT NULL UNIQUE,
  `pass` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `user_index` USING BTREE (`user`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;