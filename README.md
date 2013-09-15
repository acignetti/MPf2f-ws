# MPf2f-ws
========

Webservice para MP-F2F  (MercadoPago Face 2 Face)
Nexo entre el resto de las aplicaciones: MP Wallet y MP Sales Point.

========

##### Este ws contempla las siguientes operaciones:

##### Operaciones relacionadas a los Usuarios
* user_signup
* user_login
* user_logout
* user_session_check

##### Operaciones relacionadas a MP
* mp_checkout
* mp_checkout_deal
* mp_auth
* mp_search
* mp_ipn

##### Operaciones relacionadas a las ventas
* sales_create
* sales_get
* sales_list
* sales_qr
* sales_nfc
* sales_code
* sales_deals
* sales_buy_deal

========
# Setup sobre el que corrio el proyecto:

- "Server": Windows 8
- Mysql 5.5.27
- Php 5.4.7

Nota:
El Mysql sobre el que se desarrolo, al correr sobre windows ignora las mayusculas en los nombres de las tablas. En las stored procedures, estan como en los creates (prefijo en mayusculas)

##### Estructura del proyecto:

- delegates
- abstract
..* impl
- libs
..* mercadopago
..* qr
- sql
..* procedures
..* schema
..* tables
- utils

Como funciona el WebService:

El punto de entrada es **operaciones.php**
- Lo minimo que se espera es un parametro **operaciones**, se utiliza en un switch para identificar la *operacion*, los *parametros* asociados a la operacion y luego delegar la logica en a *delegate*.

- Ejemplo de pegada:

http://localhost/mp-ws/operaciones.php?operacion=user_login&username=user&password=123

Donde:
- La *operacion* a ejecutar es **user_login**
- **username** y **password** son los parametros asociados a la *operacion*.

Respuesta:
```javascript
        {
            "status": true, // si se produce algun error, status es false, si **DEBUG** (en configs.conf.inc) es **TRUE**, se adjunta un mensaje de error
            "session": {
                        "uid": "1",
                        "name": "Axel Coronel",
                        "user": "axel",
                        "session_key": "42692c3cf24609a9b4e7334050131078",
                        "date_start": "2013-09-15 15:34:38",
                        "date_end": "2013-09-15 16:34:38",
                        "valid": "1"
                }
        }
 ```
- Notar que esta dentro de una subcarpeta y no en el / del dominio
- Siempre devuelve un *json* (o *jsonp* si se agrega un parametro *callback*)
- Ciertas operaciones tienen una *minima* validacion de sesion (utilizando el username y la session_key que expira a la hora)
- El ws contempla mas funcionalidades de las que llegaron a soportar las apps.