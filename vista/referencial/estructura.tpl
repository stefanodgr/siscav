<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
			
		<!-- -------------------------------------- FUNCIONES JAVASCRIPT -------------------------------------- -->
			<script type="text/javascript">
				$(document).ready(function(){
					var rutaArbolEst    = 'controlador/general/lista.php?case=arbol&tipoArbol=estructura';

					$.get(rutaArbolEst, function(rutaExt){
						$("#div_util_arbol").html(rutaExt); 
					});
				});
			</script>
		<!-- -------------------------------------------------------------------------------------------------- -->
	</head>
	<body>
		<div class='contenedor'>
			<div class='titulo'>
				<div>[var.titulo;noerr;] :.</div>
                <div>
                    <input type='image' id='toggle_menu' src="multimedia/imagen/icono/menu.png" style="width:15px;height:15px;transition-duration: 0.5s;">
                </div>
			</div>
            <div class='contenido'>
				<div id='div_util_arbol'></div>
                <div id='ficha_estructura' class='oculto'>
                    <div class='div-tbl'>
						<div class="div-tbl-fi" style="height:30px;">
							<div id='titulo_ficha_inf' class="modal_titulo div-tbl-co" style='width:100%;'>- Ficha de Estructura -</div>
						</div>
						<div class="div-tbl-fi" style="height:15px;"></div>
                        <div class="div-tbl-fi">
							<div class="div-tbl-co" style='width:80px;margin-left:19px;'>
								<input type="text" class='div-inp-trans' disabled value='Código:'>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" id='est_cod' class='div-inp-dis edit' disabled>
							</div>
                            <div class="div-tbl-co" style='width:80px;margin-left:19px;'>
								<input type="text" class='div-inp-trans' disabled value='Nombre:'>
							</div>
							<div class="div-tbl-co" style='width:380px;'>
								<input type="text" id='est_desc' class='div-inp-dis edit' disabled>
							</div>
						</div>
                        <div class="div-tbl-fi">
							<div class="div-tbl-co" style='width:80px;margin-left:19px;'>
								<input type="text" class='div-inp-trans' disabled value='PABX:'>
							</div>
							<div class="div-tbl-co" style='width:100;'>
								<input type="text" id='est_pabx' class='div-inp-dis edit' disabled>
							</div>
                            <div class="div-tbl-co" style='width:130px;margin-left:19px;'>
								<input type="text" class='div-inp-trans' disabled value='Ubicación Padre:'>
							</div>
							<div class="div-tbl-co" style='width:330px;'>
								<input type="text" id='est_descPadre' class='div-inp-dis edit' disabled>
							</div>
						</div>
						<div class="div-tbl-fi" style="height:30px;"></div>
						<div class="div-tbl-fi" style="height:60px;justify-content: center;">
							<div class="div-tbl-co" style='width:calc(100% - 20px);justify-content:center;border:1px solid #d8d8d8;border-radius:6px;'>
								<input type="button" id='btn_est_mod' class='btn_hg btnAzul btn_est_0 oculto'					style='width:110px;' 					value='Modificar' disabled>
								<input type="button" id='btn_est_agr' class='btn_hg btnCeleste btn_est_0' 						style='width:110px;margin-left:20px;'  	value='Agregar'>
								<input type="button" id='btn_est_eli' class='btn_hg btnRojo btn_est_0' 						style='width:110px;margin-left:20px;'  	value='Eliminar'>
								<input type="button" id='btn_est_tlf' class='btn_hg btnVerde2 btn_est_0 oculto' 				style='width:110px;margin-left:20px;'  	value='Direct. PABX' disabled>
								<input type="button" id='btn_est_per' class='btn_hg btnAmarillo btn_est_0 oculto' 				style='width:110px;margin-left:20px;'  	value='Personal Est.' disabled>								
								<input type="button" id='btn_est_ace' class='btn_hg btnVerde btn_est_1 oculto' 					style='width:110px;margin-left:20px;'  	value='Aceptar'>
								<input type="button" id='btn_est_can' class='btn_hg btnRojo btn_est_1 oculto' 					style='width:110px;margin-left:30px;'  	value='Cancelar'>
							</div>
						</div>
						<div class="div-tbl-fi" style="height:10px;"></div>
                        <div class="div-tbl-fi" style='justify-content: center;height: 20px;'>
                            <div class="div-tbl-co area_titulo_foot" style='width:100%;'></div>
                        </div>
					</div> 
                </div>
				<div id='div_util_est' class='oculto'>
					<iframe id="ifr_util_est" name="ifr_util_est"></iframe>
					<input type="button" id='btn_est_atr' class='btn_hg btnAzul3' style='width:132px;margin-left:calc((100% - 132px)/2)' value='Atrás' title="Volver a la ficha de estructura">
				</div>
				<div id='div_util_ficha' class='oculto'></div>
				<div id='div_control' class='oculto' style="position:relative;height:80px;overflow:auto;z-index:4;margin-top:30px;">
					<table style="float:left">
						<tr>
							<td>
								<input type="text" value = "ID Unidad" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Descripcion Unidad" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Codigo Unidad" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "PABX Unidad" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Rel PABX Unidad" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "ID Padre" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Descripcion Padre" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Codigo Padre" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Acción" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<input type="text" value = "Nuevo ID Padre" class = "negrilla" disabled="disabled">
							</td>
							<td>
								<!-- <input type="text" value = "Rastro" class = "negrilla" disabled="disabled"> -->
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" id = 'id_txt_elemento' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_desc' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_cod' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_pabx' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_rel_pabx' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_padre' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_descPadre' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_codPadre' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_accion' disabled="disabled">
							</td>
							<td>
								<input type="text" id = 'id_txt_nvo_padre' class = 'edit' disabled="disabled">
							</td>
							<td>
								<!-- <input type="text" id = 'id_txt_rastro' value = '[var.rastro;noerr]' disabled="disabled"> -->
							</td>
						</tr>
					</table>
				</div>
            </div>
		</div>    
	</body>
</html>