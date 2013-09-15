
CREATE TABLE `MPF2F_sale` (
  
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT 0,
  `name` varchar(500) NOT NULL,
  `ammount` double NOT NULL,
  `date` date NOT NULL,  
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;