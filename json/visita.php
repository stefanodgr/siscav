<?php
    $rutaDir = '../';
    include_once $rutaDir.'config.php';

    isset($_GET['case'])            ? $case         = $_GET['case']         : $case = null;
    isset($_GET['idInfraccion']) 	? $idInfraccion = $_GET['idInfraccion'] : $idInfraccion = null;

    switch($case){
        case 0:
            isset($_GET['tipo'])    ? $tipo     = $_GET['tipo']     : $tipo     = null;
            isset($_GET['filtros']) ? $filtros  = $_GET['filtros']  : $filtros  = null;
            

            $visita  = new Visita();
            $arrVis  = $visita->listaVisitas($tipo,$filtros);
			
			if(count($arrVis)>0){
				 foreach ($arrVis as $i=>$registro){
                    $contenido['id'] 	= $registro["id"];
                    $contenido[0]		= ++$i;
                    $contenido[1]		= $registro["codigo"];
                    $contenido[2]		= $registro["sede"];
                    $contenido[3]		= $registro["area"];
                    $contenido[4]		= $registro["tipo"];
                    $contenido[5]		= $registro["cedula"];
                    // $contenido[6]		= $registro["personal"];
                    $contenido[6]		= $registro["observacion"];
                    $contenido[7]		= formFechaHora($registro["entrada"]);
                    $contenido[8]		= $registro["salida"] ? formFechaHora($registro["salida"]) : 'NO REGISTRADA';
                    $contenido[9]		= $registro["usuario"];
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