<?php

/**
 * Encapsula las funciones referidas a un usuario
 * @author Axel
 */
class UserDelegate extends AbstractDelegate {

    public function __construct() {
        parent::__construct();
    }

    public function signup($username, $psw, $fullname, $client_id, $client_secret) {
        $response = new stdClass();
        $response->status = false;

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);
        $mp = DelegateFactory::getDelegateFor(DELEGATE_MP);

        $token = $mp->auth($client_id, $client_secret);

        if ($db) {
            try {
                $result = $db->UserSignUp($username, $psw, $fullname, $client_id, $client_secret, $token);
                if ($result && $result->num_rows > 0) {
                    $response->user = $result->fetch_object();
                    $response->status = true;
                } else {
                    if (DEBUG)
                        $response->error = $result;
                }
            } catch (Exception $exc) {
                $response->error = $exc->getMessage();
            }
        }

        return $response;
    }

    /**
     * Realiza la validacion de las credenciales del usuario
     * @param type $username nombre de usuario
     * @param type $password password (texto plano, por ahora..)
     * @return \stdClass
     */
    public function login($username, $password) {
        $access = new stdClass();
        $access->status = false;

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->UserSessionLogin($username, $password);
                if ($result && $result->num_rows > 0) {
                    $access->session = $result->fetch_object();
                    $access->status = true;
                } else {
                    if (DEBUG)
                        $access->error = $result;
                }
            } catch (Exception $exc) {
                $access->error = $exc->getMessage();
            }
        }

        return $access;
    }

    /**
     * 
     * @param type $username nombre de usuario
     * @param type $session_key session_key a invalidar
     * @return \stdClass
     */
    public function logout($username, $session_key) {
        $access = new stdClass();
        $access->status = false;

        $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);

        if ($db) {
            try {
                $result = $db->UserSessionDestroy($username, $session_key);
                if ($result) {
                    $access->status = true;
                } else {
                    if (DEBUG)
                        $access->error = $result;
                }
            } catch (Exception $exc) {
                $access->error = $exc->getMessage();
            }
        }

        return $access;
    }

    public function session_check($username, $session_key) {
        $access = new stdClass();
        $access->status = false;
        if (($username && $username != "") && ($session_key && $session_key != "")) {
            $db = DelegateFactory::getDelegateFor(DELEGATE_MYSQL);
            if ($db) {
                try {
                    $result = $db->UserSessionCheck($username, $session_key);
                    if ($result && $result->num_rows > 0) {
                        $access->session = $result->fetch_object();
                        $access->status = true;
                    } else {
                        if (DEBUG)
                            $access->error = $result;
                    }
                } catch (Exception $exc) {
                    $access->error = $exc->getMessage();
                }
            }
        }

        return $access;
    }

}
?>
