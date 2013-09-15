<?php

/**
 * Factory de Delegates
 *
 * @author Axel
 */
include __DIR__ . '/abstract/AbstractDelegate.php';
include __DIR__ . '/abstract/AbstractDatabaseDelegate.php';

class DelegateFactory {

    static function getDelegateFor($type) {
        $delegate = FALSE;
        switch ($type) {
            case DELEGATE_USER:
                include __DIR__ . '/impl/' . DELEGATE_USER . '.php';
                $delegate = UserDelegate::getInstance();
                break;
            case DELEGATE_MP:
                include __DIR__ . '/impl/' . DELEGATE_MP . '.php';
                $delegate = MercadoPagoDelegate::getInstance();
                break;
            case DELEGATE_MYSQL:
                include __DIR__ . '/impl/' . DELEGATE_MYSQL . '.php';
                $delegate = MySQLDelegate::getInstance();
                break;
            case DELEGATE_SALES:
                include __DIR__ . '/impl/' . DELEGATE_SALES . '.php';
                $delegate = SalesDelegate::getInstance();
                break;
            default:
                break;
        }

        return $delegate;
    }

}

?>
