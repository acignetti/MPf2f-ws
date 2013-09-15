<?php

/**
 * Description of SalesDelegate
 *
 * @author Axel
 */
class SalesDelegate extends AbstractDelegate {

    protected function __construct() {
        parent::__construct();
    }

    public static function getInstance() {
        if (is_null(parent::$instance)) {
            parent::$instance = new UserDelegate();
        }
        return parent::$instance;
    }

    private function obtener_venta($id) {
        return array(
            "title" => "Barrilete multicolor",
            "quantity" => 1,
            "currency_id" => "ARS",
            "unit_price" => 10.00
        );
    }

    public function qr($id) {
        include __DIR__ . '/../../libs/qr/qrlib.php';
        ob_start();
        QRCode::png((string) $id);
        $image_string = base64_encode(ob_get_contents());
        ob_end_clean();
        return $image_string;
    }

    public function nfc($id) {
        
    }

    public function code($code) {
        
    }

}

?>
