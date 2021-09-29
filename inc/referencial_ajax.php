<?php
    // -------------------------- REGISTRO DE FUNCIONES XAJAX -------------------------- //   
        $xajax->registerFunction('gestionPersonalEst');
        $xajax->registerFunction('eliminarPersonalEst'); 
        $xajax->registerFunction('gestionUsuario');      
    // --------------------------------------------------------------------------------- //

    // -------------------------------- FUNCIONES XAJAX -------------------------------- //
    function gestionPersonalEst($persId, $estId, $pabx, $persEstId){
        global $objResponse;
        
        // $objResponse->addAlert($persId." -- ".$estId." -- ".$pabx." -- ".$persEstId);

        if(!$persEstId){ // SI NO EXISTE REGISTRO PREVIO EN TABLA 'rel_personal_estructura'
            $relPersEst = new PersonalEstructura();
            $relPersEst->setAtributo('pers_id',$persId);
            $relPersEst->setAtributo('pabx',$pabx);
            $relPersEst->setObjeto('Estructura',$estId);
            $relPersEst->setObjeto('Conexion',$_SESSION['IdConexion']);
            $ctrlBd = $relPersEst->registrar();
            $msgError = utf8_decode("ERROR1C: Comuníquese con el administrador del sistema.");
        }
        else{
            $relPersEst = new PersonalEstructura(null,$persEstId);
            $relPersEst->setAtributo('pabx',$pabx);
            $relPersEst->setObjeto('Estructura',$estId);
            $ctrlBd = $relPersEst->modificar();
            $msgError = utf8_decode("ERROR2C: Comuníquese con el administrador del sistema.");
        }

        if(!$ctrlBd) $objResponse->addAlert($msgError);
        else{
            $objResponse->addScriptCall('actualizarIframe');
        }

        return $objResponse;
    }
    function eliminarPersonalEst($arrId){
        global $objResponse;

        $stringId = implode(',',$arrId);

        $conexionBd = new ConexionBd();
        $ctrlDel = $conexionBd->hacerDelete('rel_personal_estructura',"pers_id IN (".$stringId.")");

        if(!$ctrlDel) $objResponse->addAlert(utf8_decode("ERROR1D: Comuníquese con el administrador del sistema."));
        else{
            $objResponse->addScript("window.frames['ifr_util_est'].recargar();");
        }

        return $objResponse;
    }
    function gestionUsuario($persId, $persCarne, $estId, $usuId, $perfilId, $accion){
        global $objResponse;

        if($_SESSION['PerfilUsuario'] != 'SISTEMAS') $perfilId = false;  // PARA ASEGURAR QUE SÓLO UN USUARIO CON PERFIL SISTEMAS PUEDA MODIFICAR LOS PERFILES

        $conexion = new ConexionBd();

        if($accion != 'eliminar'){
            if($usuId) $accion = 'modificar';
            else $accion = 'agregar';
        }
        
        $arrRelPerfilUsu = $conexion->hacerSelect('*','rel_perfil_usuario','usuario_id IN ('.$usuId.')');
        if(count($arrRelPerfilUsu)>0) $ctrlRelPerfilUsu = true;
        else $ctrlRelPerfilUsu = false;

        if($accion == 'agregar'){
            $usuario = new Usuario();
            $usuario->setAtributo('usuario_login',$persCarne);
            $usuario->setAtributo('pers_id',$persId);

            if($estId) $usuario->setObjeto('Estructura',$estId);
            
            $ctrlBd = $usuario->registrar();

            if($ctrlBd){
                if($perfilId){
                    $usuarioId = $usuario->getAtributo('usuario_id');
                    $perfilUsuario = new PerfilUsuario();
                    $perfilUsuario->setObjeto('Usuario',$usuarioId);
                    $perfilUsuario->setObjeto('Perfil',$perfilId);
                    $ctrlBdRel = $perfilUsuario->registrar();
    
                    if(!$ctrlBdRel){
                        $msgError = utf8_decode("ERROR2F: Comuníquese con el administrador del sistema.");
                        $ctrlBd = false;
                    }
                }
            }
            $msgError = utf8_decode("ERROR1F: Comuníquese con el administrador del sistema.");
        }
        if($accion == 'modificar'){
            $usuario = new Usuario(null,$usuId);
            $usuario->setObjeto('Estructura',$estId);
            $ctrlBd = $usuario->modificar();

            if($ctrlBd){
                if($perfilId){
                    if($ctrlRelPerfilUsu){
                        $ctrlBdRel = $conexion->hacerUpdate('rel_perfil_usuario','perfil_id = '.$perfilId, 'usuario_id = '.$usuId);
                    }
                    else{
                        $relPerfiUsu = new PerfilUsuario();
                        $relPerfiUsu->setObjeto('Usuario',$usuId);
                        $relPerfiUsu->setObjeto('Perfil',$perfilId);
                        $ctrlBdRel = $relPerfiUsu->registrar();
                    }
                    if(!$ctrlBdRel){
                        $msgError = utf8_decode("ERROR4F: Comuníquese con el administrador del sistema.");
                        $ctrlBd = false;
                    }
                }
            }
            $msgError = utf8_decode("ERROR3F: Comuníquese con el administrador del sistema.");
        }
        if($accion == 'eliminar'){
            $conexion = new ConexionBd();
            $ctrlBd = true;

            $arrRelPerfilUsu = $conexion->hacerSelect('*','rel_perfil_usuario','usuario_id IN ('.$usuId.')');

            if(count($arrRelPerfilUsu)>0){
                $ctrlBdRel = $conexion->hacerDelete('rel_perfil_usuario','usuario_id IN ('.$usuId.')');
                
                if(!$ctrlBdRel){
                    $msgError = utf8_decode("ERROR6F: Comuníquese con el administrador del sistema.");
                    $ctrlBd = false;
                }
            }

            if($ctrlBd) $ctrlBd = $conexion->hacerDelete('usuario','usuario_id IN ('.$usuId.')');
            if(!$ctrlBd) $msgError = utf8_decode("ERROR5F: Comuníquese con el administrador del sistema.");
        }

        if(!$ctrlBd) $objResponse->addAlert($msgError);
        else $objResponse->addScriptCall('actualizarIframe');

        return $objResponse;
    }
    // --------------------------------------------------------------------------------- //
?>