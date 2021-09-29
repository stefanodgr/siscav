<?php
	$rutaDir = "../../";
	include_once $rutaDir.'config.php';
	
	$ctrlAcceso = validarConexion();
 
	if($ctrlAcceso){
		$TBS = new clsTinyButStrong;

		$perfilUsuario = $_SESSION['PerfilUsuario'];

		isset($_GET['case']) 		? $case 	= $_GET['case'] 	: $case 	= 0;
		isset($_GET['lista']) 		? $lista 	= $_GET['lista'] 	: $lista 	= null;
		isset($_GET['infId']) 		? $infId 	= $_GET['infId'] 	: $infId 	= null;
		isset($_GET['infNombre']) 	? $infNombre= $_GET['infNombre']: $infNombre= null;

		$titulo = 'Visitantes';

		switch($case){
			case 0:
				$vista = $rutaDir.'vista/visitante/visitante.tpl';
				$TBS->LoadTemplate($vista);
			break;
			case 1:
				$descTabla 		= 'Registro de Visitas';
				$siglas 		= 'exp';
				$encabezado		= array('Cod. Visita','Sede','Area','Tipo','Observación','Fecha Entrada','Fecha Salida','Registrado por');
				$ctrlFuncion	= true;	
				$dtsTbl 		= crearDtsTbl($siglas,$encabezado);

				$opcDtbPag 		= true;				
				$opcDtbPagTyp 	= 'full_numbers';
				$opcDtbFil 		= true;			
				$opcDtbInf 		= true;			
				$opcDtbCanFil 	= 10;
				// $sWTitulo 		= 60;	
				// $sWSearch 		= 40;
				
				$vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';
				$rutaJson 	= $rutaDir.'json/visitante.php?case=0&infId='.$infId;

				$TBS -> LoadTemplate($vista);
				$TBS -> MergeBlock('dtsTbl',$dtsTbl);
			break;
			case 2:
				if(is_array($lista)) $lista = implode(',',$lista);
				else $lista = $lista;

				$descTabla 		= 'Seleccione una persona de la lista:';
				$siglas 		= 'lis';
				$encabezado		= array('Cédula','Nombre','Apellido');
				$ctrlFuncion	= true;	
				$ctrlBtnTipo 	= 'C';
				$dtsTbl 		= crearDtsTbl($siglas,$encabezado);

				$opcDtbPag 		= true;				
				$opcDtbPagTyp 	= 'full_numbers';
				$opcDtbFil 		= true;			
				$opcDtbInf 		= false;			
				$opcDtbCanFil 	= 10;
				// $sWTitulo 		= 60;	
				// $sWSearch 		= 40;
				
				$vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';
				$rutaJson 	= $rutaDir.'json/visitante.php?case=1&lista='.$lista;

				$TBS -> LoadTemplate($vista);
				$TBS -> MergeBlock('dtsTbl',$dtsTbl);
			break;
		}
		$TBS->Show();
	}
?>