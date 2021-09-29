<?php
    // -------------------------- REGISTRO DE FUNCIONES XAJAX -------------------------- //
        $xajax->registerFunction('cargarEstacion'); 
        $xajax->registerFunction('auditoria');
        $xajax->registerFunction('cargarConexion');
        $xajax->registerFunction('gestionArbol');
        $xajax->registerFunction('gestionEstructura');
        $xajax->registerFunction('buscarPersonal');
    // --------------------------------------------------------------------------------- //

    // -------------------------------- FUNCIONES XAJAX -------------------------------- //
        function cargarEstacion($opc, $idLinea, $accion){
            global $objResponse;
            
            $estacion = new Estacion();
            $estacion->setObjeto("Linea",$idLinea);
            $arrEstacion = $estacion->consultar();
            unset($estacion);

            if(count($arrEstacion) > 0){
                $size=0;
                foreach($arrEstacion as $i=>$estacion){
                    $idEstacion     = $estacion->getAtributo('estacion_id');
                    $nombreEstacion = utf8_decode($estacion->getAtributo('estacion_nombre'));
                    $opciones.="<option value='".$idEstacion."'>".$nombreEstacion."</option>";
                    $cantidad = strlen($nombreEstacion);
                    if($cantidad > $size) $size = $cantidad;
                }
                switch($opc){
                    case 1:
                        $html="<select id='sel_estacion' style='size:".$size."'><option value='0'>TODAS</option>";
                    break;
                    case 2:
                        $html="<select id='filt_ubicacion2' style='size:".$size."' disabled><option value='0'>SELECCIONAR</option>";
                    break;
                    case 3:
                        $html="<select id='filt_ubicacion2' style='size:".$size."'><option value='0'>SELECCIONAR</option>";
                    break;
                }

                $html.=$opciones;
                $html.="</select>";

                if($opc == 1) $objResponse->addAssign('col_sel_est','innerHTML',$html);
                else{
                    $objResponse->addAssign('col_filt_ubicacion2','innerHTML',$html);
                    $objResponse->addScript("$('#fila_aux_ubi').removeClass('oculto')");
                }
                
            }
            return $objResponse;
        }
        function auditoria($tipo,$arrDatos){
            global $objResponse;

            $miAuditoria = new Auditoria();

            $fechaRegistro = formatoFechaHoraBd();
            				
            //INICIO DE SESION
            $miAuditoria = new Auditoria();

            switch($tipo){
                case 'registrar':
                    $tipoAuditoria = 1;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'modificar':
                    $tipoAuditoria = 2;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'eliminar':
                    $tipoAuditoria = 3;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'status':
                    $tipoAuditoria = 4;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'consulta':
                    $tipoAuditoria = 5;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'iniciar':
                    $tipoAuditoria = 6;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'cerrar':
                    $tipoAuditoria = 7;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
                case 'reporte':
                    $tipoAuditoria = 8;
                    $observacion="INICIO LA SESION CON PERFIL: $PerfilUsuario";	
                break;
            }

            $miAuditoria->setAtributo("auditoria_fecha",    $fechaRegistro);
            $miAuditoria->setAtributo("auditoria_observ",   $observacion);
            $miAuditoria->setObjeto("Conexion",     $_SESSION['IdConexion']);
            $miAuditoria->setObjeto("TipoAuditoria",$tipoAuditoria);
            $exitoRegistrarAuditoria = $miAuditoria->registrar();

            return $objResponse;
        }
        function cargarConexion(){
            global $objResponse;
            
            $cantidadConex = $_SESSION['cantConexion'];
            $objResponse->addAssign('inp_inf_conex_val','value',$cantidadConex);

            return $objResponse;
        }
        function gestionArbol($idElement, $idBusq, $ctrlDesplegar, $tipoArbol){
            
            global $objResponse;

            $objeto = new Estructura();
            $arrEstructura = $objeto->consultarEstructura($idElement);
            
            if(count($arrEstructura)>0){
                $objResponse->addAppend('arbol_'.$idElement, 'innerHTML','<ul id = lista_'.$idElement.'></ul>');
            }

            foreach ($arrEstructura as $a) $padres[] = $a['padre'];
            foreach ($padres as $b) $arrPadres = compValArr($arrPadres, $b);
            foreach ($arrPadres as $d) {
                foreach($arrEstructura as $e){
                    if($d==$e['padre']){
                        // trim($e['area_padre_id']) > 1 ? $siglas = 'NO APLICA' : $siglas = trim($e['area_sigla']);
                        $grupoPadres[]= array(
                            id 			=> trim($e['id']),
                            codigo 		=> trim($e['sigla']),
                            descripcion => utf8_decode(trim($e['descripcion'])),
                            padre 		=> trim($e['padre']),
                            pabx 		=> trim($e['pabx']),
                            rel_pabx    => trim($e['rel_pabx'])
                        );
                    }
                }
                $estructura[]=$grupoPadres;
                unset($grupoPadres);
            }
            for($i=0; $i<count($estructura); $i++){
                for($j=0; $j<count($estructura[$i]); $j++) $arrPosPadre[] = array("idPadre"=>$estructura[$i][$j]['id'],"fil"=>$i,"col"=>$j); 
            }
            for($i=count($arrPadres); $i>0; $i--){
                $control = false;
                for($j=0; $j<count($estructura); $j++){
                    for($k=0; $k<count($estructura[$j]); $k++){
                        if($estructura[$j][$k]['padre'] == $arrPadres[$i]){
                            $grupoHijos[] = $estructura[$j][$k];
                            if($control == false){
                                $idPadre = $arrPadres[$i];
                                $control = true;
                            }
                        }
                    }
                }
                foreach($arrPosPadre as $a){
                    if($a['idPadre']==$idPadre) $estructura     [$a['fil']]     [$a['col']]     ['hijo'] = $grupoHijos;
                }
                unset($grupoHijos);
            }
            $arbol = $estructura[0];

            if($tipoArbol == 'estructura') $subAccion = "cargarFicha(this.parentNode.id)";
            if($tipoArbol == 'lista_estructura') $subAccion = "marcarEstructura(this.parentNode.id, this.innerHTML)";
            
            foreach($arbol as $a){
                $ctrlHijos = $objeto->consultarEstructura($a["id"]);
                
                if(count($ctrlHijos)>0){
                    $clase  = "glyphicon glyphicon-plus-sign";
                    $accion = "expandirArbol(this.parentNode.id,'".$tipoArbol."');";
                    $titulo = "Expandir elemento";
                }
                else{
                    $clase  = "glyphicon glyphicon-minus-sign";
                    $accion = "";
                    $titulo = "Este elemento no posee descendientes";
                }
                $contenido = '<li id="arbol_'.$a["id"].'" name="'.$a["codigo"].'">
                                    <span style="border:0px" onclick = "'.$accion.'">
                                        <i id="est_'.$a["id"].'" class="'.$clase.'" title="'.$titulo.'"></i>
                                    </span>
                                    <a onclick="'.$subAccion.'" name="'.$a["rel_pabx"].'_'.$a["pabx"].'">'.$a["descripcion"].'</a>
                                </li>';
                $objResponse->addAppend('lista_'.$idElement,'innerHTML',$contenido);
            }
            $objResponse->addScript("inicioArbol('ajax')");    

            if($idBusq != undefined){
                $objResponse->addScriptCall(cargarFicha, $idBusq, $ctrlDesplegar);
            	$objResponse->addScriptCall(moverScroll, $idBusq);
            }                
            
            return $objResponse;
        }
        function gestionEstructura($accion,$estId,$estCod,$estDesc,$estPabx,$estIdPadre,$estRelPabx){
            global $objResponse;
            
            $ctrlBd = false;

             switch ($accion) {
                case 'agregar':
                    $estructura = new Estructura();
                    $estructura->setAtributo('est_sigla',$estCod);
                    $estructura->setAtributo('est_desc',$estDesc);
                    $estructura->setAtributo('est_padre_id',$estIdPadre);
                    $estructura->setObjeto('Conexion',$_SESSION['IdConexion']);

                    $ctrlBd = $estructura->registrar();
                    if(!$ctrlBd) $mensaje = utf8_decode('ERROR1E: Comuníquese con el administrador del sistema.'); // ERROR AL INSERTAR EL REGISTRO
                    else{
                        $estId = $estructura->getAtributo('est_id');
                        $estructuraPabx = new EstructuraPabx();
                        $estructuraPabx->setObjeto('Estructura',$estId);
                        $estructuraPabx->setAtributo('pabx',$estPabx);

                        $ctrlBd = $estructuraPabx->registrar();
                        if(!$ctrlBd) $mensaje = utf8_decode('ERROR2E: Comuníquese con el administrador del sistema.'); // ERROR AL ACTUALIZAR EL REGISTRO
                    }
                break;
                
                case 'modificar':
                    $estructura = new Estructura(null,$estId);
                    $estructura->setAtributo('est_sigla',$estCod);
                    $estructura->setAtributo('est_desc',$estDesc);
                    $estructura->setAtributo('est_padre_id',$estIdPadre);

                    $ctrlBd = $estructura->modificar();
                    if(!$ctrlBd) $mensaje = utf8_decode('ERROR3E: Comuníquese con el administrador del sistema.'); // ERROR AL ACTUALIZAR EL REGISTRO
                    else{
                        if($estRelPabx){
                            $ctrlRel = true;
                            $estructuraPabx = new EstructuraPabx(null,$estRelPabx);
                        }
                        else{
                            $ctrlRel = false;
                            $estructuraPabx = new EstructuraPabx();
                            $estructuraPabx->setObjeto('Estructura',$estId);
                        }
                        
                        $estructuraPabx->setAtributo('pabx',$estPabx);

                        if($ctrlRel) $ctrlBd = $estructuraPabx->modificar();
                        else $ctrlBd = $estructuraPabx->registrar();
                        
                        if(!$ctrlBd) $mensaje = utf8_decode('ERROR4E: Comuníquese con el administrador del sistema.'); // ERROR AL ACTUALIZAR EL REGISTRO
                    }
                break;

                case 'eliminar':
                    $estructura = new Estructura();
                    $estructura->setAtributo('est_padre_id',$estId);
                    $estructura->setAtributo('est_activo','TRUE');
                    $arrPadreEst = $estructura->consultar();

                    if(count($arrPadreEst)>0){
                        $mensaje = utf8_decode('ERROR5E: Comuníquese con el administrador del sistema.'); // ERROR AL ELIMINAR EL REGISTRO DEBIDO A QUE ES PADRE DE OTRAS ESTRUCTURAS
                        $objResponse->addAlert($mensaje);
                        return $objResponse;
                    }
                    
                    $personalEst = new PersonalEstructura();
                    $personalEst->setObjeto('Estructura',$estId);
                    $arrPersonalEst = $personalEst->consultar();

                    if(count($arrPersonalEst)>0){
                        $mensaje = utf8_decode('ERROR6E: Comuníquese con el administrador del sistema.'); // ERROR AL ELIMINAR EL REGISTRO DEBIDO A QUE POSEE PERSONAL ASIGNADO
                        $objResponse->addAlert($mensaje);
                        return $objResponse;
                    }

                    unset($estructura);
                    $estructura = new Estructura(null,$estId);
                    $estructura->setAtributo('est_activo','FALSE');

                    $ctrlBd = $arrPadreEst = $estructura->modificar();
                    if(!$ctrlBd) $mensaje = utf8_decode('ERROR7E: Comuníquese con el administrador del sistema.'); // ERROR AL ELIMINAR EL REGISTRO
                break;
            }

            $rutaEst = $estructura->obtenerRutaEstructura($estId,null,$accion);
            $_SESSION['rastro_estructura'] = $rutaEst[0];
            $objResponse->addScriptCall('recargarArbol');

            return $objResponse;
        }
        function buscarPersonal($idPers,$cedulaPers,$carnePers,$modulo){
            global $objResponse;
            
            $personal = new Personal();

            if(!$idPers)        $idPers     = null;
            if(!$cedulaPers)    $cedulaPers = null;
            if(!$carnePers)     $carnePers  = null;

            $arrPers = $personal->buscarPersonal($idPers,$cedulaPers,$carnePers);

            // $objResponse->addAlert($idPers." -- ".$cedulaPers." -- ".$carnePers);
            
            if(count($arrPers) > 0){
                $ctrlExiste = true;

                $persId         = $arrPers[0]['id'];
                $perCedula      = $arrPers[0]['cedula'];
                $persNombre     = utf8_decode($arrPers[0]['nombre']);
                $persApellido   = utf8_decode($arrPers[0]['apellido']);
                $persTelefono   = $arrPers[0]['telefono'];
                $persOrg        = 'C.A METRO DE CARACAS';
                $persCarne      = $arrPers[0]['carne'];
                $persCargo      = utf8_decode($arrPers[0]['cargo']);
                $persFoto       = gestionArchivo('consultar','../sictra/fotos/'.$perCedula);
            }
            
            if($ctrlExiste){
                if($modulo == 'general'){
                    $relPersEst = new PersonalEstructura();
                    $relPersEst->setAtributo('pers_id',$persId);
                    $arrPersEst = $relPersEst->consultar();

                    if(count($arrPersEst)>0){
                        $objResponse->addAssign('ficha_pers_rel_est_id' ,'value'    ,$arrPersEst[0]->getAtributo('rel_pers_est_id'));
                        $objResponse->addAssign('ficha_pers_est'        ,'value'    ,$arrPersEst[0]->getObjeto('Estructura')->getAtributo('est_desc'));
                        $objResponse->addAssign('ficha_pers_est'        ,'name'     ,$arrPersEst[0]->getObjeto('Estructura')->getAtributo('est_id'));
                        $objResponse->addAssign('ficha_pers_pabx'       ,'value'    ,$arrPersEst[0]->getAtributo('pabx'));
                    }

                    $usuario = new Usuario();
                    $usuario->setAtributo('pers_id',$persId);
                    $arrUsuario = $usuario->consultar();

                    if(count($arrUsuario)>0){
                        $usuarioId  = $arrUsuario[0]->getAtributo('usuario_id');
                        $usuarioEst = $arrUsuario[0]->getObjeto('Estructura')->getAtributo('est_sigla');

                        $objResponse->addAssign('ficha_pers_usu_id','value',$usuarioId);
                        $objResponse->addScriptCall('selectManual','ficha_pers_sede',$usuarioEst);

                        $perfilUsuario = new PerfilUsuario();
                        $perfilUsuario->setObjeto('Usuario',$usuarioId);
                        $arrPerfilUsuario = $perfilUsuario->consultar();

                        if(count($arrPerfilUsuario) > 0){
                            $perfilDescUsuario = $arrPerfilUsuario[0]->getObjeto('Perfil')->getAtributo('perfil_desc');
                            $objResponse->addScriptCall('selectManual','ficha_pers_perfil',$perfilDescUsuario);
                        }
                    }

                    $objResponse->addAssign('ficha_pers_id'       ,'value',$persId);
                    $objResponse->addAssign('ficha_pers_carne'    ,'value',$persCarne);
                    $objResponse->addAssign('ficha_pers_cedula'   ,'value',$perCedula);
                    $objResponse->addAssign('ficha_pers_nombre'   ,'value',$persNombre);
                    $objResponse->addAssign('ficha_pers_apellido' ,'value',$persApellido);
                    $objResponse->addAssign('ficha_pers_cargo'    ,'value',$persCargo);
                    $objResponse->addAssign('ficha_pers_foto'     ,'src',$persFoto);
                    $objResponse->addScriptCall('gestBtnFichaPers',1);
                    $objResponse->addScriptCall('gestCmpFichaPers',1);
                }
            }
            else{
                $objResponse->addAlert(utf8_decode('Carné no encontrado. Verifique los datos e intente nuevamente.'));
                $objResponse->addScriptCall('limpiarFichaPersonal');
            }

            return $objResponse;
        }
    // --------------------------------------------------------------------------------- //
?>