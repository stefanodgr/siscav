<?php
    // -------------------------- REGISTRO DE FUNCIONES XAJAX -------------------------- //
        $xajax->registerFunction('buscarVisita');
        $xajax->registerFunction('registrarVisita');
        $xajax->registerFunction('procesarSalida');
        $xajax->registerFunction('buscarVisitante');
    // --------------------------------------------------------------------------------- //

    // -------------------------------- FUNCIONES XAJAX -------------------------------- //
        function buscarVisita($visitaId){
            global $objResponse;
            $objResponse->addScriptCall(limpiarFichaVisitante);
            $visita = new Visita();
            $arrVisita = $visita->buscarVisita($visitaId);
            
            if(is_array($arrVisita)){
                $stringCed  = $arrVisita[0]["cedula"];
                $arrCed     = str_split($stringCed);
                $vteNac     = $arrCed[0];

                foreach($arrCed as $i=>$caracter) if($i !=0 ) $vteCedula .= $caracter; 

                $visId 	        = $arrVisita[0]["id"];
                $vteId 	        = $arrVisita[0]["id_vte"];
                $persId 	    = $arrVisita[0]["pers_id"] ? $arrVisita[0]["pers_id"] : 0;
                $visCod	        = $arrVisita[0]["codigo"];
                $visFechaInic	= formFechaHora($arrVisita[0]["fecha_ini"]);
                $visFechaFin	= formFechaHora($arrVisita[0]["fecha_fin"]);
                $vteNombre	    = utf8_decode($arrVisita[0]["nombre"]);
                $vteApellido    = utf8_decode($arrVisita[0]["apellido"]);
                $vteOrganiz     = utf8_decode($arrVisita[0]["organización"]);
                $vteFoto        = utf8_decode($arrVisita[0]["foto"]);
                $visRecibe      = utf8_decode($arrVisita[0]["personal"]);
                $visObserv      = utf8_decode($arrVisita[0]["observacion"]);
                $visArea        = utf8_decode($arrVisita[0]["area"]);
                $visTipo	    = $arrVisita[0]["tipo"];
                $visReg	        = formFechaHoraSegundo($arrVisita[0]["fecha_reg"]);
                $visUsu	        = $arrVisita[0]["usuario"];
                $listaNegraId	= $arrVisita[0]["id_lista"];

                if($persId != 0){
                    $personal       = new Personal();
                    $arrPersonal    = $personal->buscarPersonal($persId);
                    $vteCarne       = $arrPersonal[0]['carne'];
                    $vteFoto        = gestionArchivo('consultar','../sictra/fotos/'.$stringCed);
                }
                else{
                    $vteCarne = 'NO APLICA';

                    if($vteFoto == 't'){
                        if($persId == 0) $vteFoto = gestionArchivo('consultar','multimedia/imagen/visitante/'.$stringCed);
                    }
                    else $vteFoto = 'multimedia/imagen/visitante/siluetaHombre.png';
                }

                $objResponse->addAssign('filt_visita_id'    ,'value',$visId);
                $objResponse->addAssign('filt_vte_id'       ,'value',$vteId);
                $objResponse->addAssign('filt_pers_id'      ,'value',$persId);
                $objResponse->addAssign('filt_visita_cod'   ,'value',$visCod);
                $objResponse->addAssign('filt_usuario'      ,'value',$visUsu);
                $objResponse->addAssign('filt_registro'     ,'value',$visReg);
                $objResponse->addAssign('filt_cedula'       ,'value',$vteCedula); 
                $objResponse->addAssign('filt_carne'        ,'value',$vteCarne); 
                $objResponse->addAssign('filt_nombre'       ,'value',$vteNombre);
                $objResponse->addAssign('filt_apellido'     ,'value',$vteApellido);
                $objResponse->addAssign('filt_foto'         ,'src'  ,$vteFoto);
                $objResponse->addAssign('filt_org'          ,'value',$vteOrganiz);
                $objResponse->addAssign('filt_area'         ,'value',$visArea); 
                $objResponse->addAssign('filt_recibe'       ,'value',$visRecibe);
                $objResponse->addAssign('filt_descripcion'  ,'value',$visObserv);
                $objResponse->addScriptCall(selectManual,'filt_tipo',$visTipo);
                $objResponse->addScriptCall(selectManual,'filt_nac',$vteNac);

                if($listaNegraId) $objResponse->addScriptCall('infAcceso',2);
                else $objResponse->addScriptCall('infAcceso',1);

                if($visFechaFin) $objResponse->addScriptCall('gestionBtnSalida',0);
                else $objResponse->addScriptCall('gestionBtnSalida',1);
            }
            return $objResponse;
        }
        function registrarVisita($vteId,$persId,$vteCedula,$vteCarne,$vteNombre,$vteApellido,$vteOrg,$sede,$area,$persVis,$tipoVis,$obsVis,$vteFoto){
            global $objResponse;

            $estructura = new Estructura();
            $arrEst = $estructura->obtenerRutaEstructura($area,'sede');

            $codSedeVta = $arrEst[1]['cod'];

            if($codSedeVta == $sede){
                if(!$vteId){
                    $visitante = new Visitante();
                    $visitante->setAtributo('visitante_cedula',$vteCedula);
                    $visitante->setAtributo('visitante_nombre',utf8_encode(strtoupper($vteNombre)));
                    $visitante->setAtributo('visitante_apellido',utf8_encode(strtoupper($vteApellido)));
    
                    if($vteOrg) $visitante->setAtributo('visitante_org',utf8_encode(strtoupper($vteOrg)));
    
                    if($persId){
                        $visitante->setAtributo('pers_id',$persId);
                        $visitante->setAtributo('visitante_foto','t');
                    }
                    else{
                        if($vteFoto != null){
                            $ctrlUpload = true;
                            $rutaFoto   = "multimedia/imagen/visitante/".$vteCedula.".jpeg";
                            $visitante->setAtributo('visitante_foto','t');
                        }
                    }
                    
                    $visitante->setObjeto('Conexion',$_SESSION['IdConexion']);
    
                    $ctrlVte = $visitante->registrar();
    
                    if($ctrlVte){
                        $vteId = $visitante->getAtributo('visitante_id');
    
                        if($ctrlUpload){
                            gestionArchivo('remover',null,null,$vteCedula);
                            gestionArchivo('subir',$rutaFoto,$vteFoto);
                        }
                    }
                    else{
                        $objResponse->addAlert(utf8_decode("ERROR1A: Comuníquese con el administrador del sistema."));
                        return $objResponse;
                    }
                }
    
                $visita = new Visita();
                $arrVisitaAct = count($visita->consultarVisitaActiva($vteId));
    
                if($arrVisitaAct == 0){
                    $fechaRegistro  = formatoFechaHoraBd();
                    $codVisita = generarCodVisita($codSedeVta);
    
                    $visita->setAtributo('visita_cod',$codVisita);
    
                    if($tipoVis == 1) $visita->setAtributo('visita_tipo','LABORAL');
                    if($tipoVis == 2) $visita->setAtributo('visita_tipo','PERSONAL');
    
                    $visita->setAtributo('visita_fecha_ent' ,$fechaRegistro);
                    $visita->setAtributo('visita_observ'    ,utf8_encode(strtoupper($obsVis)));
    
                    if($persVis) $visita->setAtributo('pers_id',$persVis);
    
                    $visita->setObjeto('Visitante'  ,$vteId);
                    $visita->setObjeto('Estructura' ,$area);
                    $visita->setObjeto('Conexion'   ,$_SESSION['IdConexion']);
    
                    $ctrlVisita = $visita->registrar();
    
                    if($ctrlVisita) $objResponse->addScriptCall('confirmarOperacion');
                    else $objResponse->addAlert(utf8_decode("ERROR2A: Comuníquese con el administrador del sistema."));
                }
                else{
                    $objResponse->addAlert(utf8_decode("ERROR3A: La persona posee una visita sin fecha de salida definida."));
                }
            }
            else $objResponse->addAlert(utf8_decode("ERROR4A: Comuníquese con el administrador del sistema.")); // NO POSEE AUTORIZACIÓN PARA ASIGNAR VISITAS A ESTA SEDE

            return $objResponse;
        }
        function procesarSalida($arrVisita){
            global $objResponse;

            $fechaSalida  = formatoFechaHoraBd();

            foreach($arrVisita as $i=>$visitaId){
                $visita = new Visita(null,$visitaId);
                $visita->setAtributo('visita_fecha_sal',$fechaSalida);
                $ctrlSalida = $visita->modificar();

                if(!$ctrlSalida){
                    $objResponse->addAlert(utf8_decode("ERROR1B: Comuníquese con el administrador del sistema."));
                    return $objResponse;
                }
                else{
                    $objResponse->addScriptCall('confirmarOperacion');
                }
                unset($visita);
            }
            return $objResponse;
        }
        function buscarVisitante($valorBusq,$tipo,$modulo){
            global $objResponse;

            $ctrlExiste = false;
            $ctrlPers   = false;
            
            if($tipo == 'cedula'){
                $visitante = new Visitante();
                $arrVte = $visitante->buscarVisitante(null,$valorBusq);     // BÚSQUEDA DE INVOLUCRADO EN TABLA INVOLUCRADO
                unset($visitante);

                if(count($arrVte) > 0){     // SI LA PERSONA FUE UBICADA EN LA TABLA VISITANTE
                    $ctrlExiste = true;

                    $vteId          = $arrVte[0]['id'];
                    $vteCedula      = $valorBusq;
                    $vteNombre      = utf8_decode($arrVte[0]['nombre']);
                    $vteApellido    = utf8_decode($arrVte[0]['apellido']);
                    $vteTelefono    = $arrVte[0]['telefono'];
                    $vteOrg         = utf8_decode($arrVte[0]['organizacion']);
                    $persId         = $arrVte[0]['metro'];
                    $vteFoto        = $arrVte[0]['foto'];
                    $listaNegraId   = $arrVte[0]['lista'];
    
                    if($persId){
                        $ctrlPers       = true;
                        $personal       = new Personal();
                        $arrPersonal    = $personal->buscarPersonal($persId);
                        $vteCarne       = $arrPersonal[0]['carne'];
                        $vteFoto        = gestionArchivo('consultar','../sictra/fotos/'.$valorBusq);
                    }
                    else{
                        if($vteFoto == 't') $vteFoto = gestionArchivo('consultar','multimedia/imagen/visitante/'.$valorBusq);
                        else $vteFoto = 'multimedia/imagen/visitante/siluetaHombre.png';
                    }
                }
                else $verifPers = true;
            }

            if(($tipo == 'carne') || ($verifPers == true)){     // SI LA BÚSQUEDA ES POR CARNÉ O SI ES POR CÉDULA PERO ESTA NO SE ENCUENTRA EN LA TABLA VISITANTE
                
                $personal = new Personal();

                if($tipo == 'carne') $arrPers =  $personal->buscarPersonal(null,null,$valorBusq);   // BÚSQUEDA DE PERSONAL POR CARNÉ EN TABLA PERSONAL
                else $arrPers =  $personal->buscarPersonal(null,$valorBusq);                        // BÚSQUEDA DE PERSONAL POR CÉDULA EN TABLA PERSONAL

                if(count($arrPers) > 0){
                    $ctrlExiste = true;
                    $ctrlPers   = true;

                    $persId         = $arrPers[0]['id'];
                    $vteCedula      = $arrPers[0]['cedula'];
                    $vteNombre      = utf8_decode($arrPers[0]['nombre']);
                    $vteApellido    = utf8_decode($arrPers[0]['apellido']);
                    $vteTelefono    = $arrPers[0]['telefono'];
                    $vteOrg         = 'C.A METRO DE CARACAS';
                    $vteCarne       = $arrPers[0]['carne'];
                    $vteCargo       = $arrPers[0]['cargo'];
                    $vteFoto        = gestionArchivo('consultar','../sictra/fotos/'.$vteCedula); 

                    $visitante  = new Visitante();
                    unset($arrVte);
                    $visitante  -> setAtributo('pers_id',$persId);
                    $arrVte     = $visitante->consultar();
                    if(count($arrVte)>0) {
                        $vteId = $arrVte[0]->getAtributo('visitante_id');
                        unset($arrVte);                        
                    }
                    else $vteId = 0;
                }
            }  

            if($ctrlExiste){    // SI LA PERSONA FUE ENCONTRADA EN TABLA VISITANTE O PERSONAL
                $string = str_split($vteCedula);
                $vteNac = $string[0];
                unset($vteCedula);
                foreach($string as $i=>$caracter) if($i !=0 ) $vteCedula.=$caracter;
                
                $objResponse->addScriptCall('selectManual'  ,'filt_nac',$vteNac);
                $objResponse->addAssign('filt_cedula'       ,'value',$vteCedula);                    
                $objResponse->addAssign('filt_vte_id'       ,'value',$vteId); 
                $objResponse->addAssign('filt_pers_id'      ,'value',$persId);
                $objResponse->addAssign('filt_nombre'       ,'value',$vteNombre);
                $objResponse->addAssign('filt_apellido'     ,'value',$vteApellido);
                $objResponse->addAssign('filt_org'          ,'value',$vteOrg);
                $objResponse->addAssign('filt_foto'         ,'src',$vteFoto);

                $ctrlPers ? $objResponse->addAssign('filt_carne','value',$vteCarne) : $objResponse->addAssign('filt_carne','value',"NO APLICA");
                
                $listaNegra = new ListaNegra();
                $listaNegra->setObjeto('Visitante',$vteId);
                $arrListaNegra = $listaNegra->consultar();

                if(count($arrListaNegra) > 0){
                    $divEtiquetObserv   = utf8_decode($arrListaNegra[0]->getAtributo('lista_negra_observ'));
                    $fechaObserv        = formFecha($arrListaNegra[0]->getObjeto('Conexion')->getAtributo('conexion_fecha_ini'));
                    $listaNegraId       = $arrListaNegra[0]->getAtributo('lista_negra_id');
                    $objResponse->addAssign('filt_restriccion'  ,'name' ,$listaNegraId);                        // OBSERVACIONES DE LA LISTA NEGRA
                    $objResponse->addAssign('filt_restriccion'  ,'value',$fechaObserv.": ".$divEtiquetObserv);  // OBSERVACIONES DE LA LISTA NEGRA                        
                }
                
                if($listaNegraId){
                    $objResponse->addScriptCall('camposVisita',0);
                    $objResponse->addScriptCall('infAcceso',2);
                    $objResponse->addScriptCall('gestionBtnAceptarVisita',0);
                }
                else{
                    $objResponse->addScriptCall('camposVisita',1);
                    $objResponse->addScriptCall('infAcceso',1);
                    $objResponse->addScriptCall('gestionBtnAceptarVisita',1);
                }
            }
            else{   // SI LA PERSONA NO FUE ENCONTRADA EN NINGUNA TABLA
                if($tipo == 'cedula'){
                    $objResponse->addAlert(utf8_decode('Cédula no encontrada. Ingrese los datos del visitante y presione el botón Procesar.'));
                    $objResponse->addScriptCall('camposVisita',2);
                    $objResponse->addAssign('filt_carne','value',"NO APLICA");
                    $objResponse->addScriptCall('gestionBtnAceptarVisita',1);
                }
                if($tipo == 'carne'){
                    $objResponse->addAlert(utf8_decode('Carné no encontrado. Verifique los datos e intente nuevamente.'));
                    $objResponse->addScriptCall('camposVisita',0);
                }
                
                $objResponse->addScriptCall('infAcceso',0);
            }

            return $objResponse;
        }
    // --------------------------------------------------------------------------------- //
?>