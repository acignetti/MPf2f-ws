<?php

/**
 * operaciones.php
 * 
 * Punto de entrada para las operaciones del ws
 */
include './utils/config.conf.inc';
include './utils/functions.php';

include './delegates/DelegateFactory.php';

$operacion = get_url_var('operacion', '');

// respuesta por defecto
$response = new stdClass();
$delegate = null;
switch ($operacion) {
    case OPERATION_USER_LOGIN:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $username = get_url_var('username', '');
            $psw = get_url_var('passwrod', '');
            $response = $delegate->login($username, $psw);
        }
        break;

    case OPERATION_USER_LOGOUT:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $token = get_url_var('token', '');
            $response = $delegate->logout($token);
        }
        break;

    case OPERATION_MP_CHECKOUT:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_MP);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->checkout($id);
        }
        break;

        case OPERATION_MP_IPN:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_MP);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->ipn($id);
        }
        break;

    default: // respuesta por defecto
        $response = new stdClass();
        $response->response = "Operacion $operacion no definida..";
        break;
}
header('Content-type: application/json');
echo json_encode($response);
?>