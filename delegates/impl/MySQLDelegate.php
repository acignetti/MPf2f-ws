<?php

/**
 * Description of UsuarioDelegate
 *
 * @author Axel
 */
class MySQLDelegate extends AbstractDelegate {

    protected function __construct() {
        parent::__construct();
    }

    public static function getInstance() {
        if (is_null(parent::$instance)) {
            parent::$instance = new MySQLDelegate();
        }
        return parent::$instance;
    }

}

?>
