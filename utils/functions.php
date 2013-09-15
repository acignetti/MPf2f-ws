<?php
/**
 * Devuelve un parametro
 * @param String $param nombre del parametro a obtener
 * @param mixed $default valor por defecto en caso de no estar definido el parametro
 * @return mixed devuelve el parametro o el valor por defecto
 */
function get_url_var($param, $default = null) {
    $val = $default;

    if (DEBUG && isset($_GET[$param]))
        $val = $_GET[$param];

    if (isset($_POST[$param]))
        $val = $_POST[$param];

    return $val;
}

/**
 * defino http_response_code para versiones viejas de php
 */
if (!function_exists('http_response_code')) {

    function http_response_code($newcode = NULL) {
        static $code = 200;
        if ($newcode !== NULL) {
            header('X-PHP-Response-Code: ' . $newcode, true, $newcode);
            if (!headers_sent())
                $code = $newcode;
        }
        return $code;
    }

}

/**
 * Realiza un log a archivo
 * 
 * @param String $msg texto a agregar al log
 * @param String $file archivo a generar el log
 */
function do_log($msg, $file = LOG_FILE_WS) {
    $current = file_get_contents($file);
    if ($current !== FALSE) {
        $current .= $msg . PHP_EOL;
        file_put_contents($file, $current);
    }
}

?>
