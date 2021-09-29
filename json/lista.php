<?php
    $rutaDir = '../';
    include_once $rutaDir.'config.php';

    isset($_GET['case']) ? $case = $_GET['case'] : $case = null;

    switch($case){
        case 'estPabx':
            isset($_GET['estId']) ? $estId = $_GET['estId'] : $estId = null;

            $objeto     = new EstructuraPabx();
            $objeto     -> setObjeto('Estructura',$estId);
            $arreglo    = $objeto->consultar();

            if(count($arreglo)>0){
                foreach ($arreglo as $i=>$dato){
                    $contenido['id']= $dato->getAtributo('rel_est_pabx_id');
                    $contenido[0]	= ++$i;
                    $contenido[1]   = $dato->getAtributo('pabx');
                    $data[]         = $contenido;
                }
            }
			else $data = cargarFilaVacia(2,'json');
        break;
        case 'estPers':
            isset($_GET['estId']) ? $estId = $_GET['estId'] : $estId = null;

            $objeto     = new PersonalEstructura();
            $objeto     -> setObjeto('Estructura',$estId);
            $arreglo    = $objeto->consultar();
            $conexion   = new ConexionBd('sictra');

            if(count($arreglo)>0){
                foreach ($arreglo as $i=>$dato){

                    $persId = $dato->getAtributo('pers_id');
                    
                    $personal = new Personal();
                    $arrPers = $personal->buscarPersonal($persId);

                    $nombre = explode(' ',$arrPers[0]['nombre']);
                    $nombre = $nombre[0];
                    $apellido = explode(' ',$arrPers[0]['apellido']);
                    $apellido = $apellido[0];

                    $contenido['id']= $dato->getAtributo('pers_id');
                    $contenido[0]	= ++$i;
                    $contenido[1]   = $arrPers[0]['carne'];
                    $contenido[2]   = $nombre." ".$apellido;
                    $contenido[3]   = $arrPers[0]['cargo'];
                    $contenido[4]   = $dato->getAtributo('pabx');
                    $data[]         = $contenido;
                    unset($personal);
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