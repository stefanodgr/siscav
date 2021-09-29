<?php
	$rutaDir = "../../";
	include_once $rutaDir.'config.php';

	$ctrlAcceso = validarConexion();

	if($ctrlAcceso){
		isset($_GET['case']) 			? $case 		= $_GET['case'] 		: $case 		= null;

		$perfilUsuario = $_SESSION['PerfilUsuario'];

		$TBS = new clsTinyButStrong;
		
		$titulo = 'Visitas';
		
		switch($case){
			case 0:
				(($perfilUsuario == "SUPERVISOR") || ($perfilUsuario == "SISTEMAS"))  ? $ctrlReporteLista 	= '' : $ctrlReporteLista = 'oculto';

				$estructura 	= new Estructura();
				$estructura 	->setAtributo('est_padre_id',1); // PARA CONSULTAR SÓLO LAS SEDES
				$arrEstructura 	= $estructura->consultar();
				unset($estructura);
				
				foreach ($arrEstructura as $i=>$registro){
					$sede[$i]['id'] 	= $registro->getAtributo('est_id');
					$sede[$i]['sigla'] 	= $registro->getAtributo('est_sigla');
				}

				$vista = $rutaDir.'vista/visita/visita.tpl';

				$TBS->LoadTemplate($vista);
				$TBS->MergeBlock('sede',$sede);
			break;
			case 1:	
				isset($_GET['tipo']) 	? $tipo 	= $_GET['tipo'] 	: $tipo 	= null;
				isset($_GET['filtros']) ? $filtros 	= $_GET['filtros'] 	: $filtros 	= null;

				$descTabla 		= 'Listado de Visitas';
				$siglas 		= 'vta';
				$encabezado		= array('Cód. Visita','Sede','Área','Tipo','Visitante','Observación','Fecha Entrada','Fecha Salida','Registrado por');

				if($_SESSION['PerfilUsuario'] == 'CONSULTA'){
					$ctrlFuncion= false;
					$opcDtbInf 	= true;
				}
				else{
					$ctrlFuncion	= true;
					$ctrlBtnTipo 	= 'E';
					$opcDtbInf 		= false;
				}
				
				$dtsTbl 		= crearDtsTbl($siglas,$encabezado);
				$opcDtbPag 		= true;				
				$opcDtbPagTyp 	= 'full_numbers';
				$opcDtbFil 		= true;				
				$opcDtbCanFil 	= 10;

				switch($tipo){
					case 'inicial':
						$rutaJson 	= $rutaDir.'json/visita.php?case=0&tipo='.$tipo;
					break;
					case 'filtros':
						$rutaJson 	= $rutaDir.'json/visita.php?case=0&tipo='.$tipo.'&filtros='.$filtros;
					break;
				}

				$vista 		= $rutaDir.'libreria/hg/hg_dtb_json.tpl';

				$TBS -> LoadTemplate($vista);
				$TBS -> MergeBlock('dtsTbl',$dtsTbl);
			break;
		}
		$TBS->Show();
	}
?>