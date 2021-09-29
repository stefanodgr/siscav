<?php
    $rutaDir = '../';
    include_once $rutaDir.'config.php';

    isset($_GET['case']) ? $case = $_GET['case'] : $case = null;

    switch($case){
        case 0:
            isset($_GET['infId']) ? $infId = $_GET['infId'] : $infId = null;
            
            $visitante    = new Visitante();
			$arrVisitante = $visitante->consultarHistorial($infId,'procesado');
			
			if(count($arrVisitante)>0){
				foreach ($arrVisitante as $i=>$infrac){
                    $contenido['id'] 	= $infrac["id"];
                    $contenido[0]		= ++$i;
                    $contenido[1]		= $infrac["codigo"];
                    $contenido[2]		= $infrac["sede"];
                    $contenido[3]		= $infrac["area"];
                    $contenido[4]		= $infrac["tipo"];
                    // $contenido[5]		= 'recibe';
                    $contenido[5]		= $infrac["observacion"];
                    $contenido[6]		= formFechaHora($infrac["entrada"]);
                    $contenido[7]		= $infrac["salida"] ? formFechaHora($infrac["salida"]) : 'NO REGISTRADA';
                    $contenido[8]		= $infrac["usuario"];
                    $data[]             = $contenido;
				}
			}
			else $data = 0;
        break;
        case 1:
            isset($_GET['lista']) ? $lista = $_GET['lista'] : $lista = null;
            
            $conexionBd = new ConexionBd();

			$strSelect  = "visitante_id as id,
                        visitante_cedula AS cedula,
						visitante_nombre AS nombre,
						visitante_apellido AS apellido";
        	$strFrom    = "visitante";
			$strWhere 	= "visitante_id IN (".$lista.")";
            $strOrderBy	= "visitante_apellido";

            $arrVisitante = $conexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy);

            if(count($arrVisitante)>0){
				foreach ($arrVisitante as $i=>$visitante){
                    $contenido['id'] 	= $visitante["id"];
                    $contenido[0]		= ++$i;
                    $contenido[1]		= $visitante['cedula'];
                    $contenido[2]		= $visitante['nombre'];
                    $contenido[3]		= $visitante["apellido"];
                    $contenido[4]		= $visitante["alias"];
                    $contenido[5]		= $visitante["banda"];
                    $data[]             = $contenido;
				}
			}
			else $data = 0;
        break;
    }
    
	$arrJson[data] = $data;
    // echo("<pre>");
    // print_r($arrJson);
    // echo("</pre>");
    $json = json_encode($arrJson);
    echo($json);
?>