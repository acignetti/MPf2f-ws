<?php

/**
 *  AbstractDatabaseDelegate
 *  Hack: Esta clase no captura los metodos no definidos, __call no puede sobrecargarse (buscar la vuelta, si sobra tiempo :p)
 *  Clase base para los delegates que acceden a db
 * 
 *  @author Axel
 */
abstract class AbstractDatabaseDelegate {

    protected static $instance = null;

    public function __construct($host, $username, $password, $database) {
        
    }

    function query($query) {
        
    }

}

?>
