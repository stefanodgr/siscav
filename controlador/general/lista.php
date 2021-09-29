<?php
	$rutaDir = "../../";
	include_once $rutaDir.'config.php';

    $ctrlAcceso = validarConexion();

	if($ctrlAcceso){
        $TBS = new clsTinyButStrong;

        isset($_GET['case']) ? $case = $_GET['case'] : $case = null;   
        
        switch($case){
            case 'arbol':
                isset($_GET['estId'])       ? $estId        = $_GET['estId']        : $estId        = null; 
                isset($_GET['tipoArbol'])   ? $tipoArbol    = $_GET['tipoArbol']    : $tipoArbol    = null; 

                if($_SESSION['PerfilUsuario'] == 'SISTEMAS') $estId = null;
                $rastro = $_SESSION['rastro_estructura'];
                unset($_SESSION['rastro_estructura']);

                if($tipoArbol == 'estructura') $accionNodo = 'cargarFicha(this.parentNode.id)';
                if($tipoArbol == 'lista_estructura') $accionNodo = 'marcarEstructura(this.parentNode.id, this.innerHTML)';

                $estructura = new Estructura();
                $arrEstructura = $estructura->consultarEstructura(null,$estId);
                unset($estructura);
                
                foreach ($arrEstructura as $a) {
                    $padres[] = $a['padre'];
                } 

                foreach($padres as $b) $arrPadres = compValArr($arrPadres, $b);
                // echo("asas");
                foreach($tipos as $c) $arrTipos = compValArr($arrTipos, $c);
                foreach ($arrPadres as $d) {
                    foreach($arrEstructura as $e){
                        if($d==$e['padre']){
                            $grupoPadres[]= array(
                                id 			=> trim($e['id']),
                                codigo 		=> trim($e['sigla']),
                                descripcion => trim($e['descripcion']),
                                padre 		=> trim($e['padre']),
                                pabx 		=> trim($e['pabx']),
                                rel_pabx	=> trim($e['rel_pabx'])
                            );
                        }
                    }
                    $estructura[]=$grupoPadres;
                    unset($grupoPadres);
                }
                for($i=0; $i<count($estructura); $i++){
                    for($j=0; $j<count($estructura[$i]); $j++){
                        $arrPosPadre[] = array("idPadre"=>$estructura[$i][$j]['id'],"fil"=>$i,"col"=>$j); 
                    }
                }
                for($i=count($arrPadres); $i>0; $i--){
                    $control = false;
                    for($j=0; $j<count($estructura); $j++){
                        for($k=0; $k < count($estructura[$j]); $k++){
                            if($estructura[$j][$k]['padre'] == $arrPadres[$i]){
                                // echo("Hijo de padre: ".$arrPadres[$i]." encontrado en la posicion: ".$j."--".$k."<br>");
                                $grupoHijos[] = $estructura[$j][$k];
                                if($control == false){
                                    $idPadre = $arrPadres[$i];
                                    $control = true;
                                }
                            }
                        }
                    }
                    foreach($arrPosPadre as $a) if($a['idPadre']==$idPadre) $estructura[$a['fil']][$a['col']]['hijo'] = $grupoHijos;
                    unset($grupoHijos);
                }
                
                $arbol = $estructura[0];

                $vista = $rutaDir.'vista/general/arbol.tpl';
                $TBS->LoadTemplate($vista);	
                $TBS->MergeBlock('arbol',$arbol);
            break;
            case 'estPers':
                isset($_GET['estId'])   ? $estId    = $_GET['estId']    : $estId    = null; 
                isset($_GET['tipo'])    ? $tipo     = $_GET['tipo']     : $tipo     = null; 

                $descTabla 		= 'Listado de Personal del Área';
                $siglas 		= 'pes';
                $encabezado		= array('Carné','Nombre','Cargo','PABX',);
                $ctrlFuncion	= true;

                if($tipo == 'lista') $ctrlBtnTipo = 'C'; 
                else $ctrlBtnTipo = 'E'; 

                $cmpExtTbl 	= 'est_id';
                $valExtTbl	= $estId;

                $dtsTbl 		= crearDtsTbl($siglas,$encabezado);

                $opcDtbPag 		= true;				
                $opcDtbPagTyp 	= 'simple_numbers';
                $opcDtbFil 		= true;			
                $opcDtbInf 		= false;			
                $opcDtbCanFil 	= 10;					
                $sWSearch 		= 100;
                
                $vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';
                $rutaJson 	= $rutaDir.'json/lista.php?case=estPers&estId='.$estId;

                $TBS -> LoadTemplate($vista);
                $TBS -> MergeBlock('dtsTbl',$dtsTbl);
            break;
        }
        
        $TBS->Show();
    }
?>