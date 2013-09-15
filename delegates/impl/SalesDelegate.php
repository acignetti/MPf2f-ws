<?php

/**
 * Encapsula las funciones referidas a una venta
 *
 * @author Axel
 */
class SalesDelegate extends AbstractDelegate {

    public function __construct() {
        parent::__construct();
    }

    /**
     * Crea una nueva venta
     * @param String $descripcion descripcion de la venta
     * @param float $price precio de la venta
     * @return \stdClass
     */
    public function create($user_id, $descripcion, $price) {
        $sales = new stdClass();
        $sales->status = false;
        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->SaleNew($user_id, $descripcion, $price);
                if ($result && $result->num_rows > 0) {
                    $sales->item = $result->fetch_object();
                    $sales->status = true;
                } else {
                    if (DEBUG)
                        $sales->error = $result;
                }
            } catch (Exception $exc) {
                $sales->error = $exc->getMessage();
            }
        }

        if ($sales->status) // se creo una nueva venta
            http_response_code(201);

        return $sales;
    }

    /**
     * Retorna los datos de una venta
     * @param int $id el id de la venta a consultar
     * @param int $uid el id del usuario
     * @return \stdClass stdClass con los datos de la venta
     */
    public function get($id, $uid) {
        $sales = new stdClass();
        $sales->status = false;
        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->SaleGet($id, $uid);
                if ($result && $result->num_rows > 0) {
                    $sales->item = $result->fetch_object();
                    $sales->status = true;
                } else { // el id de la venta no es del usuario?
                    if (DEBUG)
                        $sales->error = $result;
                }
            } catch (Exception $exc) {
                $sales->error = $exc->getMessage();
            }
        }
        return $sales;
    }

    /**
     * Retorna una lista de ventas filtrando por estado y usuario.
     * @param int $id el id de la venta a consultar
     * @param int $uid el id del usuario
     * @return \stdClass stdClass con los datos de la venta
     */
    public function sale_list($userid, $status, $start, $limit) {
        $sales = new stdClass();
        $sales->status = false;
        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->SaleList($userid, $status, $start, $limit);
                if ($result && $result->num_rows > 0) {
                    while ($result && $r = $result->fetch_object()) {
                        $sales->sales[] = $r;
                    }
                    $sales->status = true;
                } else {
                    if (DEBUG)
                        $sales->error = $result;
                }
            } catch (Exception $exc) {
                $sales->error = $exc->getMessage();
            }
        }
        return $sales;
    }

    /**
     * crea la url para hacer el checkout
     * @param type $id
     * @param int $user_id id del usuario al que pertenece la venta
     * @return type
     */
    private function build_url_checkout($id, $user_id) {
        $ip = $_SERVER['SERVER_ADDR'];
        $operacion = OPERATION_MP_CHECKOUT;
        return "http://$ip/mp-ws/operaciones.php?operacion=$operacion&id=$id&user_id=$user_id";
    }

    /**
     * Genera un qr a partir del id de una venta con la url del init_point de mp
     * @param int $id id de la venta
     * @param int $user_id id del usuario al que pertenece la venta
     * @return String (Base64) String Base64 con la img del codigo qr
     */
    public function qr($id, $user_id) {
        $response = new stdClass();
        $response->status = false;
        try {
            include __DIR__ . '/../../libs/qr/qrlib.php';
            $url = $this->build_url_checkout($id, $user_id);

            // generar codigo qr con la url con el init_point
            ob_start();
            QRCode::png($url, false, QR_ECLEVEL_H);
            $response->qr = $image_string = base64_encode(ob_get_contents());
            ob_end_clean();

            $response->status = true;
        } catch (Exception $exc) {
            $response->error = $exc->getTraceAsString();
        }

        return $response;
    }

    /**
     * Devuelve la url del init_point de mp
     * @param int $id id de la venta
     * @param int $user_id id del usuario al que pertenece la venta
     * @return String url para hacer checkout
     */
    public function nfc($id, $user_id) {
        $response = new stdClass();
        $response->status = true;
        $response->url = $this->build_url_checkout($id, $user_id);
        return $response;
    }

    /**
     * Devuelve la url del init_point de mp
     * @param int $code codigo de la venta
     * @param int $user_id id del usuario al que pertenece la venta
     * @return String url para hacer checkout
     */
    public function code($code, $user_id) {
        $response = new stdClass();
        $response->status = true;
        // despues se ve si el codigo va a tener otro dominio distinto AlfaNco* -> int o algo asi..
        $response->url = $this->build_url_checkout($code, $user_id);
        return $response;
    }

    /**
     * Obtiene las ofertas cercanas a la posicion
     * @param type $lat latitud
     * @param type $lon longitud
     * @param type $range distancia dentro de la cual buscar
     * @return \stdClass array con las ofertas cercanas
     */
    public function near_deals($lat, $lon, $range) {
        $deals = new stdClass();
        $deals->status = false;
        $deals->deals = array();

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->DealsNearBy($lat, $lon, $range);
                while ($result && $r = $result->fetch_object()) {
                    $deals->deals[] = $r;
                }
                $deals->status = true;
            } catch (Exception $exc) {
                $deals->error = $exc->getMessage();
            }
        }
        return $deals;
    }

    /**
     * 
     * @param int $id id de la oferta
     * @return \stdClass
     */
    public function buy_deal($id) {
        $sales = new stdClass();
        $sales->status = true;
        $sales->deal = null;

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->DealGet($id);
                if ($result && $result->num_rows > 0) {
                    $deal = $result->fetch_object();
                    $sales->deal = $deal;
                    try {
                        $db->free_result($result); // liberar el resource para permitir la proxima query
                        // crear la venta para la oferta
                        $result = $db->SaleNew($deal->id_usuario, $deal->description, $deal->price);
                        if ($result && $result->num_rows > 0) {
                            $sales->item = $result->fetch_object();
                            $sales->status = true;
                        } else {
                            if (DEBUG)
                                $sales->error = $result;
                        }
                    } catch (Exception $exc) {
                        $sales->error = $exc->getMessage();
                    }
                } else {
                    if (DEBUG)
                        $sales->error = $result;
                }
            } catch (Exception $exc) {
                $sales->error = $exc->getMessage();
            }
        }

        if ($sales->status) {
            http_response_code(201); // se creo una venta
            $sales->url = $this->build_url_checkout($id, $sales->deal->id_usuario);
        } else {
            $sales->url = null;
        }
        return $sales;
    }

}

?>
