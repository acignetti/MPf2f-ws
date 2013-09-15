<?php
//error_reporting(E_ALL);
//ini_set('display_errors', '1');

require_once './mercadopago.php';
//$mp = new MP('4131404305381903', '1r4iofJCGHwcwEuIcsoWIiATtkoOcM9y');
$mp = new MP('5688978878476133', 'gqsFGRTuDJ3o3hjacIac7sXTMMTvOS2x');
try {
    $payment_info = $mp->get_payment_info($_GET["id"]);
    $response = json_encode($payment_info);
} catch (Exception $exc) {
    http_response_code(500);
    die($exc->getMessage());
}

$external_reference = $response->response->collection->external_reference;
$status = $response->response->collection->status;
?>
