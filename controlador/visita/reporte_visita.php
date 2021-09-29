<?php
    $rutaDir = "../../";
	include_once $rutaDir.'config.php';
    use Dompdf\Dompdf;

    $ctrlAcceso = validarConexion();

    if($ctrlAcceso){
        isset($_POST['param0']) ? $visId = $_POST['param0'] : $visId = 0;
        if(!$_POST) return false;

        $visita             = new Visita();
        $datosVisita        = $visita->buscarVisita($visId);

        $vteId          = $datosVisita[0]['id_vte'];           //ID DEL VISITANTE
        $persId         = $datosVisita[0]['pers_id'];          //ID DEL PERSONAL
        $visCod         = $datosVisita[0]['codigo'];           //CODIGO GENERADO
        $visFechaInic   = $datosVisita[0]['fecha_ini'];        // FECHA INICIO
        $visFechaFin    = $datosVisita[0]['fecha_fin'];         //FECHA FIN
        $vteNombre      = $datosVisita[0]['nombre'];            //NOMBRE DEL VISITANTE
        $vteApellido    = $datosVisita[0]['apellido'];          // APELLIDO
        $vteOrganiz     = $datosVisita[0]['organizacion'];      //ORGANIZACION
        $vteFoto        = $datosVisita[0]['foto'];              // FOTO
        $visRecibe      = $datosVisita[0]['personal'];          //QUIEN REGISTRA AL PERSONAL
        $visObserv      = $datosVisita[0]['observacion'];       //OBSERVACION
        $visArea        = $datosVisita[0]['area'];
        $visTipo        = $datosVisita[0]['tipo'];
        $visReg         = $datosVisita[0]['fecha_reg'];
        $visUsu         = $datosVisita[0]['usuario'];
        $listaNegraId   = $datosVisita[0]['id_lista'];
        
        if($datosVisita[0]['pers_id']){ 
            $personal = new Personal();
            $objeto = $personal->buscarPersonal($datosVisita[0]['pers_id']);
            $carne = $objeto[0]['carne'];
        }

        if($datosVisita[0]['foto'] == 't'){
            if($datosVisita[0]['pers_id']) $foto = gestionArchivo('consultar',$rutaDir.'../sictra/fotos/'.$datosVisita[0]['cedula']);
            else $foto = gestionArchivo('consultar',$rutaDir.'multimedia/imagen/visitante/'.$datosVisita[0]['cedula']);
        }
        else $foto = gestionArchivo('consultar',$rutaDir.'multimedia/imagen/visitante/siluetaHombre');
        
        $colorFila = array('filaClara','filaOscura');
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
            <center><h3 style="font-family: sans-serif;text-decoration: underline;margin-top:0px;">FICHA DE LA VISITA</h3></center>
            <br>
            <div id="div_ficha">
                <div class="titulo_seccion">DETALLE DE LA VISITA:</div>
                <br>
                <div class="div_tbl" style="float:left;width:67.5%;">
                    <div class="div-tbl-fi">
                        <table style="position:relative;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Código</td>
                                <td class="td_dato" style="width:68%;font-size:13px;font-weight:bolder;">'.$datosVisita[0]['codigo'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Cédula:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['cedula'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Carné:</td>
                                <td class="td_dato" style="width:68%;">'.$carne.'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Nombre:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['nombre'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Apellido:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['apellido'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                    <table style="position:inherit;width:100%;height:28px;">
                        <tr>
                            <td class="td_inf dark" style="width:16%;">Organización:</td>
                            <td class="td_dato" style="width:68%;">'.$datosVisita[0]['organizacion'].'</td>
                        </tr>
                    </table>
                </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Área:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['area'].'</td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Visita a:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['personal'].'</td>
                            </tr>
                        </table>
                    </div>
                   <div class="div-tbl-fi">
                        <table style="position:inherit;width:100%;height:28px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Tipo de Visita:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['tipo'].'</td>
                            </tr>
                        </table>
                    </div>
                        <div class="div-tbl-fi" style="height: 86px;">
                        <table style="position:inherit;width:100%;height:52px;">
                            <tr>
                                <td class="td_inf dark" style="width:16%;">Observación:</td>
                                <td class="td_dato" style="width:68%;">'.$datosVisita[0]['observacion'].'</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div style="width:14px;float:left;"></div>
                <table style="position:relative;width:218px;height:225px;float:left;margin-top:-2px;border:0px solid red;">
                    <tr>
                        <td class="dark" style="border:0px solid gray;">
                            <img src="'.$foto.'" style="width:99%; height:225px;border:0.5px solid black;">
                        </td>
                    </tr>
                </table>
                <table style="position:relative;height:52px;float:left;margin-top:254px;border:0px solid red;margin-left:3px;vertical-align:middle;">
                    <tr style="heigth:26px;">
                        <td class="td_inf dark" style="width:90px;border:1px solid gray;">Fecha Registro:</td>
                        <td class="td_dato" style="width:107px;border:1px solid gray;">'.formFechaHoraSegundo($datosVisita[0]['fecha_reg']).'</td>
                    </tr>
                    <tr style="heigth:26px;margin-top:40px;">
                        <td class="td_inf dark" style="width:90px;border:1px solid gray;">Registrado por:</td>
                        <td class="td_dato" style="width:107px;border:1px solid gray;font-size:10px;">'.$datosVisita[0]['usuario'].'</td>
                    </tr>
                    
                </table>
                
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
        $dompdf->stream("reporte_visita.pdf", array("Attachment" => false)); 
    }
?>