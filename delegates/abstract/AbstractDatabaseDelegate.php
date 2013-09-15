<?php

/**
 * AbstractDatabaseDelegate
 * Hack: Esta clase no captura los metodos no definidos, __call no puede sobrecargarse (buscar la vuelta, si sobra tiempo :p)
 */
abstract class AbstractDatabaseDelegate {

    protected static $instance = null;

    public function __construct($host, $username, $password, $database) {
        
    }

    function query($query) {
        
    }

    // forzar a generar el instance
    public static function getInstance() {
        return null;
    }

}

?>
