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
    public function list($userid, $status, $start, $limit) {
        $sales = new stdClass();
        $sales->status = false;
        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->SalesList($userid, $status, $start, $limit);
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
        return $sales;
    }

    private function build_url_checkout($id) {
        $ip = $_SERVER['SERVER_ADDR'];
        return "http://$ip/mp-ws/operaciones.php?operacion=mp_checkout&id=$id";
    }

    /**
     * Genera un qr a partir del id de una venta con la url del init_point de mp
     * @param int $id id de la venta
     * @return String (Base64) String Base64 con la img del codigo qr
     */
    public function qr($id) {
        $response = new stdClass();
        $response->status = false;
        try {
            include __DIR__ . '/../../libs/qr/qrlib.php';
            $url = $this->build_url_checkout($id);

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
     * @return String url para hacer checkout
     */
    public function nfc($id) {
        $response = new stdClass();
        $response->status = true;
        $response->url = $this->build_url_checkout($id);
        return $response;
    }

    /**
     * Devuelve la url del init_point de mp
     * @param int $code codigo de la venta
     * @return String url para hacer checkout
     */
    public function code($code) {
        $response = new stdClass();
        $response->status = true;
        // despues se ve si el codigo va a tener otro dominio distinto
        $response->url = $this->build_url_checkout($code);
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

    //
    public function buy_deal($id) {
        $response = new stdClass();
        $response->status = true;
        $response->url = $this->build_url_checkout($id);
        return $response;
    }

}

?>
