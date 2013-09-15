<?php

/**
 * MySQLDelegate
 * Clase que interactua con la base de datos, realiza llamados a las sp de forma dinamica.
 *
 * @author Axel
 */
class MySQLDelegate extends AbstractDatabaseDelegate{

    public $conn;
    private $last_error;
    private $prefix = MYSQL_DB_PREFIX;
    private $use_store_result = false;

    public static function getInstance() {
        if (is_null(parent::$instance)) {
            parent::$instance = new MySQLDelegate(MYSQL_HOST, MYSQL_USER, MYSQL_PWD, MYSQL_DB);
        }
        return parent::$instance;
    }

    /**
     * Contruye la conexion a un servidor MySQL
     */
    public function __construct($host, $username, $password, $database) {
        parent::__construct($host, $username, $password, $database);
        $this->conn = new mysqli($host, $username, $password, $database);
    }

    public function setUseStoreResult($flag) {
        $this->use_store_result = $flag;
    }

    /**
     * Ejecuta una query, retornando el resultado
     * @param string $query
     */
    public function query($query) {
        //verificar conexion
        if (!($this->conn instanceof mysqli)) {
            throw new Exception("No se pudo crear la conexion");
        }

        $result = @$this->conn->query($query);

        if ($result === false) {
            $this->last_error = mysqli_error($this->conn);
            throw new Exception($this->last_error, $this->conn, $this->last_error);
        }

        return $result;
    }

    /**
     * Contruye una expresion conteniendo los parametros suministrados
     * @param array $parameter_list
     */
    private function build_procedure_parameters($parameter_list) {
        $parameters = array();

        foreach ($parameter_list as $parameter) {
            $type = gettype($parameter);

            //determinar tipo de parametro antes de convertir a string
            if ($type == 'string') {
                $parameter = "'" . addcslashes($parameter, "\\'") . "'";
            } elseif ($type == 'NULL') {
                $parameter = 'NULL';
            } elseif ($type == 'object') {
                try {
                    $parameter = $parameter->__toString();
                } catch (Exception $__e) {
                    trigger_error(sprintf("MySQLDelegate: Objeto de clase %s no posee metodo __toString(). Valor formateado a NULL", get_class($parameter)), E_USER_WARNING);
                    $parameter = 'NULL';
                }
            }


            $parameters[] = (string) $parameter;
        }

        return implode(',', $parameters);
    }

    /**
     * Invoca una procedure con los parametros suministrados
     * @throws Exception 
     */
    public function __call($procedure, $arguments) {
        if (!($this->conn instanceof mysqli)) {
            throw new Exception("No se pudo crear la conexion");
        }

        if (func_num_args() == 0) {
            throw new Exception("No se especifico un nombre de procedure");
        }

        $result = null;

        //verificar si la procedure se invoca sin parametros
        if (count($arguments) == 0) {
            //construir expresion
            $procedure_call = sprintf("CALL %s();", $this->prefix . $procedure);
            if ($this->use_store_result) {
                $result = @$this->conn->query($procedure_call, MYSQLI_STORE_RESULT);
            } else {
                $result = @$this->conn->query($procedure_call);
            }

            if ($result === false) {
                $this->last_error = mysqli_error($this->conn);
                throw new Exception('Error en consulta: ' . $this->last_error);
            }
        } else {
            //contruir expresion con los parametros
            $parameters = $this->build_procedure_parameters($arguments);

            //invocar procedure
            $procedure_call = sprintf("CALL %s(%s);", $this->prefix . $procedure, $parameters);
            if ($this->use_store_result) {
                $result = @$this->conn->query($procedure_call, MYSQLI_STORE_RESULT);
            } else {
                $result = @$this->conn->query($procedure_call);
            }
            if ($result === false) {
                $this->last_error = mysqli_error($this->conn);
                throw new Exception('Error en consulta: ' . $this->last_error);
            }
        }

        return $result;
    }

    /**
     * Libera un resultado mysqli
     * @param mysqli_result $result
     */
    public function free_result($result) {
        if ($result instanceof mysqli_result) {
            $result->free();
        }

        while ($this->conn->more_results() && $this->conn->next_result()) {
            $result = $this->conn->use_result();

            if ($result instanceof mysqli_result) {
                $result->free();
            }
        }
    }

    /**
     * Cierra la conexion
     * @throws Exception
     */
    public function close() {
        if (!($this->conn instanceof mysqli)) {
            throw new Exception("No se pudo crear la conexion");
        }

        $this->conn->close();
    }

}

?>
