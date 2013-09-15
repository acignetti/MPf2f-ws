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
// contemplar jsonp
$callback = get_url_var('callback', FALSE);

// respuesta por defecto
$response = new stdClass();
switch ($operacion) {
    // operaciones de usuario
    case OPERATION_USER_LOGIN:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $username = get_url_var('username', '');
            $psw = get_url_var('password', '');
            $response = $delegate->login($username, $psw);
        }
        break;

    case OPERATION_USER_LOGOUT:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $username = get_url_var('username', '');
            $session_key = get_url_var('session_key', '');
            $response = $delegate->logout($username, $session_key);
        }
        break;

    case OPERATION_USER_SESION_CHECK:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $username = get_url_var('username', '');
            $session_key = get_url_var('session_key', '');
            $response = $delegate->session_check($username, $session_key);
        }
        break;

    // operaciones de ventas
    case OPERATION_SALES_CREATE:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $description = get_url_var('description', '');
            $price = get_url_var('price', -1);
            $response = $delegate->create($description, $price);
        }
        break;

    case OPERATION_SALES_GET:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->get($id);
        }
        break;

    case OPERATION_SALES_QR:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->qr($id);
        }
        break;

    case OPERATION_SALES_NFC:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->nfc($id);
        }
        break;

    case OPERATION_SALES_CODE:
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('code', -1);
            $response = $delegate->code($id);
        }
        break;

    // operaciones de mp
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

    // respuesta por defecto
    default:
        $response->response = "Operacion $operacion no definida..";
        break;
}
if ($callback) { // jsonp
    header('Content-type: application/javascript');
    echo "$callback('" . json_encode($response) . "');";
} else { // json
    header('Content-type: application/json');
    echo json_encode($response);
}
?>