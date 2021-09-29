<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
		 
		<!-- -------------------------------- INCLUSIÓN DE ESTILOS -------------------------------- -->
		<!-- -------------------------------------------------------------------------------------- -->
		 
		<!-- -------------------------------- INCLUSIÓN DE SCRIPTS -------------------------------- -->
		<!-- -------------------------------------------------------------------------------------- -->
			
		<!-- -------------------------------- FUNCIONES JAVASCRIPT -------------------------------- -->
		 
		<!-- -------------------------------------------------------------------------------------- -->
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
				<div id='ficha_visitante'>
					<div class='div-tbl'>
						<div class="div-tbl-fi" style="height: 30px;">
							<div class="modal_titulo div-tbl-co" style='width:620px;'>- Búsqueda de Visitante -</div>
						</div>
						<div class="div-tbl-fi" style="height: 10px;"></div>
						<div class="div-tbl-fi" style="width:100%;position:absolute"> 	<!-- FOTO !-->
							<div class="div-tbl-co" style='width:230px;height:275px;top:117px;margin-left:349px;align-items: left;flex-wrap: wrap;justify-content: center;'>
								<img id='filt_foto' class='img_inf' src='multimedia/imagen/visitante/siluetaHombre.png' style='width:100%; height:240px;border:1px solid gray;cursor:pointer;'>
								<div style="width:100%;margin-top:1px;height:30px;cursor:not-allowed;">
									<div id='inf_acceso' class='inf_autoriz acceso'  style="width:100%;">INFORMACIÓN</div>
								</div>
							</div>
						</div>
						<div class="div-tbl-fi">
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Cédula:'>
							</div>
							<div class="div-tbl-co" style='width:50px;'>
								<select class="dsR170 frm_vis_2" id="filt_nac" size="1" style='height:30px;font-weight: bold;'>
									<option value="V">V</option>
									<option value="E">E</option>
									<option value="P">P</option>
								</select> 
							</div>
							<div class="div-tbl-co" style='width:140px;'>
								<input type="text" id='filt_cedula_vte' class='div-inp-ena frm_vis_0 frm_vis_2 edit'>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content: center'>
								<input type="image" id='btn_busq_infractor' src="multimedia/imagen/icono/buscar.png" class='btn_general' style='width:23px;height:23px;'>
							</div>
						</div>
						<div class="div-tbl-fi" style="width: 240px;">
							<div class="div-tbl-co" style='width:20px;'></div>	
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Carné:'>
							</div>
							<div class="div-tbl-co" style='width:120px;'>
								<input type="text" id='filt_carne' class='div-inp-dis frm_vis_0 frm_vis_2 edit' disabled>
							</div>
						</div>
						<div class="div-tbl-fi" style="width: 340px;">
							<div class="div-tbl-co" style='width:20px;'></div>	
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Nombre:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_nombre' class='div-inp-ena frm_vis_0 frm_vis_2 edit'>
							</div>
						</div>
						<div class="div-tbl-fi" style="width: 340px;">
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Apellido:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_apellido' class='div-inp-ena frm_vis_0 frm_vis_2 edit'>
							</div>
						</div>
						<div class="div-tbl-fi" style="width: 340px;">
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Organización:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_org' class='div-inp-dis frm_vis_1 edit' disabled>
							</div>
						</div>
						<div class="div-tbl-fi" style="width: 340px;">
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Teléfono:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_telefono' class='div-inp-dis frm_vis_1 edit' disabled>
							</div>
						</div>
						<div class="div-tbl-fi" style="height: 10px; width:20px;"></div>
						<div class="div-tbl-fi" style="height: 10px; width:20px;"></div>
						<div class="div-tbl-fi" style="height: 10px; width:20px;"></div>
						<div class="div-tbl-fi" style="height: 10px; width:20px;"></div>
						<div class="div-tbl-fi fila_textarea" style='margin-left:19px;'> 				<!-- DIRECCIÓN !-->
							<div class="div-tbl-co" style='width:400px;'>
								<input type="text" class='div-inp-trans' value='Dirección:' disabled>
							</div>
							<div class="div-tbl-co" style='width:270px;'></div>
						</div>
						<div class="div-tbl-fi fila_textarea" style="height:80px;top:-14px;justify-content:center;"> 	<!-- TEXTAREA DIRECCIÓN !-->
							<div class="div-tbl-co" style='width:560px;'>
								<textarea  id="filt_direccion" class = 'div-inp-dis frm_vis_1 edit' style="position:relative;width:100%;resize:none;overflow-y:scroll;" disabled></textarea>
							</div>
						</div>
						<!-- CAUSA DE RESTRICCIÓN !-->
						<div class="div-tbl-fi fila_rest oculto" style='margin-left:19px;'> 				
							<div class="div-tbl-co" style='width:400px;'>
								<input type="text" class='div-inp-trans' value='Causa de restricción de acceso:' disabled>
							</div>
							<div class="div-tbl-co" style='width:270px;'></div>
						</div>
						<!-- TEXTAREA CAUSA !-->
						<div class="div-tbl-fi fila_rest oculto" style="height:80px;top:-14px;justify-content:center;"> 	
							<div class="div-tbl-co" style='width:560px;'>
								<textarea  id="filt_restriccion" class = 'div-inp-dis frm_2' style="position:relative;width:100%;resize:none;overflow-y:scroll;color:#F2F2F2;font-weight:bolder;text-shadow:0px -1px 0px rgba(0, 0, 0, 0.2);background:rgb(177, 53, 53);" disabled></textarea>
							</div>
						</div>
						<div class="div-tbl-fi inf-metro oculto">
							<div class="div-tbl-co" style='width:100%;justify-content: center;color: darkred;'>
								<strong><h4>TRABAJADOR METRO</h4></strong>
							</div>
						</div>
						<div class="div-tbl-fi" style="height: 10px;"></div>
						<div class="div-tbl-fi" style="width:calc(100% - 40px);height:20px;border-radius:4px;justify-content: center;margin-left:20px;">
							<div class="div-tbl-co" style='width:75px;'>
								<input type="text" class='div-inp-trans inf_registro' value='Nro. Visitas:' disabled>
							</div>
							<div class="div-tbl-co" style='width:35px;justify-content: center;'>
								<input type="text" id='filt_visitas' class='div-inp-trans inf_registro' disabled> 
							</div>
							<div class="div-tbl-co" style='width:85;justify-content: center;'></div>
							<div class="div-tbl-co" style='width:65px;'>
								<input type="text" class='div-inp-trans inf_registro' value='Últ. Visita:' disabled>
							</div>
							<div class="div-tbl-co" style='width:106px;justify-content: center;'>
								<input type="text" id='filt_ult_visita' class='div-inp-trans inf_registro' disabled> 
							</div>
							<div class="div-tbl-co" style='width:75px;justify-content: center;'></div>
							<div class="div-tbl-co" style='width:110px;'>
								<input id="lblRestringido" type="text" class='div-inp-trans inf_registro oculto' value='Restringir Acceso:' disabled>
								<input id="idListaNegra" type="text" class='oculto' value='' disabled>
							</div>
							<div class="div-tbl-co" style='width:20px;justify-content: center;'>
								<input type="checkbox" id='filt_restringir' class='div-inp-trans inf_registro oculto' > 
							</div>
						</div>
						<div class="div-tbl-fi" style="height:10px;"></div>
						<div class="div-tbl-fi" style="height:60px;">
							<div class="div-tbl-co" style='width:calc(100% - 40px);left:20px;justify-content:center;'>
								<input type="button" id='btn_visitante_bus' class='btn_hg btnAzul2 btn_infractor_0' 							style='width:120px;' 					value='Consultar'>
								<!--<input type="button" id='btn_infractor_mod' class='btn_hg btnAzul oculto' 									style='width:132px;'					value='Modificar'>-->
								<input type="button" id='btn_visitante_rep' class='btn_hg btnVioleta oculto' 									style='width:132px;margin-left:30px;' 	value='Reporte PDF'>
								<input type="button" id='btn_visitante_lim' class='btn_hg btnCeleste btn_infractor_1 oculto' 					style='width:132px;margin-left:30px;'  	value='Limpiar'>
								<!-- <input type="button" id='btn_infractor_ace' class='btn_hg btnVerde btn_infractor_2 oculto deshabilitado' 		style='width:132px;' 					value='Aceptar' disabled>
								<input type="button" id='btn_infractor_can' class='btn_hg btnRojo btn_infractor_2 oculto' 						style='width:132px;margin-left:30px;' 	value='Cancelar'> -->
							</div>
						</div>
						<div class="div-tbl-fi oculto">
							<div class="div-tbl-co" style="width:30px;">
								<input type="text" id='filt_id' class="div-inp-dis" disabled>
							</div>
							<div class="div-tbl-co" style="width:30px;">
								<input type="text" id='filt_pers' class="div-inp-dis" disabled>
							</div>
						</div>
					</div> 
				</div>
				<div id='historial_visitante' class="oculto">
					<div class='inf_reincidencia' style='display:none;'><img src = 'multimedia/imagen/icono/advertencia.png' width="30px" height="30px"></img>&nbsp; Esta persona posee más de una infracción registrada en el sistema.</div>
					<div class='div-tbl' style='top:10px;'>
						<div class="div-tbl-fi">
							<div class="div-tbl-co" style='width:100%;justify-content: center;'>
								<iframe id='ifr_historial' name='ifr_historial' scrolling='no'></iframe>
							</div>
						</div>
					</div>
				</div>
				<div id='lista_visitante' class='oculto'>
					<iframe id='ifr_lista_visitante' name='ifr_lista_visitante' scrolling='no'></iframe>
				</div>
            </div>
			<div class='preview' style="visibility: hidden;">
				<input type="image" class='img-preview'>
			</div>
		</div>    
	</body>
</html>