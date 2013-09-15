<?php

/**
 * AbstractDelegate
 */
abstract class AbstractDelegate {

    protected static $instance = null;

    protected function __construct() {
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

    // forzar a generar el instance
    public static function getInstance() {
        return null;
    }

}

?>
