<?php

/**
 * Description of UsuarioDelegate
 *
 * @author Axel
 */
class UserDelegate extends AbstractDelegate {

    protected function __construct() {
        parent::__construct();
    }

    public static function getInstance() {
        if (is_null(parent::$instance)) {
            parent::$instance = new UserDelegate();
        }
        return parent::$instance;
    }

    public function login($username, $password) {
        $access = new stdClass();
        $access->token = substr(md5($username), 0, 10);
        $access->active = true;
        return $access;
    }

    public function logout($token) {
        $access = new stdClass();
        $access->token = $token;
        $access->active                                                                                                                                                                                                  = false;
        return $access;
    }

}

?>
