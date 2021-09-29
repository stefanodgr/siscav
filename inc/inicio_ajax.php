<?php
    // -------------------------- REGISTRO DE FUNCIONES XAJAX -------------------------- //
        $xajax->registerFunction('validarLogin');
        $xajax->registerFunction('cambiarClave');
        $xajax->registerFunction('cerrarSesion');
        $xajax->registerFunction('validarSesion');
    // --------------------------------------------------------------------------------- //

    // -------------------------------- FUNCIONES XAJAX -------------------------------- //
        function validarLogin($login, $clave){  // VALIDA LA INFORMACIÓN INGRESADA PARA PROCEDER AL INICIO DE SESIÓN EN EL SISTEMA 
            global $objResponse; 

            $miUsuario  = new Usuario();
            $login      = strMayus(limpiarPalabra($login));
            $miUsuario  ->setAtributo("usuario_login", $login);
            
            $claveHash      = strtoupper(sha1(sha1(limpiarPalabra($login.$clave))));
            $arrUsuario     = $miUsuario->consultar();
            $cantUsuario    = count($arrUsuario);

            if ($cantUsuario == 1) $claveBD = $arrUsuario[0]->getAtributo("usuario_clave");
            else $claveBD = "";

            $resultado      = false;
            $claveValida    = false;
            $claveInicial   = false;

            if((strtoupper($claveBD) == "METRO") && (strtoupper($clave) == "METRO")) $claveInicial = true; //verificamos si la clave inicial es METRO lo cual indica si debemos cambiar la clave
            
            if($claveHash == $claveBD) $claveValida = true; // VALIDA HASH USUARIO CON HASH BD
            
            if($cantUsuario == 1 && !$claveInicial && $claveValida){

                $idUsuario  = $arrUsuario[0]->getAtributo("usuario_id");
                $idEst      = $arrUsuario[0]->getObjeto("Estructura")->getAtributo('est_id');
                $codEst     = $arrUsuario[0]->getObjeto("Estructura")->getAtributo('est_sigla');

                $miPerfilUsuario = new PerfilUsuario();
                $miPerfilUsuario->setObjeto("Usuario",$idUsuario);
                $arregloPerfilUsuario = $miPerfilUsuario->consultar();
                $cantPerfilUsuario = count($arregloPerfilUsuario);

                if($cantPerfilUsuario > 0){
                    $PerfilUsuario      = $arregloPerfilUsuario[0]->getObjeto("Perfil")->getAtributo("perfil_desc");
                    $IdPerfilUsuario    = $arregloPerfilUsuario[0]->getObjeto("Perfil")->getAtributo("perfil_id");
                    $idRelPerfilUsuario = $arregloPerfilUsuario[0]->getAtributo("rel_perfil_usuario_id");
                }
                
                $direccionIp    = obtenerIP();
                $miConexion     = new Conexion();

                $arrConexionPerfil = $miConexion->consultarConexion(null,$idRelPerfilUsuario);

                if(count($arrConexionPerfil) > 0){
                    foreach($arrConexionPerfil as $i=>$unaConexion){
                        $idConexOld = $unaConexion['id'];
                        cerrarSesion($idConexOld);
                    }
                }

                $miConexion->setAtributo("conexion_fecha_ini",   formatoFechaHoraBd());
                $miConexion->setAtributo("conexion_ip",    $direccionIp);
                $miConexion->setObjeto("PerfilUsuario", $idRelPerfilUsuario);
                $ctrlConexion = $miConexion->registrar();

                if($ctrlConexion){
                    $_SESSION['Login']              = $login;  
                    $_SESSION['PerfilUsuario']      = $PerfilUsuario;
                    $_SESSION['IdUsuario']          = $idUsuario;
                    $_SESSION['IdPerfilUsuario']    = $IdPerfilUsuario;
                    $_SESSION['IdRelPerfilUsuario'] = $idRelPerfilUsuario;		
                    $_SESSION['idEstructura']       = $idEst;	                // ID DE LA SEDE A LA QUE PERTENECE EL USUARIO       
                    $_SESSION['codEstructura']      = $codEst;			        // CODIGO DE LA SEDE A LA QUE PERTENECE EL USUARIO
                    $_SESSION['IdConexion']         = $miConexion->getAtributo("conexion_id");
                    $_SESSION['exp']                = time() + EXP;    
                    $_SESSION['direccionIp']        = $direccionIp;

                    $snLogin        = $login;
                    $snPerfUsu      = $PerfilUsuario;
                    $snIdUsu        = $idUsuario;
                    $snIdPerfUsu    = $IdPerfilUsuario;
                    $snIdRelPerfUsu = $idRelPerfilUsuario;
                    $snIdEst        = $idEst;
                    $snCodEst       = $codEst;
                    $snConex        = $_SESSION['IdConexion'];
                    $snExpire       = $_SESSION['exp'];
                    $snMaxTime      = EXP;

                    // $objResponse->addAlert($snLogin." -- ".$snPerfUsu." -- ".$snIdUsu." -- ".$snIdPerfUsu." -- ".$snIdRelPerfUsu." -- ".$snIdEst." -- ".$snCodEst." -- ".$snConex." -- ".$snExpire);
                    validarSesion($snMaxTime);
                    cantConexiones(); 
                    $objResponse->addScriptCall('mostrarMenu');
                    $objResponse->addScriptCall('sessionJs',$snLogin,$snPerfUsu,$snIdUsu,$snIdPerfUsu,$snIdRelPerfUsu,$snIdEst,$snCodEst,$snConex,$snExpire);
                }
                else{
                    $objResponse->addAlert(utd8_decode("Carné: ".$login." ingresó exitosamente. No Registro Conexion"));
                }
            }
            else{
                if($claveInicial) {
                    $_SESSION['ctrlPass'] = true;
                    $objResponse->addScriptCall('cambiarClave');
                }
                else{
                    $objResponse->addScriptCall('msgLogin',utf8_decode('ERROR: Usuario y/o contraseña incorrectos.'));
                    $objResponse->addScriptCall('limpiarCamposLogin');
                }	
            }

            return $objResponse;
        }
        function cambiarClave($login, $clave){  // CAMBIO DE CLAVE
            global $objResponse;

            if($_SESSION['ctrlPass']){
                $miUsuario  = new Usuario();
                $login      = strMayus(limpiarPalabra($login));
                $miUsuario->setAtributo("usuario_login", $login);
                $arrUsuario = $miUsuario->consultar();

                $idUsuario  = $arrUsuario[0]->getAtributo("usuario_id");

                $miUsuario->setAtributo("usuario_id", $idUsuario);
                $miUsuario->setAtributo("usuario_clave", strtoupper(sha1(sha1($login.$clave))));
                $resultado  = $miUsuario->modificar();

                if($resultado){
                    $objResponse->addScriptCall(msgLogin, utf8_decode('Contraseña cambiada con éxito. Ingrese con su nueva contraseña.'));
                    $objResponse->addScriptCall(limpiarCamposLogin);
                    unset($_SESSION['ctrlPass']);
                }
                else $objResponse->addScriptCall(msgLogin,utf8_decode('ERROR: Ocurrió un problema al intentar cambiar la contraseña.'));
            }
            else $objResponse->addAlert(utf8_decode("ADVERTENCIA: Cualquier intento de hackeo o manipulación del sistema será gravemente penalizado. Evite sanciones."));
            
            return $objResponse;
        }
        function cerrarSesion($conexId){        // CIERRA LA SESIÓN ACTUAL
            global $objResponse;

            $fechaRegistro  = formatoFechaHoraBd();
            $ctrlIndex      = false;

            if(!$conexId){
                $ctrlIndex  = true;
                $conexId    = $_SESSION['IdConexion'];

                // SE GUARDA UN REGISTRO DE AUDITORIA DEL CIERRE DE SESION //
                // $tipoAuditoria  = 7;//CIERRE DE SESION
                // $PerfilUsuario  = $_SESSION['PerfilUsuario'];
                // $observacion    = "CERRO LA SESION CON PERFIL: $PerfilUsuario";
                // $miAuditoria    = new Auditoria();
                // $miAuditoria->setAtributo("auditoria_fecha", $fechaRegistro);
                // $miAuditoria->setAtributo("auditoria_observ", $observacion);
                // $miAuditoria->setObjeto("Conexion",$conexId);
                // $miAuditoria->setObjeto("TipoAuditoria",$tipoAuditoria);
                // $exitoRegistrarAuditoria = $miAuditoria->registrar();	
                // ------------------------------------------------------- //
            }

            $conexion = new Conexion();
            $ctrlConexion = $conexion->cerrarConexion(null, $conexId);

            if($ctrlConexion){
                if($ctrlIndex){
                    session_unset();
                    session_destroy();
                    $objResponse->addScriptCall('reiniciarIndex');
                }
            }
            else $objResponse->addScript('console.log("Error al intentar cerrar las conexiones previas");');            

            return $objResponse;
        }
        function validarSesion($snMaxTime){               // VERIFICA SI HA TRANSCURRIDO EL TIEMPO DE INACTIVIDAD MÁXIMA PARA PROCEDER A CERRAR LA SESIÓN DE FORMA AUTOMÁTICA
            global $objResponse;
            
            if($snMaxTime) $tiempoRestante = $snMaxTime;
            else $tiempoRestante = $_SESSION['exp'] - time();

            if($tiempoRestante <= 0) cerrarSesion();
            else $objResponse->addScriptCall('validarSesion',($tiempoRestante * 1000));

            return $objResponse;
        }
    // --------------------------------------------------------------------------------- //
?>