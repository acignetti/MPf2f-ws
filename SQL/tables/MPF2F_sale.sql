
CREATE TABLE `MPF2F_sale` (
  
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `status` VARCHAR(15) DEFAULT 'pending',
  `name` varchar(500) NOT NULL,
  `ammount` double NOT NULL,
  `date` date NOT NULL,
FOREIGN KEY `userid_fk` (`user_id` ) REFERENCES MPF2F_user(`user_id` ) ON DELETE CASCADE ON UPDATE NO ACTION,
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;