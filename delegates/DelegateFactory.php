<?php

/**
 * Factory de Delegates
 *
 * @author Axel
 */
include __DIR__ . '/abstract/AbstractDelegate.php';

class DelegateFactory {

    static function getDelegateFor($type) {
        $delegate = null;
        $type = strtolower($type);
        switch ($type) {
            case DELEGATE_USER:
                include __DIR__ . '/impl/UsuarioDelegate.php';
                $delegate = UsuarioDelegate::getInstance();
                break;
            case DELEGATE_MP:
                include __DIR__ . '/impl/MercadoPagoDelegate.php';
                $delegate = MercadoPagoDelegate::getInstance();
                break;
            default:
                break;
        }

        return $delegate;
    }

}

?>
