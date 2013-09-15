<?php

define('DEBUG', TRUE);
define('SANDBOX', TRUE);

define("MYSQL_HOST", 'localhost');
define("MYSQL_DB", 'MPF2F');
define("MYSQL_USER", 'root');
define("MYSQL_PWD", '');

define("MYSQL_DB_PREFIX", 'mpf2f_');

define('LOG_FILE_WS', 'ws.log');
define('LOG_FILE_IPN', 'ipn.log');

define('CLIENT_ID', '5688978878476133');
define('CLIENT_SECRET', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x');

// definicion de delegates
define('DELEGATE_USER', 'UserDelegate');
define('DELEGATE_MP', 'MercadoPagoDelegate');
define('DELEGATE_MYSQL', 'MySQLDelegate');
define('DELEGATE_SALES', 'SalesDelegate');

//definicion de operaciones
define('OPERATION_USER', 'user_');
define('OPERATION_MP', 'mp_');
define('OPERATION_SALES', 'sales_');

// operaciones relacionadas al usuario
define('OPERATION_USER_LOGIN', OPERATION_USER . 'login');
define('OPERATION_USER_LOGOUT', OPERATION_USER . 'logout');
define('OPERATION_USER_SESION_CHECK', OPERATION_USER . 'session_check');

// operaciones relacionadas a mp
define('OPERATION_MP_CHECKOUT', OPERATION_MP . 'checkout');
define('OPERATION_MP_IPN', OPERATION_MP . 'ipn');

// operaciones relacionadas a las ventas
define('OPERATION_SALES_CREATE', OPERATION_SALES . 'create');
define('OPERATION_SALES_GET', OPERATION_SALES . 'get');
define('OPERATION_SALES_QR', OPERATION_SALES . 'qr');
define('OPERATION_SALES_NFC', OPERATION_SALES . 'nfc');
define('OPERATION_SALES_CODE', OPERATION_SALES . 'code');
?>