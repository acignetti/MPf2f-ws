CREATE TABLE `MPF2F_deals` (
  `deal_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `price` double NOT NULL,
  `date` date NOT NULL,
  `lat` float NOT NULL,
  `lon` float NOT NULL,
  PRIMARY KEY (`deal_id`),
  INDEX `lat` (`lat`),
  INDEX `lon` (`lon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;