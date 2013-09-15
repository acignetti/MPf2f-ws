-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.5.27 - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             8.0.0.4420
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para mpf2f
DROP DATABASE IF EXISTS `mpf2f`;
CREATE DATABASE IF NOT EXISTS `mpf2f` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mpf2f`;


-- Volcando estructura para tabla mpf2f.mpf2f_deals
DROP TABLE IF EXISTS `mpf2f_deals`;
CREATE TABLE IF NOT EXISTS `mpf2f_deals` (
  `deal_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `price` double NOT NULL,
  `date` date NOT NULL,
  `lat` float NOT NULL,
  `lon` float NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`deal_id`),
  KEY `lat` (`lat`),
  KEY `lon` (`lon`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `mpf2f_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mpf2f.mpf2f_deals: ~6 rows (aproximadamente)
DELETE FROM `mpf2f_deals`;
/*!40000 ALTER TABLE `mpf2f_deals` DISABLE KEYS */;
INSERT INTO `mpf2f_deals` (`deal_id`, `title`, `description`, `price`, `date`, `lat`, `lon`, `id_usuario`) VALUES
	(1, 'oferta 1', 'texto oferta1', 123, '2013-09-15', -33.278, -66.3158, 1),
	(2, 'oferta 2', 'texto oferta2', 123, '2013-09-15', -33.278, -66.3158, 9),
	(3, 'oferta 3', 'texto oferta3', 123, '2013-09-15', -33.278, -66.3158, 3),
	(4, 'oferta 4', 'texto oferta4', 123, '2013-09-15', -33.278, -66.3158, 1),
	(5, 'oferta 5', 'texto oferta5', 123, '2013-09-15', -33.278, -66.3158, 9),
	(6, 'oferta 5', 'texto oferta6', 123, '2013-09-15', -33.278, -66.3158, 3);
/*!40000 ALTER TABLE `mpf2f_deals` ENABLE KEYS */;


-- Volcando estructura para tabla mpf2f.mpf2f_sale
DROP TABLE IF EXISTS `mpf2f_sale`;
CREATE TABLE IF NOT EXISTS `mpf2f_sale` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `status` varchar(15) DEFAULT 'pending',
  `name` varchar(500) NOT NULL,
  `ammount` double NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `userid_fk` (`user_id`),
  CONSTRAINT `mpf2f_sale_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `mpf2f_user` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mpf2f.mpf2f_sale: ~25 rows (aproximadamente)
DELETE FROM `mpf2f_sale`;
/*!40000 ALTER TABLE `mpf2f_sale` DISABLE KEYS */;
INSERT INTO `mpf2f_sale` (`sale_id`, `user_id`, `status`, `name`, `ammount`, `date`) VALUES
	(1, 1, 'approved', 'Silla', 102.2, '2013-09-15'),
	(3, 1, 'approved', 'Auto', 0, '2013-09-15'),
	(4, 1, 'cancelled', 'Bici', 0, '2013-09-15'),
	(5, 1, 'approved', 'Escritorio', 0, '2013-09-15'),
	(6, 1, 'pending', 'PC', 0, '2013-09-15'),
	(7, 1, 'approved', 'Speed', 0, '2013-09-15'),
	(8, 1, 'pending', 'Sanbuche', 0, '2013-09-15'),
	(9, 1, 'pending', 'Reloj', 0, '2013-09-15'),
	(10, 1, 'approved', 'Amarettos', 45, '2013-09-15'),
	(11, 1, 'rejected', 'Tapas', 34, '2013-09-15'),
	(12, 1, 'approved', 'Ratas', 123, '2013-09-15'),
	(13, 1, 'pending', 'Estrellas', 0, '2013-09-15'),
	(14, 1, 'approved', 'Decimal', 17, '2013-09-15'),
	(15, 1, 'in_process', 'Postrezuelo', 17.5, '2013-09-15'),
	(16, 1, 'pending', 'SLA - San Luis Analogico', 0, '2013-09-15'),
	(17, 1, 'approved', 'Teclado', 45, '2013-09-15'),
	(18, 1, 'pending', 'BOlsas', 45, '2013-09-15'),
	(19, 1, 'in_process', 'Edificio', 100, '2013-09-15'),
	(20, 1, 'rejected', 'Cartones', 100.5, '2013-09-15'),
	(22, 1, 'rejected', 'Cuadro Hola QUe tal', 123, '2013-09-15'),
	(24, 1, 'pending', 'Libro ofertas', 123, '2013-09-15'),
	(25, 9, 'pending', '12312', 123123213, '2013-09-15'),
	(26, 10, 'pending', 'erwin', 29.29, '2013-09-15'),
	(27, 9, 'pending', 'Papas', 25, '2013-09-15'),
	(28, 9, 'pending', 'camara', 123, '2013-09-15');
/*!40000 ALTER TABLE `mpf2f_sale` ENABLE KEYS */;


-- Volcando estructura para tabla mpf2f.mpf2f_user
DROP TABLE IF EXISTS `mpf2f_user`;
CREATE TABLE IF NOT EXISTS `mpf2f_user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mpf2f.mpf2f_user: ~6 rows (aproximadamente)
DELETE FROM `mpf2f_user`;
/*!40000 ALTER TABLE `mpf2f_user` DISABLE KEYS */;
INSERT INTO `mpf2f_user` (`user_id`, `user`, `pass`, `name`, `client_id`, `client_secret`, `token`) VALUES
	(1, 'axel', '123', 'Axel Coronel', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-4131404305381903-091511-da8e8dee682b21a75b30322e49c49752__M_H__-74905291'),
	(3, 'topolog', '123', 'Gabriel Topolog', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-5688978878476133-091512-2a2550c7cf901a1739777318ca1209f2__D_M__-144588053'),
	(9, 'agustin', '123', 'Agustin Cig', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-5688978878476133-091512-7eebcb04c56feadba19b2bb9f6867bd2__K_H__-144588053'),
	(10, 'erwin', '123', 'Werwin Baber', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-5688978878476133-091513-29c1ee2b74aecfff26e4eaefbee1cbe4__I_D__-144588053'),
	(13, 'julio', '123', 'Julio Groppa', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-5688978878476133-091513-d90721848d1e61937ce3c47c57943ac2__D_C__-144588053'),
	(14, 'test1', '123', 'Test 1', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-5688978878476133-091513-5a2a9837f74cb847c663af80bd0f58c5__K_M__-144588053'),
	(15, 'test2', '123', 'Test 2', '5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x', 'APP_USR-5688978878476133-091514-f443b28f665071ff5f8c51598db1964a__E_L__-144588053');
/*!40000 ALTER TABLE `mpf2f_user` ENABLE KEYS */;


-- Volcando estructura para tabla mpf2f.mpf2f_user_session
DROP TABLE IF EXISTS `mpf2f_user_session`;
CREATE TABLE IF NOT EXISTS `mpf2f_user_session` (
  `user` varchar(100) NOT NULL,
  `session_key` varchar(100) NOT NULL,
  `date_start` varchar(255) NOT NULL,
  `date_end` varchar(255) NOT NULL,
  `valid` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`user`,`session_key`),
  KEY `key_index` (`session_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mpf2f.mpf2f_user_session: ~211 rows (aproximadamente)
DELETE FROM `mpf2f_user_session`;
/*!40000 ALTER TABLE `mpf2f_user_session` DISABLE KEYS */;
INSERT INTO `mpf2f_user_session` (`user`, `session_key`, `date_start`, `date_end`, `valid`) VALUES
	('agustin', '097832ac38d471669ccb769290b63453', '2013-09-15 16:23:01', '2013-09-15 17:23:01', 1),
	('agustin', '0ce5f599365f5cab7987031c7f18947c', '2013-09-15 14:00:06', '2013-09-15 15:00:06', 1),
	('agustin', '66dab2f6f8ca3f0f77d7ba6a3a4542d9', '2013-09-15 14:06:30', '2013-09-15 15:06:30', 1),
	('agustin', '6db5ca00fa60394a6ce68e3f69aacd9e', '2013-09-15 14:43:57', '2013-09-15 15:43:57', 1),
	('agustin', 'a18b4e08650e63ce9847727bbaf4d232', '2013-09-15 16:20:22', '2013-09-15 17:20:22', 1),
	('Agustin', 'e9c857ee481c9cb956c5c96ee9beef40', '2013-09-15 14:48:09', '2013-09-15 15:48:09', 1),
	('axcoro', '07b3d829d09ea977451041c215747183', '2013-09-15 02:18:43', '2013-09-15 03:18:43', 1),
	('axcoro', '1c221f968db5a9b91117e4f87d20ffff', '2013-09-15 02:19:50', '2013-09-15 03:19:50', 0),
	('axcoro', '226e2c811900ebf95d6b4017a0dc1751', '2013-09-15 00:43:45', '2013-09-15 01:43:45', 1),
	('axcoro', '2881390b380bb29d0f190658e0177b5c', '2013-09-15 02:30:49', '2013-09-15 03:30:49', 1),
	('axcoro', '4c780e91f106289c532e5edb9e8309e4', '2013-09-15 02:11:18', '2013-09-15 03:11:18', 1),
	('axcoro', '6a2663196864333e7445283bb5ee1cda', '2013-09-15 02:21:14', '2013-09-15 03:21:14', 1),
	('axcoro', '881e844837002babdcd568118c240451', '2013-09-15 02:29:54', '2013-09-15 03:29:54', 1),
	('axcoro', '94446aa9d81ac285493965815cf9f049', '2013-09-15 00:43:40', '2013-09-15 01:43:40', 1),
	('axcoro', '944e64977882cd9856613113670a02df', '2013-09-15 02:19:34', '2013-09-15 03:19:34', 1),
	('axcoro', 'b777af0cd73ca436c14262f62f9530c5', '2013-09-15 02:11:21', '2013-09-15 03:11:21', 1),
	('axcoro', 'd4aa00c0254fb2950d060a82f22fba39', '2013-09-15 02:16:33', '2013-09-15 03:16:33', 1),
	('axcoro', 'e48b8b3e19843a887ecaf42d9ecd0dc9', '2013-09-15 02:13:39', '2013-09-15 03:13:39', 1),
	('axel', '0148388bf1285783db3ab125b1d5bd6a', '2013-09-15 10:45:43', '2013-09-15 11:45:43', 1),
	('axel', '027ce16f6c3e10be2fe83dc150f3d3fd', '2013-09-15 16:08:36', '2013-09-15 17:08:36', 1),
	('axel', '0c34bbeb204d01659b24123fc193a413', '2013-09-15 16:15:41', '2013-09-15 17:15:41', 1),
	('axel', '0f5ef40a3e1f9a710d89caf7b3602884', '2013-09-15 10:04:41', '2013-09-15 11:04:41', 1),
	('axel', '1173c18f0e9f64fb2ece05abc17735cf', '2013-09-15 16:07:40', '2013-09-15 17:07:40', 1),
	('axel', '122051f7cf9a18bcd758c00c575b1017', '2013-09-15 14:40:37', '2013-09-15 15:40:37', 1),
	('axel', '19ad0ced7202cb75045801b4c4e97ce0', '2013-09-15 15:21:04', '2013-09-15 16:21:04', 1),
	('axel', '1a91337bc2a192d25513605a8e929115', '2013-09-15 15:17:41', '2013-09-15 16:17:41', 1),
	('axel', '1c92ccede06190938da7e1ccb88fe5a4', '2013-09-15 06:19:32', '2013-09-15 07:19:32', 1),
	('axel', '29e67b7869d847a5489a3c7f9adbea4e', '2013-09-15 15:30:38', '2013-09-15 16:30:38', 1),
	('axel', '2b8e6edb813bb24c031e3152800e68eb', '2013-09-15 15:19:17', '2013-09-15 16:19:17', 1),
	('axel', '3744b2f2b8c287abb7daf3c3a554d5c7', '2013-09-15 15:41:14', '2013-09-15 16:41:14', 1),
	('axel', '3d345058c315ab56e8ff0b29dfc2bf51', '2013-09-15 13:05:52', '2013-09-15 14:05:52', 1),
	('axel', '42692c3cf24609a9b4e7334050131078', '2013-09-15 15:34:38', '2013-09-15 16:34:38', 1),
	('axel', '45e121a5be49e8674e2c0fa89263c119', '2013-09-15 06:19:03', '2013-09-15 07:19:03', 1),
	('axel', '4a53e73450f92e9c66c69c389e602d0c', '2013-09-15 05:56:35', '2013-09-15 06:56:35', 1),
	('axel', '4b5e32af0daef7acd5d9f4462f9a8caf', '2013-09-15 12:04:06', '2013-09-15 13:04:06', 1),
	('axel', '4cf1eb72a006af0eced93322318ac825', '2013-09-15 06:19:20', '2013-09-15 07:19:20', 1),
	('axel', '67043d99e46908f61733d28b43786e84', '2013-09-15 10:46:22', '2013-09-15 11:46:22', 1),
	('axel', '74a9e1350bd02e7ff6d4375f21fe3ff9', '2013-09-15 15:36:02', '2013-09-15 16:36:02', 1),
	('axel', '7d3c1b6d9f49962f015d7963fb88274a', '2013-09-15 13:01:18', '2013-09-15 14:01:18', 1),
	('axel', '84f5db5543fca016913259cd5193431a', '2013-09-15 15:44:31', '2013-09-15 16:44:31', 1),
	('axel', '88670e3c5c892ecef839e61bb4f3da7d', '2013-09-15 12:04:22', '2013-09-15 13:04:22', 1),
	('axel', '8b04eca390b38cc14da832391c3ca995', '2013-09-15 13:29:55', '2013-09-15 14:29:55', 1),
	('axel', '8b4a77dbd7f400e2efea378375388d69', '2013-09-15 16:06:21', '2013-09-15 17:06:21', 1),
	('axel', '8bea2285c38a055a05e1ddada021465c', '2013-09-15 06:21:25', '2013-09-15 07:21:25', 1),
	('axel', '93c0bee50a7bb3252fd73c86be85de71', '2013-09-15 15:32:12', '2013-09-15 16:32:12', 1),
	('axel', '97d4ab775896e5d6a72a8cd3abdfcb86', '2013-09-15 06:20:49', '2013-09-15 07:20:49', 1),
	('axel', '9a83dfb5528b6ccf2b21dea13cbe1868', '2013-09-15 15:35:04', '2013-09-15 16:35:04', 1),
	('axel', 'a006ef61e8bb31ef917d9fbeca582034', '2013-09-15 15:15:20', '2013-09-15 16:15:20', 1),
	('axel', 'af1069cc79b91fa34786e9f3e9748807', '2013-09-15 15:26:25', '2013-09-15 16:26:25', 1),
	('axel', 'bbaa6d99d541cc7c1138ce962d0c6666', '2013-09-15 15:17:57', '2013-09-15 16:17:57', 1),
	('axel', 'ca3fff5165159dee50e1e32f4353baca', '2013-09-15 15:56:20', '2013-09-15 16:56:20', 1),
	('axel', 'd4fc969caa01b14c597dc68be5729798', '2013-09-15 15:18:31', '2013-09-15 16:18:31', 1),
	('axel', 'd6847ad13b009bfc92ad90726d1a2e1c', '2013-09-15 15:44:53', '2013-09-15 16:44:53', 1),
	('axel', 'e075a53f1cd06165f2758eeac5040f34', '2013-09-15 06:32:38', '2013-09-15 07:32:38', 1),
	('axel', 'e4dbc155184edf2b50501ca29d2656d7', '2013-09-15 15:27:12', '2013-09-15 16:27:12', 1),
	('axel', 'ee2662370a6dab1dfc29b73c0a7c8e64', '2013-09-15 15:37:04', '2013-09-15 16:37:04', 1),
	('axel', 'f6f476b9a8711224a421b1224e242c33', '2013-09-15 06:06:40', '2013-09-15 07:06:40', 1),
	('erwin', '0685e392d6e6c7141f6ebf360db07436', '2013-09-15 14:49:14', '2013-09-15 15:49:14', 0),
	('erwin', '10c3e9cbcc974f238b4b02f72d4bc38d', '2013-09-15 14:27:50', '2013-09-15 15:27:50', 1),
	('erwin', '1c4410fe62e14abd385fc37f00ea78a4', '2013-09-15 15:56:20', '2013-09-15 16:56:20', 1),
	('erwin', '2325741c3837a29f6c5d0844d1938275', '2013-09-15 15:38:19', '2013-09-15 16:38:19', 1),
	('Erwin', '4aa501f9a6893c5911fdcb3e8ee3fc43', '2013-09-15 15:57:36', '2013-09-15 16:57:36', 1),
	('erwin', '60a42eb98fa5a97dd954a5a3a83dedbf', '2013-09-15 14:48:25', '2013-09-15 15:48:25', 1),
	('erwin', '64538491203aa8f7353ff8365656b64c', '2013-09-15 15:40:18', '2013-09-15 16:40:18', 1),
	('erwin', '7c32980e3b173ab4f1fe3ea5c19de3a6', '2013-09-15 15:14:21', '2013-09-15 16:14:21', 1),
	('erwin', '81a0da1bbec2f836552930a27854e42e', '2013-09-15 15:39:57', '2013-09-15 16:39:57', 1),
	('erwin', '898436d28c282b26bf32195112d35593', '2013-09-15 15:13:05', '2013-09-15 16:13:05', 1),
	('erwin', '8c129b8892a39bb5873164f5616badfb', '2013-09-15 15:37:25', '2013-09-15 16:37:25', 1),
	('Erwin', 'b05e2d7911631b51df919e7698a39ed3', '2013-09-15 16:05:04', '2013-09-15 17:05:04', 1),
	('Erwin', 'bc705632c7a845ea727d578768f13502', '2013-09-15 16:02:38', '2013-09-15 17:02:38', 1),
	('erwin', 'df15775c38218fd4cd6d274349eb2064', '2013-09-15 15:40:47', '2013-09-15 16:40:47', 1),
	('erwin', 'dfba5b33cfbac8adf31248d046ba0779', '2013-09-15 14:51:16', '2013-09-15 15:51:16', 0),
	('gggg', 'f8bf07a21a74ffb088176a0b11097c2e', '2013-09-15 14:02:09', '2013-09-15 15:02:09', 1),
	('tapita', 'ccf262efc278b697198e1e33dedfb18d', '2013-09-15 15:42:58', '2013-09-15 16:42:58', 1),
	('topo', '01e8c3aea8d9d15bf4a8023135614f1e', '2013-09-15 12:24:07', '2013-09-15 13:24:07', 1),
	('topo', '0aad1abb6fb88a95885707b538ca09c4', '2013-09-15 13:01:09', '2013-09-15 14:01:09', 1),
	('topo', '0b43a50928dfcdcae99ab3ab7a197dcd', '2013-09-15 13:15:32', '2013-09-15 14:15:32', 1),
	('topo', '0c40dc29f7cf455279d7a085bc28fa26', '2013-09-15 12:31:39', '2013-09-15 13:31:39', 1),
	('topo', '0d1fb45cbe0f484ed10df2b7230ea49b', '2013-09-15 00:12:21', '2013-09-15 01:12:21', 0),
	('topo', '10238133f11d271e4971d9044f2b4987', '2013-09-15 04:52:11', '2013-09-15 05:52:11', 1),
	('topo', '12f1a78013aec04078a904ef54b5256c', '2013-09-15 12:52:18', '2013-09-15 13:52:18', 1),
	('topo', '1347820f27fef6deb274d142a6f43022', '2013-09-15 12:07:29', '2013-09-15 13:07:29', 1),
	('topo', '14f94b3ddcf4929ae0a93d61a0643168', '2013-09-15 09:25:18', '2013-09-15 10:25:18', 1),
	('topo', '19faef698d42ed8895b39cf332fe67d4', '2013-09-15 10:43:46', '2013-09-15 11:43:46', 1),
	('topo', '1a9bb4b3726001dfa113799b60ed4c4d', '2013-09-15 12:16:56', '2013-09-15 13:16:56', 1),
	('topo', '225653e623ccb9782590432e01320fbe', '2013-09-15 10:01:47', '2013-09-15 11:01:47', 1),
	('topo', '27356eabcf29d9739c0212057126e7cf', '2013-09-15 07:18:04', '2013-09-15 08:18:04', 1),
	('topo', '27e41365388223cbe9940a8274ea48ef', '2013-09-15 12:03:17', '2013-09-15 13:03:17', 1),
	('topo', '27f03ab81444b8d3c5f78f3cf7f27e85', '2013-09-15 06:58:11', '2013-09-15 07:58:11', 1),
	('topo', '2b00618db09fd2169cc4f5fc4f462272', '2013-09-15 13:43:37', '2013-09-15 14:43:37', 1),
	('topo', '2b4835b1bd574c1d6ade3127a51c0d27', '2013-09-15 06:45:10', '2013-09-15 07:45:10', 1),
	('topo', '2d0fadf83eb47c0789df1ec4d23e28af', '2013-09-15 13:42:10', '2013-09-15 14:42:10', 1),
	('topo', '2d4527ec8bf143bb861ce76e6ee8b7b7', '2013-09-15 00:05:31', '2013-09-15 01:05:31', 0),
	('topo', '2dd577e467958908008758500ae8b716', '2013-09-15 13:48:30', '2013-09-15 14:48:30', 1),
	('topo', '2dd8c2173d77b03c1298bd86cd69a7f0', '2013-09-15 10:28:36', '2013-09-15 11:28:36', 1),
	('topo', '2ff015bee500c3dc473dd0c109e0d870', '2013-09-15 12:03:11', '2013-09-15 13:03:11', 1),
	('topo', '307ea25717e08a156ddca3501a79dc10', '2013-09-15 12:03:37', '2013-09-15 13:03:37', 1),
	('topo', '32848ed0d814f61a2a21be18e0200c6d', '2013-09-15 10:48:42', '2013-09-15 11:48:42', 1),
	('topo', '33096816dca17e39828856c9bce02ba5', '2013-09-15 09:26:28', '2013-09-15 10:26:28', 1),
	('topo', '363184307770fa0ae7dae08ee3ebdd0f', '2013-09-15 12:11:39', '2013-09-15 13:11:39', 1),
	('topo', '381abad2438502c00c112fd52303973a', '2013-09-15 13:01:04', '2013-09-15 14:01:04', 1),
	('topo', '38a1e799cfab888144665eb990cc3e5f', '2013-09-15 09:52:33', '2013-09-15 10:52:33', 1),
	('topo', '393f0a08e06db54c22861ca39d17eae0', '2013-09-15 13:10:41', '2013-09-15 14:10:41', 1),
	('topo', '39c4de6e3a1e22b4cc35b0aa11dab3a8', '2013-09-15 09:25:34', '2013-09-15 10:25:34', 1),
	('topo', '39e9466a43e693c78de0e6e4e95f9b31', '2013-09-15 13:11:16', '2013-09-15 14:11:16', 1),
	('topo', '3ac47f44c7efc5f8576f011902e000cd', '2013-09-15 04:56:11', '2013-09-15 05:56:11', 1),
	('topo', '3c13c9c5ea65c67c447fc78704d65eef', '2013-09-15 10:42:03', '2013-09-15 11:42:03', 1),
	('topo', '4173262858f958648fa64ab8cfa8d3bf', '2013-09-15 02:40:40', '2013-09-15 03:40:40', 1),
	('topo', '41c157cc3f24875ae7351a8414c5a72c', '2013-09-15 11:31:47', '2013-09-15 12:31:47', 1),
	('topo', '41d8710726729beae4c63d7ffb6508bf', '2013-09-15 13:17:51', '2013-09-15 14:17:51', 1),
	('topo', '44db0f5a2dbeda953888f76da066ad59', '2013-09-15 13:44:51', '2013-09-15 14:44:51', 1),
	('topo', '47d16222b34b72e608781050c4e328fd', '2013-09-15 09:33:51', '2013-09-15 10:33:51', 1),
	('topo', '480e1de98ec31cbeec856431e254f1ef', '2013-09-15 13:43:44', '2013-09-15 14:43:44', 1),
	('topo', '493c23431787a4eb8cf36e692b4f7ea1', '2013-09-15 03:21:33', '2013-09-15 04:21:33', 1),
	('topo', '4a34d07c84b91412203854f3f5e25c20', '2013-09-15 13:52:25', '2013-09-15 14:52:25', 1),
	('topo', '4a59db8d4359df5074b698a4195d656e', '2013-09-15 08:27:48', '2013-09-15 09:27:48', 1),
	('topo', '4bc03140ea9fcac8f480bfa5b352e485', '2013-09-15 02:36:41', '2013-09-15 03:36:41', 1),
	('topo', '4ccb7a4ed2540786553373f3190d463f', '2013-09-15 10:36:35', '2013-09-15 11:36:35', 1),
	('topo', '504eba07ab47eea8e036e12be8de8f78', '2013-09-15 10:07:27', '2013-09-15 11:07:27', 1),
	('topo', '5660d58e1e44c87c2d7da144f72bb6ac', '2013-09-15 10:05:49', '2013-09-15 11:05:49', 1),
	('topo', '567f05c6091c647a81273217aadb8ba6', '2013-09-15 02:20:30', '2013-09-15 03:20:30', 1),
	('topo', '59603cb873294d5819cd99dc09d99446', '2013-09-15 04:52:42', '2013-09-15 05:52:42', 1),
	('topo', '5b108d601b6cf05882ac0c5eb13e3ae2', '2013-09-15 04:51:31', '2013-09-15 05:51:31', 1),
	('topo', '5c626e1f2c494c47e5b4f691c3a52291', '2013-09-15 13:32:48', '2013-09-15 14:32:48', 1),
	('ToPo', '5d4167426f01cdbc129590b835e1ef21', '2013-09-15 08:28:10', '2013-09-15 09:28:10', 1),
	('topo', '6087ef27597a0f3c7f5f9b75941c9c41', '2013-09-15 02:33:37', '2013-09-15 03:33:37', 1),
	('topo', '6108d2073a422a94e0a16f6e1a53b769', '2013-09-15 04:55:52', '2013-09-15 05:55:52', 1),
	('topo', '6159e92507b852615097ee3ddac10a36', '2013-09-15 13:23:36', '2013-09-15 14:23:36', 1),
	('topo', '62ccfafebebf7058e7abe9c8d921c720', '2013-09-15 09:40:49', '2013-09-15 10:40:49', 1),
	('topo', '686bd20c7cefa41ea9a090e729174bcd', '2013-09-14 23:48:52', '2013-09-15 00:48:52', 1),
	('topo', '6ad073776b6907cff20182aadba0d25d', '2013-09-15 02:40:15', '2013-09-15 03:40:15', 1),
	('topo', '6b635c19f748f970eac3f14adbc15862', '2013-09-15 13:42:54', '2013-09-15 14:42:54', 1),
	('topo', '6ebbd1aab2a2bf20a2c707fae45cb431', '2013-09-15 13:25:05', '2013-09-15 14:25:05', 1),
	('topo', '6ef8a13af7c873491bdcfa476e697865', '2013-09-15 11:59:11', '2013-09-15 12:59:11', 1),
	('topo', '70d4022460a686343cab8f414e5185ff', '2013-09-15 12:12:46', '2013-09-15 13:12:46', 1),
	('topo', '727fc43ad0d622d5efdf1f16b2f23933', '2013-09-15 12:08:35', '2013-09-15 13:08:35', 1),
	('topo', '7326cce88d8ff46dba6e246ff0c105b8', '2013-09-15 13:23:17', '2013-09-15 14:23:17', 1),
	('topo', '755a4327631f0b04cb08ffb0944bd813', '2013-09-15 10:15:14', '2013-09-15 11:15:14', 1),
	('topo', '76c6dbb45180037546359a597dda9ee9', '2013-09-15 09:35:37', '2013-09-15 10:35:37', 1),
	('topo', '788a2d13e38fce6df84ebdb2fa946a41', '2013-09-15 13:30:56', '2013-09-15 14:30:56', 1),
	('topo', '78a5b55e36baa51506c129e6d9e990ef', '2013-09-15 12:55:48', '2013-09-15 13:55:48', 1),
	('topo', '792c2be15032de0534f3525cb1edf5fa', '2013-09-15 10:16:51', '2013-09-15 11:16:51', 1),
	('topo', '7a468351705394816b084764da6aea5b', '2013-09-15 12:55:41', '2013-09-15 13:55:41', 1),
	('topo', '7b1f9ced44d8598e1e6930332a357acf', '2013-09-15 12:04:00', '2013-09-15 13:04:00', 1),
	('topo', '80bbed20b704129232ba0b7dbd38ec6d', '2013-09-15 02:34:42', '2013-09-15 03:34:42', 1),
	('topo', '80ecd4ce67c557cfa1a7595d34648660', '2013-09-15 10:15:52', '2013-09-15 11:15:52', 1),
	('topo', '8543c2413859d12f7cb3d4ce0c1706b1', '2013-09-15 11:57:14', '2013-09-15 12:57:14', 1),
	('topo', '864edb7fa7be8e66aa8894f4674d633a', '2013-09-15 10:41:25', '2013-09-15 11:41:25', 1),
	('topo', '866933365a6f22fbb9f4164daaa4a36d', '2013-09-15 12:03:54', '2013-09-15 13:03:54', 1),
	('topo', '89c734929109581ff19ca6d70420be22', '2013-09-15 11:15:23', '2013-09-15 12:15:23', 1),
	('topo', '8b2ea3924a409411c6fe4bfdc954606f', '2013-09-15 02:36:51', '2013-09-15 03:36:51', 1),
	('topo', '8c9e854ce71f8f327d85b3ea9211512d', '2013-09-15 12:37:07', '2013-09-15 13:37:07', 1),
	('topo', '8d208ac4453feb608257ef74fb99d382', '2013-09-15 12:45:34', '2013-09-15 13:45:34', 1),
	('topo', '8d33da79156717a560df29145d5f2de3', '2013-09-15 11:21:22', '2013-09-15 12:21:22', 1),
	('topo', '8e2b1c2da8e331e38216a664c7a4560a', '2013-09-15 10:51:52', '2013-09-15 11:51:52', 1),
	('topo', '90c3dd7606a6171636cc683e7e0d1502', '2013-09-15 10:48:01', '2013-09-15 11:48:01', 1),
	('topo', '91b15363c3e7862cb18f96df3ac29216', '2013-09-15 11:24:28', '2013-09-15 12:24:28', 1),
	('topo', '924fcfb278da1f4acfb4227408a6939e', '2013-09-15 13:24:45', '2013-09-15 14:24:45', 1),
	('topo', '939d29e99e8535d055bfdfa4837fdc4b', '2013-09-15 11:23:03', '2013-09-15 12:23:03', 1),
	('topo', '94e9fade0ccb03d6e2c21fdbf9572822', '2013-09-15 09:33:23', '2013-09-15 10:33:23', 1),
	('topo', '97038ab61113881cacb03533036e6dbd', '2013-09-15 11:05:34', '2013-09-15 12:05:34', 1),
	('topo', '97afeb362b8fa775d7a9fb56c516052c', '2013-09-15 09:39:09', '2013-09-15 10:39:09', 1),
	('topo', '9962bb72c397ce20bc5db7500b37d9e3', '2013-09-15 02:38:59', '2013-09-15 03:38:59', 1),
	('topo', '997f0d6e1a803080351ad8f33cd7a997', '2013-09-15 09:39:56', '2013-09-15 10:39:56', 1),
	('topo', '9a9e6a0fb84ea79204559deeddece697', '2013-09-15 11:00:47', '2013-09-15 12:00:47', 1),
	('topo', '9c1732b2e10d1befa82e4660e3c512b8', '2013-09-15 12:55:50', '2013-09-15 13:55:50', 1),
	('topo', '9c1920f1a958d68df8f3ac3de4e1a7dc', '2013-09-15 13:11:14', '2013-09-15 14:11:14', 1),
	('topo', '9da6ad35ad483702fd3053bee5928afd', '2013-09-15 10:20:48', '2013-09-15 11:20:48', 1),
	('topo', '9e8eec66514f80c0d480fa8b76661d68', '2013-09-15 12:05:33', '2013-09-15 13:05:33', 1),
	('topo', '9f91b4d3e49f4b5f29eb40f72a93358e', '2013-09-15 10:01:02', '2013-09-15 11:01:02', 1),
	('topo', 'a108233c915d514c871b588bafba359a', '2013-09-15 12:55:23', '2013-09-15 13:55:23', 1),
	('topo', 'a1ccefe8f5f888487964c2574e36e47a', '2013-09-15 09:30:05', '2013-09-15 10:30:05', 1),
	('topo', 'a2f41bc8ed4baec2ef5661c3d5805ab6', '2013-09-15 12:46:13', '2013-09-15 13:46:13', 1),
	('topo', 'a3d737aa3c3756692226e8ee67b1a496', '2013-09-15 10:23:25', '2013-09-15 11:23:25', 1),
	('topo', 'a44bc9617b79699e782bd260fea4dab9', '2013-09-15 10:34:51', '2013-09-15 11:34:51', 1),
	('topo', 'a4ca607a23b3ed737946e2a9ea49c448', '2013-09-15 05:53:38', '2013-09-15 06:53:38', 1),
	('topo', 'a82ba2afd554f464edb9fa6ccf06757e', '2013-09-15 12:55:10', '2013-09-15 13:55:10', 1),
	('topo', 'b02ba4a6030e4e50e9cd30ad39433803', '2013-09-15 09:37:18', '2013-09-15 10:37:18', 1),
	('topo', 'b0f221ef3287808ee7617fd71f077407', '2013-09-15 09:39:10', '2013-09-15 10:39:10', 1),
	('topo', 'b0fc954ec70d26e641ddfcf74f7d34e1', '2013-09-15 10:19:47', '2013-09-15 11:19:47', 1),
	('topo', 'b2e66330105c841f00bc80d2b0bdb5fb', '2013-09-15 10:48:06', '2013-09-15 11:48:06', 1),
	('topo', 'b2e7f3c1002e4a0ee66e2143d6d9be0d', '2013-09-15 13:20:50', '2013-09-15 14:20:50', 1),
	('topo', 'b47728425837f3549fd5be12e4b89dd2', '2013-09-15 13:23:50', '2013-09-15 14:23:50', 1),
	('topo', 'b48870c31410762e0f2c133dfe1335c2', '2013-09-15 13:38:53', '2013-09-15 14:38:53', 1),
	('topo', 'b8cbd52e8551bb32966dbd9d14a5f599', '2013-09-15 03:37:02', '2013-09-15 04:37:02', 1),
	('topo', 'bc9a5246c7ed132c087fcddb696f7333', '2013-09-15 02:33:36', '2013-09-15 03:33:36', 1),
	('topo', 'bd246ce00ed6aacda701bb88608bf61a', '2013-09-15 10:55:20', '2013-09-15 11:55:20', 1),
	('topo', 'bd9a3c174cead53e1e7d34ad230d0c75', '2013-09-15 12:36:28', '2013-09-15 13:36:28', 1),
	('topo', 'bda7d678dd1113590d4cbdcf8f516cc9', '2013-09-15 10:50:58', '2013-09-15 11:50:58', 1),
	('topo', 'bfe767399092ce8c8fffb25679a997f4', '2013-09-15 09:46:02', '2013-09-15 10:46:02', 1),
	('topo', 'c0300b87aeb7daa683c02f8112539806', '2013-09-15 10:43:55', '2013-09-15 11:43:55', 1),
	('topo', 'c10a973d3a3accd716f969bc5133f129', '2013-09-15 09:47:01', '2013-09-15 10:47:01', 1),
	('topo', 'c23f5d3d51ac302f2b792bcc543566ba', '2013-09-15 11:37:30', '2013-09-15 12:37:30', 1),
	('topo', 'c3505b9bc0824b37d81271ae3b3f6909', '2013-09-15 02:38:23', '2013-09-15 03:38:23', 1),
	('Topo', 'c71b3f348e78cbb93f23d55b5ebd09bb', '2013-09-15 07:31:41', '2013-09-15 08:31:41', 1),
	('topo', 'c984eae6d6e7cd3d42f1345f3fdeddd6', '2013-09-15 10:42:37', '2013-09-15 11:42:37', 1),
	('topo', 'c9d1b052279854644e87c5448fa24de2', '2013-09-15 03:37:03', '2013-09-15 04:37:03', 1),
	('topo', 'ca4dfa3a25da74c85e24203cb8d6cfaf', '2013-09-15 13:24:02', '2013-09-15 14:24:02', 1),
	('topo', 'ca6458fb46d0cb964848c4054624bade', '2013-09-15 12:13:49', '2013-09-15 13:13:49', 1),
	('topo', 'cdae0854f5a534462aa662f00c72f619', '2013-09-15 04:51:32', '2013-09-15 05:51:32', 1),
	('topo', 'd03eac3541abb281326c8f5b682fcb91', '2013-09-15 10:53:08', '2013-09-15 11:53:08', 1),
	('topo', 'd3be2f83ee6e11bb87c4b2f5f307adef', '2013-09-15 09:50:37', '2013-09-15 10:50:37', 1),
	('topo', 'd449e9d5a370948a94d944b2b77ff91d', '2013-09-15 13:12:20', '2013-09-15 14:12:20', 1),
	('topo', 'd4e378236e9e757f21fab1ae6e65f220', '2013-09-15 12:05:50', '2013-09-15 13:05:50', 1),
	('topo', 'd771a92e16703785253d2ebc45806db1', '2013-09-15 10:19:40', '2013-09-15 11:19:40', 1),
	('topo', 'd7d36ed3a08030255d4ae578c15bd742', '2013-09-15 13:29:52', '2013-09-15 14:29:52', 1),
	('topo', 'd92418acca3e57e28f1456eacb8ac694', '2013-09-15 13:23:39', '2013-09-15 14:23:39', 1),
	('topo', 'd9836a99ea99ab25a9ab78547f3882a6', '2013-09-15 10:00:09', '2013-09-15 11:00:09', 1),
	('topo', 'dac66283556d9ca4fdf0ecd4d1025afe', '2013-09-15 10:18:13', '2013-09-15 11:18:13', 1),
	('topo', 'db27f762817215dcc31ca1842d42f28f', '2013-09-15 13:35:56', '2013-09-15 14:35:56', 1),
	('topo', 'dc3977cd8be7fa6089160b1208a0d237', '2013-09-15 13:04:51', '2013-09-15 14:04:51', 1),
	('topo', 'dd3f4f2897f6ce2cb29e5a9a39a003bb', '2013-09-15 11:32:10', '2013-09-15 12:32:10', 1),
	('topo', 'de42a7ce226c44f449c4cde4584a676a', '2013-09-15 08:17:54', '2013-09-15 09:17:54', 1),
	('topo', 'dea09948325ef9c7b95e1be624e8e983', '2013-09-15 08:27:09', '2013-09-15 09:27:09', 1),
	('topo', 'df0ffc696967b13ac8985376a01fcf8f', '2013-09-15 13:58:07', '2013-09-15 14:58:07', 1),
	('topo', 'e2356cba8af619b4ee28eaa793de971f', '2013-09-15 04:57:00', '2013-09-15 05:57:00', 1),
	('topo', 'e3b7f15e91820875f607ed2a4a073ed8', '2013-09-15 03:27:26', '2013-09-15 04:27:26', 1),
	('topo', 'e7635c81d7066c96e1634c6aea6ad1ba', '2013-09-15 05:45:29', '2013-09-15 06:45:29', 1),
	('topo', 'e764344b3553d27051fea2ce288df8ca', '2013-09-15 10:47:16', '2013-09-15 11:47:16', 1),
	('topo', 'ecf2e7c4fb95e25503eb59bb8d3d18e4', '2013-09-15 11:59:52', '2013-09-15 12:59:52', 1),
	('topo', 'ee773d889fccdd9f10b3a041b82412e5', '2013-09-15 10:12:02', '2013-09-15 11:12:02', 1),
	('topo', 'ef1892a9bc124f0af3956078f9be4208', '2013-09-15 09:47:33', '2013-09-15 10:47:33', 1),
	('topo', 'efee9707168b97eed18e4662c4bb36d0', '2013-09-15 13:22:21', '2013-09-15 14:22:21', 1),
	('topo', 'f021d8cc67a2bfd1af07fd11eff33776', '2013-09-15 12:03:57', '2013-09-15 13:03:57', 1),
	('topo', 'f2cf3415f6d3106abd27a2f2ea649ef0', '2013-09-15 13:16:00', '2013-09-15 14:16:00', 1),
	('topo', 'f31ece5ab8ef46cea0a8c5fc343239b0', '2013-09-15 12:31:40', '2013-09-15 13:31:40', 1),
	('topo', 'f57182ce2c866c13d0c6775949ec9919', '2013-09-15 08:08:29', '2013-09-15 09:08:29', 1),
	('topo', 'f5a7c331a41da56848fcc787bb648044', '2013-09-15 06:59:22', '2013-09-15 07:59:22', 1),
	('topo', 'f6648eea773897214b97d9b88847acca', '2013-09-15 10:32:24', '2013-09-15 11:32:24', 1),
	('topo', 'fa920502b762688494a541b6768305ca', '2013-09-15 11:33:59', '2013-09-15 12:33:59', 1),
	('topo', 'fb368c747e5ca3e661ea0bf834f8a9f0', '2013-09-15 05:34:53', '2013-09-15 06:34:53', 1),
	('topo', 'fb3e44b00e5c227ab1476f628b9fd13a', '2013-09-15 12:52:32', '2013-09-15 13:52:32', 1),
	('topo', 'fb9a09b661727d9a85e5c7a9aa3c3f21', '2013-09-15 00:12:57', '2013-09-15 05:12:57', 1),
	('topo', 'fd1ec5d9c5c7747d41dbbba62075f101', '2013-09-15 10:45:41', '2013-09-15 11:45:41', 1),
	('topo', 'fd571d3e25731a99467310c1c9c18557', '2013-09-15 12:03:05', '2013-09-15 13:03:05', 1),
	('topo', 'ffd605bbbc04d065248f0fa98b3cb779', '2013-09-15 10:50:11', '2013-09-15 11:50:11', 1),
	('topolog', '16db3e5b431dcc9d05030066d435c7c7', '2013-09-15 14:23:13', '2013-09-15 15:23:13', 1),
	('topolog', '3884df5b5836ce3e094ca53513ed1cb7', '2013-09-15 14:48:17', '2013-09-15 15:48:17', 1),
	('topolog', '423bb58e3950af7235c234f1c547b02b', '2013-09-15 14:46:38', '2013-09-15 15:46:38', 1),
	('topolog', '4ae533b03cccf6e050a79d88229f5f3f', '2013-09-15 14:19:58', '2013-09-15 15:19:58', 1);
/*!40000 ALTER TABLE `mpf2f_user_session` ENABLE KEYS */;


-- Volcando estructura para procedimiento mpf2f.MPF2F_DealGet
DROP PROCEDURE IF EXISTS `MPF2F_DealGet`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MPF2F_DealGet`(

/*
===================================================
 Nombre: MPF2F_DealGet
 Descripcion: Obtiene los datos de una oferta por el id
 Comentarios: 
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
IN _id INT
)
BEGIN

select * from MPF2F_deals d where d.deal_id = _id;

END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_DealsNearBy
DROP PROCEDURE IF EXISTS `MPF2F_DealsNearBy`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MPF2F_DealsNearBy`(

/*
===================================================
 Nombre: MPF2F_DealsNearBy
 Descripcion: Obtiene ofertas cerca al usuario dadas sus coordenadas gps
 Comentarios: 
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
IN _lat FLOAT,
IN _lon FLOAT,
IN _min_dist FLOAT
)
BEGIN

SELECT d.*, 
 (3959 * ACOS(COS(RADIANS(_lat)) 
 * COS(RADIANS(d.lat)) 
 * COS(RADIANS(d.lon) 
 - RADIANS(_lon)) 
 + SIN(RADIANS(_lat)) 
 * SIN(RADIANS(d.lat)) 
)
) AS dist
FROM MPF2F_deals d
HAVING dist < _min_dist
ORDER BY dist
LIMIT 0, 20;

END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_GetSaleUser
DROP PROCEDURE IF EXISTS `MPF2F_GetSaleUser`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MPF2F_GetSaleUser`(

/*
===================================================
 Nombre: MPF2F_GetSaleUser
 Descripción: Devuelve las credenciales de un usuario dado el id de una venta
 Comentarios:
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
_sale_id int
)
BEGIN
	
SELECT u.client_id, u.client_secret, u.token
FROM MPF2F_user u
INNER JOIN MPF2F_sale s on s.user_id = u.user_id
WHERE s.sale_id = _user_id;


END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_GetUserCredentials
DROP PROCEDURE IF EXISTS `MPF2F_GetUserCredentials`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MPF2F_GetUserCredentials`(

/*
===================================================
 Nombre: MPF2F_GetUserCredentials
 Descripción: Devuelve las credenciales de un usuario dado el id
 Comentarios:
 Autores: Coronel, Axel
 Audit Trail:
===================================================
*/
_user_id int
)
BEGIN
	
SELECT u.client_id, u.client_secret, u.token
FROM MPF2F_user u
WHERE u.user_id = _user_id; 


END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_SaleGet
DROP PROCEDURE IF EXISTS `MPF2F_SaleGet`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MPF2F_SaleGet`(

	/*
	===================================================
	 Nombre: MPF2F_SaleGet
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail: Coronel, Axel: fix nombre columna
	===================================================
	*/

	  _sale_id int,
	 _user_id int
	)
BEGIN
		
		SELECT * FROM MPF2F_sale WHERE sale_id = _sale_id and user_id = _user_id;
		


	END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_SaleList
DROP PROCEDURE IF EXISTS `MPF2F_SaleList`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_SaleList`(

	/*
	===================================================
	 Nombre: MPF2F_SaleList
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/
	 _user_id int,
	 _status varchar(15),
	 _start int,
	 _limit int


	)
BEGIN
		
		SELECT * FROM MPF2F_sale WHERE user_id = _user_id AND status = _status ORDER BY date desc limit _start, _limit ;
		


	END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_SaleNew
DROP PROCEDURE IF EXISTS `MPF2F_SaleNew`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_SaleNew`(

	/*
	===================================================
	 Nombre: MPF2F_SaleNew
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/
	  _user_id int,
	  _name varchar(500),
	  _ammount double

	  
	)
BEGIN
		
		
		INSERT INTO MPF2F_sale(user_id, name, ammount, date) VALUES(_user_id, _name, _ammount, now());

		SELECT @@identity as sale_id;


	END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_SaleUpdateStatus
DROP PROCEDURE IF EXISTS `MPF2F_SaleUpdateStatus`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_SaleUpdateStatus`(

	/*
	===================================================
	 Nombre: MPF2F_SaleUpdateStatus
	 Descripción: 
	 Comentarios:
	 Autores: Cavecedo, Gabriel A.
	 Audit Trail:
	===================================================
	*/

	  _sale_id int,
	  _status varchar(15)
	  
	)
BEGIN
		
		UPDATE MPF2F_sale SET status = _status WHERE sale_id = _sale_id;
		
		SELECT ROW_COUNT() as success;

	END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_UserGet
DROP PROCEDURE IF EXISTS `MPF2F_UserGet`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_UserGet`(

/*
===================================================
 Nombre: MPF2F_UserGet
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100)
)
BEGIN
	
	
	SELECT *
	    FROM MPF2F_user
	    WHERE user = _user;


END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_UserSessionCheck
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionCheck`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_UserSessionCheck`(

/*
===================================================
 Nombre: MPF2F_UserSessionCheck
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100),
_session_key VARCHAR(100)
)
BEGIN

DECLARE _user_id int DEFAULT -1;

SELECT user_id INTO _user_id FROM MPF2F_user WHERE user = _user;

IF _user_id > -1 THEN
	
	SELECT *, _user_id as user_id
		FROM MPF2F_user_session
		WHERE user = _user AND session_key = _session_key
			AND  date_end >= now() AND valid = 1 LIMIT 1;
END IF;


END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_UserSessionDestroy
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionDestroy`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_UserSessionDestroy`(

/*
===================================================
 Nombre: MPF2F_UserSessionDestroy
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100),
_session_key VARCHAR(100)
)
BEGIN

	UPDATE MPF2F_user_session SET valid = 0 WHERE user = _user AND session_key = _session_key;



END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_UserSessionLogin
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionLogin`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_UserSessionLogin`(

/*
===================================================
 Nombre: MPF2F_UserSessionLogin
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail: Coronel, Axel: agregado el id del usuario en el select
===================================================
*/
_user VARCHAR(100),
_pass VARCHAR(100)
)
BEGIN
	
	DECLARE userSelect VARCHAR(100) DEFAULT '';
	DECLARE secret VARCHAR(100) DEFAULT '';
	DECLARE uname VARCHAR(100) DEFAULT '';
	DECLARE uid INT DEFAULT -1;


	SELECT user_id, user,name into uid, userSelect,uname
	    FROM MPF2F_user
	    WHERE user = _user AND pass = _pass;

	IF userSelect = _user THEN
	    
	    SET @secret = MD5(CONCAT(_user, _pass, now()));
	    INSERT INTO MPF2F_user_session(user,
	                             session_key,
	                             date_start,
	                             date_end,
	                             valid)
	                               VALUES(_user,
	                                      @secret,
	                                      now(),
	                                      DATE_ADD(now(), INTERVAL 60 MINUTE),
	                                      1);

	END IF;

	SELECT uid,uname as name, us.* FROM MPF2F_user_session us WHERE user = _user AND session_key = @secret;
	

END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_UserSessionStart
DROP PROCEDURE IF EXISTS `MPF2F_UserSessionStart`;
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `MPF2F_UserSessionStart`(

/*
===================================================
 Nombre: MPF2F_UserSessionStart
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail:
===================================================
*/
_user VARCHAR(100),
_pass VARCHAR(100)
)
BEGIN
	
	DECLARE userSelect VARCHAR(100) DEFAULT '';
	DECLARE secret VARCHAR(100) DEFAULT '';

	SELECT user into userSelect 
	    FROM MPF2F_user
	    WHERE user = _user AND pass = _pass;

	IF userSelect = _user THEN
	    
	    SET @secret = MD5(CONCAT(_user, _pass, now()));
	    INSERT INTO MPF2F_user_session(user,
	                             session_key,
	                             date_start,
	                             date_end,
	                             valid)
	                               VALUES(_user,
	                                      @secret,
	                                      now(),
	                                      DATE_ADD(now(), INTERVAL 60 MINUTE),
	                                      1);

	END IF;

	SELECT * FROM MPF2F_user_session WHERE user = _user AND session_key = @secret;
	

END//
DELIMITER ;


-- Volcando estructura para procedimiento mpf2f.MPF2F_UserSignUp
DROP PROCEDURE IF EXISTS `MPF2F_UserSignUp`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `MPF2F_UserSignUp`(

/*
===================================================
 Nombre: MPF2F_UserSignUp
 Descripción: 
 Comentarios:
 Autores: Cavecedo, Gabriel A.
 Audit Trail: Coronel, Axel: Agregado SELECT @@IDENTITY;
===================================================
*/
_user varchar(100) ,
_pass varchar(100) ,
_name varchar(255),
_client_id varchar(50) ,
_client_secret varchar(50),
_token varchar(100)
)
BEGIN
	
	INSERT INTO MPF2F_user(user, pass, name, client_id, client_secret, token)
	   VALUES(_user, _pass, _name, _client_id, _client_secret, _token);

SELECT @@IDENTITY as user_id;

END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
