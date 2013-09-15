CREATE TABLE `mpf2f_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) NOT NULL,
  `pass` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `client_id` varchar(50) NOT NULL,
  `client_secret` varchar(50) NOT NULL,
  `token` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user` (`user`),
  KEY `user_index` (`user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;