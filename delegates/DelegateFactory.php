<?php

/**
 * Factory de Delegates
 *
 * @author Axel
 */
include __DIR__ . '/abstract/AbstractDelegate.php';
include __DIR__ . '/abstract/AbstractDatabaseDelegate.php';

/**
 * Factory de Delegates
 */
class DelegateFactory {

    /**
     * Devuelve un delegete
     * @param String $type nombre/clase del delegeta a obtener
     * @return mixed el delegate solicitado o bien FALSE si no existe
     */
    static function getDelegateFor($type) {
        $delegate = FALSE;
        switch ($type) {
            case DELEGATE_USER:
                include_once __DIR__ . '/impl/' . DELEGATE_USER . '.php';
                $delegate = new UserDelegate();
                break;
            case DELEGATE_MP:
                include_once __DIR__ . '/impl/' . DELEGATE_MP . '.php';
                $delegate = new MercadoPagoDelegate();
                break;
            case DELEGATE_MYSQL:
                include_once __DIR__ . '/impl/' . DELEGATE_MYSQL . '.php';
                $delegate = new MySQLDelegate(MYSQL_HOST, MYSQL_USER, MYSQL_PWD, MYSQL_DB);
                break;
            case DELEGATE_SALES:
                include_once __DIR__ . '/impl/' . DELEGATE_SALES . '.php';
                $delegate = new SalesDelegate();
                break;
            default:
                break;
        }

        return $delegate;
    }

}

?>
