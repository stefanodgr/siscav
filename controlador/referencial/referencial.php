<?php
	$rutaDir = "../../";
	include_once $rutaDir.'config.php';

    $ctrlAcceso = validarConexion();

	if($ctrlAcceso){
        $TBS = new clsTinyButStrong;

        isset($_GET['case'])    ? $case     = $_GET['case']     : $case     = null;
        isset($_GET['estId'])   ? $estId    = $_GET['estId']    : $estId    = null; 

        $perfilUsuario = $_SESSION['PerfilUsuario'];
   
        switch($case){
            case 0:
                $titulo = 'Datos Generales: Estructura';

                $vista = $rutaDir.'vista/referencial/estructura.tpl';
                $TBS->LoadTemplate($vista);	
            break;
            case 1:	
                isset($_GET['estado']) ? $estado = $_GET['estado'] : $estado = null;

                if($estado == 'inicial'){
                    unset($estado);
                    $titulo = 'Datos Generales: Usuarios';
                    $rutaReferencial = 'controlador/referencial/referencial.php?case='.$case;
                    $vista = $rutaDir.'vista/referencial/usuario.tpl';
                    $TBS->LoadTemplate($vista);
                }
                else{
                    $descTabla 		= 'Listado de Usuarios';
                    $siglas 		= 'usu';
                    $encabezado		= array('Login / Carné','Nombre','Cargo','Sede','Perfil','Id Personal');

                    if($perfilUsuario == 'SISTEMAS') $visible = array('','','','','','','false');
                    else $visible = array('','','','','','false','false');
                   
                    $ctrlFuncion	= true;
                    $ctrlBtnTipo 	= 'E';
                    $opcDtbInf 		= false;
                    
                    $dtsTbl 		= crearDtsTbl($siglas,$encabezado,null,null,null,null,null,$visible);
                    $opcDtbPag 		= true;				
                    $opcDtbPagTyp 	= 'full_numbers';
                    $opcDtbFil 		= true;				
                    $opcDtbCanFil 	= 10;
                 
                    $rutaJson 	= $rutaDir.'json/referencial.php?case=0';
                    $vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';

                    $TBS -> LoadTemplate($vista);
                    $TBS -> MergeBlock('dtsTbl',$dtsTbl);
                }
            break;
            case 2:
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
                $opcDtbFil 		= false;			
                $opcDtbInf 		= false;			
                $opcDtbCanFil 	= 10;					
                $sWSearch 		= 100;
                
                $vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';
                $rutaJson 	= $rutaDir.'json/lista.php?case=estPers&estId='.$estId;

                $TBS -> LoadTemplate($vista);
                $TBS -> MergeBlock('dtsTbl',$dtsTbl);
            break;
            case 3: // FICHA DE PERSONAL
                isset($_GET['modulo']) ? $modulo = $_GET['modulo'] : $modulo = null;

                if($modulo == 'estructura'){
                    $ctrlEstAct = '';
                    $ctrlPabx   = '';
                    $ctrlSede   = 'oculto';
                    $ctrlPerfil = 'oculto';
                }
                if($modulo == 'usuario'){
                    $ctrlEstAct = 'oculto';
                    $ctrlPabx   = 'oculto';
                    $ctrlSede   = '';
                    $ctrlPerfil = '';
                }

                $sede = new Estructura();
                $arreglo = $sede->consultarEstructura(1);
                unset($sede);
                $i=1;
                $sede[0]['id'] 		= 0;		
                $sede[0]['codigo'] 	= '- Seleccione -';

                foreach ($arreglo as $fila){
                    $sede[$i]['id'] 		= $fila["id"];		
                    $sede[$i]['codigo'] 	= utf8_encode($fila["sigla"]);
                    $i++;
                }
                unset($arreglo);

                $perfil = new Perfil();
                $arreglo = $perfil->consultar();
                unset($perfil);

                $j=1;
                $perfil[0]['id'] 		= 0;		
                $perfil[0]['codigo'] 	= '- Seleccione -';
                
                foreach ($arreglo as $fila){
                    $perfil[$j]['id'] 		= $fila->getAtributo("perfil_id");		
                    $perfil[$j]['codigo'] 	= utf8_encode($fila->getAtributo("perfil_desc"));
                    $j++;
                }
                unset($arreglo);

                $vista 	= $rutaDir.'vista/referencial/ficha_personal.tpl';
                $TBS -> LoadTemplate($vista);
                $TBS -> MergeBlock('sede',$sede);
                $TBS -> MergeBlock('perfil',$perfil);
            break;
            case 4:
                // echo($estId);
                $descTabla 		= 'Listado de PABX';
                $nombreTabla	= "rel_estructura_pabx";
                $idTabla        = 'rel_est_pabx_id';
                $tipoCampoPk	= 'serial';
                $siglas 		= 'tel';
                $encabezado		= array('PABX');
                $columna 	    = array('pabx');					
                $tipo 		    = array('text');
                $formato	    = array('num');
                $ctrlFuncion	= true;	
                $ctrlBtnTipo    = 'A';      

                $cmpExtTbl 	= 'est_id';
                $valExtTbl	= $estId;

                $dtsTbl 		= crearDtsTbl($siglas,$encabezado,$columna,$tipo,$formato);

                $opcDtbPag 		= true;				
                $opcDtbPagTyp 	= 'simple_numbers';
                $opcDtbFil 		= false;			
                $opcDtbInf 		= false;			
                $opcDtbCanFil 	= 10;					
                $sWSearch 		= 100;
                
                $vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';
                $rutaJson 	= $rutaDir.'json/lista.php?case=estPabx&estId='.$estId;

                $TBS -> LoadTemplate($vista);
                $TBS -> MergeBlock('dtsTbl',$dtsTbl);
            break;
        }
        $TBS->Show();
    }
?>