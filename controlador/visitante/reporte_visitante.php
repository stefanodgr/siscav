<?php
     $rutaDir = "../../";
	include_once $rutaDir.'config.php';
    use Dompdf\Dompdf;

    $ctrlAcceso = validarConexion();

	if($ctrlAcceso){
        isset($_POST['param0']) ? $infId = $_POST['param0'] : $infId = 0;

        if(!$_POST) return false;

        $visitante       = new Visitante();
        $visita          = new visita();
        $datosVisitante    = $visitante->buscarVisitante($infId);
        $datosVisita       = $visitante->consultarHistorial($infId);

        if($datosVisitante[0]['foto'] == 't'){
            if($datosVisitante[0]['metro']) {
                $foto = gestionArchivo('consultar',$rutaDir.'../sictra/fotos/'.$datosVisitante[0]['cedula']);
            }
            else{
                $foto = gestionArchivo('consultar',$rutaDir.'multimedia/imagen/visitante/'.$datosVisitante[0]['cedula']);
            }
        }
        else{
            $foto = gestionArchivo('consultar',$rutaDir.'multimedia/imagen/visitante/siluetaHombre');
        }

        $colorFila = array('filaClara','filaOscura');
        $j=0;

        $estructura = new Estructura();
            foreach($datosVisita as $i => $fila){
				$objeto = $estructura->obtenerRutaEstructura($fila['area_id'],'sede');
				$sede = $objeto[1]['cod'];
                $datosVisita[$i]['sede'] = utf8_decode($sede);
                unset($objeto);
            }

        foreach($datosVisita as $i=>$fila){
   
            $contVisita .= '<tr class="'.$colorFila[$j].'">';
            $contVisita .= '<td style="text-align:center;">'.($i+1).'</td>';
            $contVisita .= '<td><center>'.$fila['codigo'].'</center></td>';
            $contVisita .= '<td>'.$fila['area'].'</td>';
            $contVisita .= '<td><center>'.$fila['tipo'].'</center></td>';
            $contVisita .= '<td>'.$fila['observacion'].'</td>';
            $contVisita .= '<td><center>'.formFechaHora($fila['entrada']).'</center></td>';
            $contVisita .= '<td><center>'.formFechaHora($fila['salida']).'</center></td>';
            // $contVisita .= '<td>'.$fila['usuario'].'</td>';
        //     $contVisita .= '</tr>';

            if($j==0) $j++;
            else $j--;
        }
        $j=0;

        $style      = file_get_contents($rutaDir.'css/reporte_vertical.css');
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
                <img src="'.$rutaDir.'multimedia/imagen/portada/cintillo.jpg" style="width:100%;height:100%">
            </div>
            <br>
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
            <center><h3 style="font-family: sans-serif;text-decoration: underline;margin-top:0px;"> FICHA DEL VISITANTE</h3></center>
            <br>
            <div id="div_ficha">
                <div class="titulo_seccion">DATOS PERSONALES:</div>
                <br>
                <div class="div_tbl" style="float:left;width:67.5%;">
                    <div class="div-tbl-fi">
                        <table style="position:relative;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:15%;">Cédula</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisitante[0]['cedula'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:15%;">Nombre:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisitante[0]['nombre'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:15%;">Apellido:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisitante[0]['apellido'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:15%;">Organización:</td>
                                <td class="td_dato" style="width:85%;">'.$datosVisitante[0]['organizacion'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:15%;">Teléfono:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisitante[0]['telefono'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi" style="height: 86px;">
                        <table style="position:inherit;width:100%;height:86px;">
                            <tr>
                                <td class="td_inf dark" style="width:15%;">Dirección:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisitante[0]['direccion'].'</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div style="width:14px;float:left;"></div>
                <table style="position:relative;width:218px;height:225px;float:left;margin-top:-2px;">
                    <tr>
                        <td class="dark" style="border:0px solid gray;">
                            <img src="'.$foto.'" style="width:99%; height:225px;border:0.5px solid black;">
                        </td>
                    </tr>
                </table>
            </div>
            <br><br><br>
            <div class="div_seccion">
                <div class="div_subseccion">
                    <div class="titulo_seccion">HISTORIAL DE VISITAS:</div>
                    <br>
                    <div class="titulo_subseccion">VISITAS: '.count($datosVisita).' registro(s).</div>
                    <table style="width:100%;">
                        <thead>
                            <tr class="td_inf" style="height:40px;text-align:center;">
                                    <th style="width:40px;">Nro.</th>
                                    <th style="width:100px;">Código</th>
                                    <th>Área</th>
                                    <th style="width:70px;">Tipo</th>
                                    <th>Observación</th>
                                    <th style="width:100px;">Fecha Entrada</th>
                                    <th style="width:100px;">Fecha Salida</th>
                                </tr>
                            </tr>
                        </thead>
                        <tbody>'.$contVisita.'</tbody>
                    </table>
                </div>
            </div>
        </div>');
        
        $pdf = $htmlIni.$headIni.$styleIni.$style.$styleFin.$headFin.$bodyIni.$header.$footer.$body.$bodyFin.$htmlFin; 
        
        $dompdf = new Dompdf();
        $dompdf->loadHtml($pdf);
        $dompdf->setPaper('letter', 'portrait');
        $dompdf->render();
        $fontMe = $dompdf->getFontMetrics();
        $fuente = $fontMe->get_font("helvetica", "bold");
        $canvas = $dompdf->get_canvas(); 
        $canvas->page_text(548, 771, "Pág. {PAGE_NUM}/{PAGE_COUNT}",$fuente, 6, array(0,0,0)); 
        $dompdf->stream("reporte_visitante.pdf", array("Attachment" => false)); 
    }
?>