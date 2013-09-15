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
    case OPERATION_USER_LOGIN: // iniciar sesion
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $username = get_url_var('username', '');
            $psw = get_url_var('password', '');
            $response = $delegate->login($username, $psw);
        }
        break;

    case OPERATION_USER_LOGOUT: // cerrar sesion
        $access = validate_sesion();
        if ($access->status && $access->session->user_id > -1) {
            $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
            if ($delegate) {
                $username = get_url_var('username', '');
                $session_key = get_url_var('session_key', '');
                $response = $delegate->logout($username, $session_key);
            }
        } else {
            http_response_code(403); // forbidden!
            $response = $access;
        }
        break;

    case OPERATION_USER_SESION_CHECK: // validar sesion
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_USER);
        if ($delegate) {
            $username = get_url_var('username', '');
            $session_key = get_url_var('session_key', '');
            $response = $delegate->session_check($username, $session_key);
        }
        break;

    // operaciones de ventas
    case OPERATION_SALES_CREATE:
        $access = validate_sesion(); // crear venta
        if ($access->status && $access->session->user_id > -1) {
            $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
            if ($delegate) {
                $description = get_url_var('description', '');
                $price = get_url_var('price', -1);
                $user_id = $access->session->user_id;
                $response = $delegate->create($user_id, $description, $price);
            }
        } else {
            http_response_code(403); // forbidden!
            $response = $access;
        }
        break;

    case OPERATION_SALES_GET:
        $access = validate_sesion(); // obtener los datos de una venta
        if ($access->status && $access->session->user_id > -1) {
            $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
            if ($delegate) {
                $id = get_url_var('id', -1);
                $user_id = $access->session->user_id;
                $response = $delegate->get($id, $user_id);
            }
        } else {
            http_response_code(403); // forbidden!
            $response = $access;
        }
        break;

    case OPERATION_SALES_QR: // generar un qr para una venta
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->qr($id);
        }
        break;

    case OPERATION_SALES_NFC: // generar la url de una venta para nfc
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->nfc($id);
        }
        break;

    case OPERATION_SALES_CODE:  // generar la url de una venta para un codigo
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_SALES);
        if ($delegate) {
            $id = get_url_var('code', -1);
            $response = $delegate->code($id);
        }
        break;

    // operaciones de mp
    case OPERATION_MP_CHECKOUT:  // devolver el init_point de MP
        $delegate = DelegateFactory::getDelegateFor(DELEGATE_MP);
        if ($delegate) {
            $id = get_url_var('id', -1);
            $response = $delegate->checkout($id);
        }
        break;

    case OPERATION_MP_IPN: // url para procesar un IPN
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