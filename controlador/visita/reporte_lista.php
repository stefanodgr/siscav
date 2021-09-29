<?php
    $rutaDir = "../../";
	include_once $rutaDir.'config.php';
    use Dompdf\Dompdf;

    $ctrlAcceso = validarConexion();

	if($ctrlAcceso){
        $query          = file_get_contents($rutaDir.'documento/txt/query_lista.txt');
        $conexionBd     = new ConexionBd();
        $listaVisitante = $conexionBd->hacerConsulta($query,true);
        $estructura     = new Estructura();

        foreach($listaVisitante as $i => $fila){
            $objeto = $estructura->obtenerRutaEstructura($fila['area_id'],'sede');
            $sede = $objeto[1]['cod'];
            $listaVisitante[$i]['sede'] = utf8_decode($sede);
            unset($objeto);
        }

        $colorFila = array('filaClara','filaOscura');
        $j=0;

        foreach($listaVisitante as $i=>$fila){
            $fechaEntrada   = $fila['entrada']  ? formFechaHora($fila['entrada'])   : 'NO REGISTRADA';
            $fechaSalida    = $fila['salida']   ? formFechaHora($fila['salida'])    : 'NO REGISTRADA';
            $contLista .= '<tr class="'.$colorFila[$j].'">';
            $contLista .= '<td style="text-align:center;">'.($i+1).'</td>';
            $contLista .= '<td><center>'.$fila['codigo'].'</center></td>';
            $contLista .= '<td>'.$fila['area'].'</td>';
            $contLista .= '<td><center>'.$fila['tipo'].'</center></td>';
            $contLista .= '<td>'.$fila['visitante'].'</td>';
            $contLista .= '<td>'.$fila['observacion'].'</td>';
            $contLista .= '<td><center>'.$fechaEntrada.'</center></td>';
            $contLista .= '<td><center>'.$fechaSalida.'</center></td>';
            $contLista .= '</tr>';
            
            if($j==0) $j++;
            else $j--;
        }

        $style      = file_get_contents($rutaDir.'css/reporte_horizontal.css');
        $htmlIni    = '<html>';
        $htmlFin    = '</html';
        $headIni    = '<head><meta http-equiv="Content-Type" content="text/html;">';
        $headFin    = '</head>';
        $styleIni   = '<style type="text/css">';
        $styleFin   = '</style>';
        $bodyIni    = '<body>';
        $bodyFin    = '</body>';
        $header     = ' 
        <div id="panel_top">
            <div style="height:auto;">
                <img src="'.$rutaDir.'multimedia/imagen/portada/cintillo_01.jpg" style="width:520px;height:64px">
                <img src="'.$rutaDir.'multimedia/imagen/portada/cintillo_02.jpg" style="width:238px;height:79px">
                <img src="'.$rutaDir.'multimedia/imagen/portada/cintillo_03.jpg" style="width:204px;height:64px">
            </div>
        </div>';
        $footer     = '
        <div id="panel_foot">
            <div style="height:10px;margin-top:0px;">
                <img src="'.$rutaDir.'multimedia/imagen/portada/ravan.jpg" style="width:100%;height:100%">
            </div>
            <div style="position:relative;width:100%;top:5px;">
                Gerencia de Protección y Seguridad (GPS)<br>
                Centro de Control de Seguridad (CCS)<br>
                Sistema de Control de Acceso de Visitantes (SISCAV)
            </div>
            <table id="datos_foot">
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>';
        $body = ('
        <div id="panel_contenido">
            <center><h3 style="font-family: sans-serif;text-decoration: underline;margin-top:0px;">LISTADO DE VISITAS</h3></center>
            <br><br>
            <div id="div_lista">
                <table style="width:100%;margin-top:-15px;" cellspacing="0">
                    <thead>
                        <tr class="td_inf" style="height:40px;text-align:center;font-size:12px;">
                            <th style="width:40px;">Nro.</th>
                            <th style="width:100px;">Código</th>
                            <th>Área</th>
                            <th style="width:70px;">Tipo</th>
                            <th>Visitante</th>
                            <th>Observación</th>
                            <th style="width:100px;">Fecha Entrada</th>
                            <th style="width:100px;">Fecha Salida</th>
                        </tr>
                    </thead>
                    <tbody>'.$contLista.'</tbody>
                </table>
            </div>
        </div>');
        
        $pdf = $htmlIni.$headIni.$styleIni.$style.$styleFin.$headFin.$bodyIni.$header.$footer.$body.$bodyFin.$htmlFin; 

        $dompdf = new Dompdf();
        $dompdf->loadHtml($pdf);
        $dompdf->setPaper('letter', 'landscape');
        $dompdf->render();
        $fontMe = $dompdf->getFontMetrics();
        $fuente = $fontMe->get_font("helvetica", "bold");
        $canvas = $dompdf->get_canvas(); 
        $canvas->page_text(730, 590, "Pág. {PAGE_NUM}/{PAGE_COUNT}",$fuente, 6, array(0,0,0)); 
        $dompdf->stream("reporte_lista.pdf", array("Attachment" => false)); 
        // header("Content-type: application/pdf"); 
        // echo $dompdf->output("prueba.pdf");
        /* echo("<pre>");
        print_r($_dompdf_warnings);
        echo("</pre>"); */
    } 
?>