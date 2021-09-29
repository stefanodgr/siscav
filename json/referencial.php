<?php
    $rutaDir = '../';
    include_once $rutaDir.'config.php';

    isset($_GET['case']) ? $case = $_GET['case'] : $case = null;

    switch($case){
        case 0:
            $usuario  = new Usuario();
            $arrUsu  = $usuario->listaUsuarios($sede,$filtros);
            //file_put_contents(RUTA_SISTEMA."log/usuario.txt", $arrUsu);
            if(count($arrUsu)>0){
                foreach ($arrUsu as $i=>$registro){
                    $contenido['id'] 	= $registro["id"];
                    $contenido[0]		= ++$i;
                    $contenido[1]		= $registro["login"];
                    $contenido[2]		= $registro["nombre"];
                    $contenido[3]		= $registro["cargo"];
                    $contenido[4]		= $registro["sede_sigla"];
                    $contenido[5]		= $registro["perfil"] ? $registro["perfil"] : 'NO ASIGNADO';
                    $contenido[6]		= $registro["pers_id"];
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