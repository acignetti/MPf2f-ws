<?php

/**
 * Delegate para las operaciones de MercadoPago
 *
 * @author Axel
 */
class MercadoPagoDelegate extends AbstractDelegate {

    protected $mp = FALSE;

    public function __construct() {
        parent::__construct();
        include_once __DIR__ . '/../../libs/mercadopago/mercadopago.php';
    }

    /**
     * inicializa MP
     * @param type $client_id
     * @param type $client_secret
     */
    private function init_mp($client_id, $client_secret) {
        try {
            $this->mp = new MP($client_id, $client_secret);
            if (SANDBOX)
                $this->mp->sandbox_mode(SANDBOX);
        } catch (Exception $e) {
            $this->mp = FALSE;
        }
        return $this->mp;
    }

    /**
     * Obtiene las credenciales de MP asociadas al usuario
     * @param type $user_id id del usuario
     * @return \stdClass un objeto con el client_id, client_secret y el token 
     */
    private function get_user_mp_credentials($user_id) {
        $data = new stdClass();
        $data->status = false;

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->GetUserCredentials($user_id);
                if ($result && $result->num_rows > 0) {
                    $data->credentials = $result->fetch_object();
                    $data->status = true;
                } else {
                    if (DEBUG)
                        $data->error = $result;
                }
            } catch (Exception $exc) {
                $data->error = $exc->getMessage();
            }
        }

        return $data;
    }

    private function get_user_data_from_sale($sale_id) {
        $data = new stdClass();
        $data->status = false;

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->GetSaleUser($sale_id);
                if ($result && $result->num_rows > 0) {
                    $data->credentials = $result->fetch_object();
                    $data->status = true;
                } else {
                    if (DEBUG)
                        $data->error = $result;
                }
            } catch (Exception $exc) {
                $data->error = $exc->getMessage();
            }
        }

        return $data;
    }

    /**
     * Procesa la notificacion entrante por parte de MP
     * @param String (json) $payment_info
     * @return \stdClass
     */
    private function process_ipn($payment_info) {
        $response = new stdClass();
        $response->status = false;
        try {
            $payment_info_json = json_encode($payment_info);
            $external_reference = $payment_info_json->response->collection->external_reference;
            $status = $payment_info_json->response->collection->status;

            $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);
            if ($db) {
                try {
                    // actualizo el estado de la venta
                    $result = $db->SaleUpdateStatus($external_reference, $status);
                    if ($result && $result->num_rows > 0) {
                        $response->status = true;
                    } else {
                        if (DEBUG)
                            $response->error = $result;
                    }
                } catch (Exception $exc) {
                    $response->error = $exc->getMessage();
                }
            }
        } catch (Exception $exc) {
            $response->error = $exc->getTraceAsString();
        }

        if ($response->status)
            http_response_code(200); // http_response_code(201); si se creara algo..
        else
            http_response_code(500); // :(
        return $response;
    }

    /**
     * procesa un IPN
     * @param type $id
     */
    public function ipn($id, $user_id) {
        $response = new stdClass();
        $response->status = false;
        try {
            // obtener las credenciales del usuario
            $user_data = $this->get_user_mp_credentials($user_id);
            if ($user_data->status) { // se pudo obtener las credenciales?
                $this->init_mp($user_data->credentials->client_id, $user_data->credentials->client_secret);
                $payment_info = $this->mp->get_payment_info($id);
                $response->ipn = $this->process_ipn($payment_info);
                $response->status = true;
            }
        } catch (Exception $exc) {
            // en caso de error, se devuelve 500 para que MP lo tome como error y reintente los IPN
            http_response_code(500);
            $response->error = $exc->getMessage();
        }
        return $response;
    }

    /**
     * Crea el punto de entrada para el checkout de MP
     * @param type $id 
     * @return \stdClass el [sandbox]init_point
     */
    public function checkout($id, $user_id) {
        $response = new stdClass();
        $response->status = false;
        $preference_data = null;
        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);
        $item = FALSE;
        if ($db) {
            try {
                $result = $db->SaleGet($id, $user_id);
                if ($result && $result->num_rows > 0) {
                    $item = $result->fetch_object();
                }
            } catch (Exception $exc) {
                
            }
        }
        if ($item) {

            $user_data = $this->get_user_mp_credentials($user_id);
            if ($user_data->status) {
                $this->init_mp($user_data->credentials->client_id, $user_data->credentials->client_secret);

                $preference_data = array(
                    "external_reference" => "$id",
                    "items" => array(
                        array(
                            "title" => $item->name,
                            "quantity" => 1,
                            "currency_id" => "ARS",
                            "unit_price" => (int) $item->ammount
                        )
                    )
                );
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
            }
        }
        return $response;
    }

    /**
     * Con los datos del usuario, se obtiene el access token para trabajar con su cuenta de MP
     * Se obtienen de: https://www.mercadopago.com/mla/herramientas/aplicaciones
     * @param type $client_id el client_id
     * @param type $client_secret el client_secret
     */
    public function auth($client_id, $client_secret) {
        $response = new stdClass();
        $response->status = false;

        $this->init_mp($client_id, $client_secret);
        try {
            if ($this->mp) {
                $response->token = $this->mp->get_access_token();
                $response->status = true;
            }
        } catch (Exception $exc) {
            $response->error = $exc->getTraceAsString();
        }

        return $response;
    }

}
?>
