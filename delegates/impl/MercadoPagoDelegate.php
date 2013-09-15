<?php

/**
 * Delegate para las operaciones de MercadoPago
 *
 * @author Axel
 */
class MercadoPagoDelegate extends AbstractDelegate {

    protected $mp = null;

    protected function __construct() {
        parent::__construct();
        include_once __DIR__ . '/../../libs/mercadopago/mercadopago.php';
        try {
            $this->mp = new MP(CLIENT_ID, CLIENT_SECRET);
            if (SANDBOX)
                $this->mp->sandbox_mode(SANDBOX);
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

    private function process_ipn($payment_info) {
        http_response_code(200); // http_response_code(201);
        $payment_info_json = json_encode($payment_info);
//        $external_reference = $payment_info_json->response->collection->external_reference;
//        $status = $payment_info_json->response->collection->status;
        return 'OK';
    }

    /**
     * 
     * @param type $id
     */
    public function ipn($id) {
        $response = new stdClass();
        $response->response = '';
        try {
            $payment_info = $this->mp->get_payment_info($id);
            $response->response = $this->process_ipn($payment_info);
        } catch (Exception $exc) {
            http_response_code(500);
            $response->response = $exc->getMessage();
        }
        return $response;
    }

    /**
     * Crea el punto de entrada para el checkout de MP
     * @param type $id 
     * @return \stdClass el [sand]init_pi
     */
    public function checkout($id) {
        $preference_data = array(
            "items" => array(
                array(
                    "title" => "Barrilete multicolor",
                    "quantity" => 1,
                    "currency_id" => "ARS",
                    "unit_price" => 10.00
                )
            )
        );


        $preference = $this->mp->create_preference($preference_data);
        $response = new stdClass();

        if ($this->mp->sandbox_mode())
            $response->init_point = $preference['response']['sandbox_init_point'];
        else
            $response->init_point = $preference['response']['init_point'];

        return $response;
    }

}

?>
