<?php

/**
 *  AbstractDelegate
 *  Clase base para los delegates de funciones
 * 
 *  @author Axel
 */
abstract class AbstractDelegate {

    public function __construct() {
        
    }

    /**
     * Capturar los metodos no definidos
     * @param type $name
     * @param type $arguments
     * @return \stdClass
     */
    public function __call($name, $arguments) {
        $default = new stdClass();
        $default->error = "$name no definido";
        return $default;
    }

}

?>
