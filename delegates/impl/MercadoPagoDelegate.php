<?php

/**
 * Delegate para las operaciones de MercadoPago
 *
 * @author Axel
 */
class MercadoPagoDelegate extends AbstractDelegate {

    protected $mp = FALSE;

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

    /**
     * Procesa la notificacion entrante por parte de MP
     * @param String (json) $payment_info
     * @return \stdClass
     */
    private function process_ipn($payment_info) {
        http_response_code(200); // http_response_code(201);
        $payment_info_json = json_encode($payment_info);
        $response = new stdClass();
        $response->external_reference = $payment_info_json->response->collection->external_reference;
        $response->status = $payment_info_json->response->collection->status;
        return $response;
    }

    /**
     * procesa un IPN
     * @param type $id
     */
    public function ipn($id) {
        $response = new stdClass();
        try {
            $payment_info = $this->mp->get_payment_info($id);
            $response->response = $this->process_ipn($payment_info);
        } catch (Exception $exc) {
            // en caso de error, se devuelve 500 para que MP lo tome como error y reintente los IPN
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
    public function checkout($id = -1) {
        $response = new stdClass();
        $response->status = false;
        $preference_data = null;
        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);
        $item = FALSE;
        if ($db) {
            try {
                $result = $db->SaleGet($id);
                if ($result && $result->num_rows > 0) {
                    $item = $result->fetch_object();
                }
            } catch (Exception $exc) {
                
            }
        }
        if ($item) {
            $preference_data = array(
                "items" => array(
                    array(
                        "title" => $item->name,
                        "quantity" => 1,
                        "currency_id" => "ARS",
                        "unit_price" => (int) $item->ammount
                    )
                )
            );
        }
        try {

            if ($this->mp) { // se pudo inicializar MP?
                // crear el preference de la venta
                $preference = $this->mp->create_preference($preference_data);
                if ($this->mp->sandbox_mode()) // sanbox?
                    $response->init_point = $preference['response']['sandbox_init_point'];
                else
                    $response->init_point = $preference['response']['init_point'];

                $response->status = true;
            }
            else {
                $response->error = "Ocurrio un error al procesar el checkout";
            }
        } catch (Exception $exc) {
            $response->error = $exc->getTraceAsString();
        }

        return $response;
    }

}

?>
