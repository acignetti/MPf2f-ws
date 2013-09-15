<?php
/**
 * operaciones.php
 * 
 * Punto de entrada para las operaciones del ws
 */
include './utils/config.conf.inc';
include './utils/functions.php';

$operacion = get_url_var('operacion', '');

// respuesta por defecto
$response = null;
switch ($operacion) {
    case "a":

        break;

    default: // 
        $response = new stdClass();
        $response->response = "Operacion $operacion no definida..";
        break;
}
header('Content-type: application/json');
echo json_encode($response);
?>