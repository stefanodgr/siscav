<?php
    // -------------------------- REGISTRO DE FUNCIONES XAJAX -------------------------- //
        $xajax->registerFunction('buscarVisitanteFiltro');
        $xajax->registerFunction('agregarListaNegra');
        $xajax->registerFunction('eliminarListaNegra');
    // --------------------------------------------------------------------------------- //

    // -------------------------------- FUNCIONES XAJAX -------------------------------- //
        function buscarVisitanteFiltro($vteId, $vteNac, $vteCed, $vteNombre, $vteApellido){
            global $objResponse;

            if($vteCed) $cedula = formatoCedula($vteNac, $vteCed);

            $visitante = new Visitante();
            $arrVisitante = $visitante->buscarVisitante($vteId, $cedula, $vteNombre, $vteApellido);

            if(count($arrVisitante) > 0){
                if(count($arrVisitante) == 1){
                    $vteId = $arrVisitante[0]['id'];
                    unset($arrVisitante);

                    $arrVisitante = $visitante->buscarVisitante($vteId);
                    
                    $vteId      = $arrVisitante[0]['id'];
                    $vteNombre  = utf8_decode($arrVisitante[0]['nombre']);
                    $vteApellido= utf8_decode($arrVisitante[0]['apellido']);
                    $vteTelf    = $arrVisitante[0]['telefono'];
                    $vteDirecc  = utf8_decode($arrVisitante[0]['direccion']);
                    $vteOrg     = utf8_decode($arrVisitante[0]['organizacion']);
                    $vteMetro   = utf8_decode($arrVisitante[0]['metro']);
                    $vteFoto    = utf8_decode($arrVisitante[0]['foto']);

                    if($vteFoto == 't'){
                        if($vteMetro){
                            $vteFoto    = gestionArchivo('consultar','../sictra/fotos/'.$arrVisitante[0]['cedula']);
                            $vteOrg     = 'C.A METRO DE CARACAS';
                        }
                        else $vteFoto = gestionArchivo('consultar','multimedia/imagen/visitante/'.$arrVisitante[0]['cedula']);
                    }
                    else $vteFoto = 'multimedia/imagen/visitante/siluetaHombre.png';

                    if($vteMetro){
                        $personal       = new Personal();
                        $arrPersonal    = $personal->buscarPersonal($vteMetro);
                        $vteCarne       = $arrPersonal[0]['carne'];
                    }

                    $string     = str_split($arrVisitante[0]['cedula']);
                    $vteNac     = $string[0];

                    foreach($string as $i=>$caracter) if($i !=0 ) $vteCedula.=$caracter; 

                    $objResponse->addAssign('filt_id'           ,'value',$vteId);
                    $objResponse->addAssign('filt_nac'          ,'value',$vteNac);
                    $objResponse->addAssign('filt_cedula_vte'   ,'value',$vteCedula);
                    $objResponse->addAssign('filt_carne'        ,'value',$vteCarne);
                    $objResponse->addAssign('filt_nombre'       ,'value',$vteNombre);
                    $objResponse->addAssign('filt_apellido'     ,'value',$vteApellido);
                    $objResponse->addAssign('filt_telefono'     ,'value',$vteTelf);
                    $objResponse->addAssign('filt_direccion'    ,'value',$vteDirecc);
                    $objResponse->addAssign('filt_org'          ,'value',$vteOrg);
                    $objResponse->addAssign('filt_foto'         ,'src',$vteFoto); 

                    $expInfractor   = $visitante->consultarHistorial($vteId);
                    $cantVisitas    = count($expInfractor);
                    
                    $objResponse->addAssign('filt_visitas','value',$cantVisitas);   // CANTIDAD DE VISITAS REALIZADAS
                    $objResponse->addAssign('filt_ult_visita','value',formFechaHora($expInfractor[$cantVisitas - 1]['entrada'])); // ÚLTIMA VISITA

                    $listaNegra = new ListaNegra();
                    $listaNegra->setObjeto('Visitante',$vteId);
                    $arrListaNegra = $listaNegra->consultar();

                    if(count($arrListaNegra) > 0){
                        $objResponse->addScriptCall('gestionAcceso',2);
                        $divEtiquetObserv   = utf8_decode($arrListaNegra[0]->getAtributo('lista_negra_observ'));
                        $fechaObserv        = formFecha($arrListaNegra[0]->getObjeto('Conexion')->getAtributo('conexion_fecha_ini'));
                        $listaNegraId       = $arrListaNegra[0]->getAtributo('lista_negra_id');
                        $objResponse->addAssign('filt_restriccion','name'   ,$listaNegraId);   // OBSERVACIONES DE LA LISTA NEGRA
                        $objResponse->addAssign('filt_restriccion','value'  ,$fechaObserv.": ".$divEtiquetObserv);   // OBSERVACIONES DE LA LISTA NEGRA                        
                    }
                    else{
                        $objResponse->addScriptCall('gestionAcceso',1);                       
                    }
                    
                    // if($cantVisitas > 1){
                    //     $objResponse->addScriptCall(infReincidenciaInf,1);
                    // }
                    
                    $objResponse->addScriptCall('mostrarVisitante',$vteId,$vteNombre.' '.$vteApellido,$vteMetro);
                    $objResponse->addScript("$('#lblRestringido').removeClass('oculto');");
                    $objResponse->addScript("$('#filt_restringir').removeClass('oculto');");
                }
                else{
                    foreach($arrVisitante as $i=>$visitante) $lista[$i] = $visitante['id'];
                    $objResponse->addScriptCall('listaVisitante',$lista);
                }
            }
            else{
                $objResponse->addAlert(utf8_decode("No se encontró ningún registro que coincida con los datos suministrados."));
                $objResponse->addScript("$('#lblRestringido').addClass('oculto');");
                $objResponse->addScript("$('#filt_restringir').addClass('oculto');");              
            }
            return $objResponse;
        }  
        function agregarListaNegra($visit_id,$observ){
            global $objResponse;
            $IdConexion=$_SESSION['IdConexion'];
            $observ=strtoUpper($observ);

            $listaNegra = new ListaNegra();
            
            $listaNegra->setAtributo('lista_negra_observ',utf8_encode($observ));
            $listaNegra->setObjeto('Visitante',$visit_id);
            $listaNegra->setObjeto('Conexion', $IdConexion);
           
             $resultado = $listaNegra->registrar();

            if(!$resultado) $objResponse->addAlert(utf8_decode("ERROR1G: Comuníquese con el administrador del sistema."));

            return $objResponse;
        }
        function eliminarListaNegra($idListaNegra){
            global $objResponse;
            //$objResponse->addAlert("Procede Eliminar: Id=$idListaNegra" );
            $conexionBd = new ConexionBd();
            $strFrom    = 'lista_negra';
            $strWhere   = 'lista_negra_id = '.$idListaNegra;

            $resultado = $conexionBd->hacerDelete($strFrom,$strWhere);  

            if(!$resultado) $objResponse->addAlert(utf8_decode("ERROR1H: Comuníquese con el administrador del sistema."));
 
            return $objResponse;
        }
    // --------------------------------------------------------------------------------- //
?>