<?php

/**
 * Delegate para las operaciones de MercadoPago
 *
 * @author Axel
 */
class MercadoPagoDelegate extends AbstractDelegate {

    protected $MP = null;

    protected function __construct() {
        parent::__construct();
        include_once '../../libs/mercadopago/mercadopago.php';
        try {
            $MP = new MP(CLIENT_ID, CLIENT_SECRET);
        } catch (Exception $exc) {
            do_log($exc->getTraceAsString());
        }
    }

    public static function getInstance() {
        if (is_null(parent::$instance)) {
            parent::$instance = new MercadoPagoDelegate();
        }
        return parent::$instance;
    }

}

?>
