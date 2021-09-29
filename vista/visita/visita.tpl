<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>

		<!-- -------------------------------- INCLUSIÓN DE ESTILOS -------------------------------- -->
			<style type="text/css">
				#divArbol{
					height: 350px;
				}
			</style>
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
				<div id='div_filtros' class=''>
					<div class='div-tbl'>
						<div class="div-tbl-fi" style='justify-content: center;'>
							<div class="div-tbl-co" style='width:90px;'>
								<input type="text" class='div-inp-trans' disabled value='Cod. Visita:'>
							</div>
							<div class="div-tbl-co" style='width:150px;'>
								<input type="text" id='filt_codigo' class='div-inp-ena'>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:185px;'>
								<input type="text" class='div-inp-trans' disabled value='Sólo visitas sin salida:'>
								<input id='filt_estado' type="checkbox" class='div-inp-trans' style="width: 20px" checked>
							</div>
							<div class="div-tbl-co" style='width:155px;'></div>
						</div>
						<!-- <div class="div-tbl-fi" style='justify-content: center;'>
							<div class="div-tbl-co" style='width:90px;'>
								<input type="text" class='div-inp-trans' disabled value='Sede:'>
							</div>
							<div class="div-tbl-co" style='width:150px;'>
								<select id="selSede">
									<option value="0" selected>TODAS</option>
									<option value="[sede.id;block=option;noerr]">
										[sede.sigla;block=option;noerr]
									</option>
								</select>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:60px;'>
								<input type="text" class='div-inp-trans' disabled value='Área:'>
							</div>
							<div class="div-tbl-co" style='width:280px;'>
								<select id="selArea">
									<option id='opc_lin_todas' value="0" selected>TODAS</option>
									<option value="[area.id;block=option;noerr]">
										[area.desc;block=option;noerr]
									</option>
								</select>
							</div>
						</div> -->
						<div class="div-tbl-fi" style='justify-content: center;'>
							<div class="div-tbl-co" style='width:90px;'>
								<input type="text" class='div-inp-trans' disabled value='Tipo:'>
							</div>
							<div class="div-tbl-co" style='width:150px;'>
								<select id="selTipo">
									<option value="0" selected>TODAS</option>
									<option value="1">LABORAL</option>
									<option value="2">PERSONAL</option>
								</select>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:60px;'>
								<input type="text" class='div-inp-trans' disabled value='Fecha:'>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" id='f_desde' class='div-inp-dis' placeholder="Desde..." disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content:center;'>
								<input type="image" id='btn_f_desde' src="multimedia/imagen/icono/calendar.png" class='btn_general' style='width:23px;height:23px;'>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" id='f_hasta' class='div-inp-dis' placeholder="Hasta..." disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content:center;'>
								<input type="image" id='btn_f_hasta' src="multimedia/imagen/icono/calendar.png" class='btn_general' style='width:23px;height:23px;'>
							</div>
						</div>
						<div class="div-tbl-fi avanzado" style="height:20px;"></div>
						<div class="div-tbl-fi" style='height:45px;justify-content:center;top:-10px;'>
							<div class="div-tbl-co" style='width:600px;justify-content: center;'>
								<input type="button" id='btn_busq_visita' 	class='btn_hg btnAzul2' 								style='width:120px;' 					value='Consultar'>
								<input type="button" id='btn_rep_lista' 	class='btn_hg btnVioleta [var.ctrlReporteLista;noerr]' 	style='width:120px;margin-left:20px;' 	value='Reporte PDF'>
							</div>
						</div>
					</div>
				</div>
                <div id='div_visita' class=''>
                     <iframe id='ifr_visita' name='ifr_visita' src='controlador/visita/visita.php?case=1&tipo=inicial' scrolling='no'></iframe> 
                </div>
                <div id='ficha_visita' class='oculto'>
                    <div class='div-tbl'>
						<div class="div-tbl-fi" style="height:30px;">
							<div id='titulo_ficha_vis' class="modal_titulo div-tbl-co" style='width:100%;'>- Ficha de Visita -</div>
						</div>
						<div class="div-tbl-fi" style="height:15px;"></div>
						<div class="div-tbl-fi oculto" style='justify-content: center;'>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Id Visita:'>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" id='filt_visita_id' class='div-inp-dis' disabled>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Id Visitante:'>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" id='filt_vte_id' class='div-inp-dis' disabled>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" class='div-inp-trans' disabled value='Id Personal:'>
							</div>
							<div class="div-tbl-co" style='width:100px;'>
								<input type="text" id='filt_pers_id' class='div-inp-dis' disabled>
							</div>
						</div>
						<div class="div-tbl-fi" style='margin-left:19px;'> 				<!-- CÓDIGO VISITA !-->
                            <div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' value='Código Visita:' disabled>
							</div>
                            <div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_visita_cod' class='div-inp-dis rim' style="height:90%;width:100%;" disabled>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
							<div class="div-tbl-co" style='width:320px;flex-wrap: wrap;'>
								<div style="width: 100%;height: 50%;display:flex;align-items:center;justify-content:flex-end;">
									<input type="text" class='div-inp-trans inf_registro' style='width:100px;text-align:right;' value='Registrado por:' disabled>
									<input type="text" id='filt_usuario' class='div-inp-trans inf_registro' style='width:125px;text-align: center;' disabled> 
								</div>
								<div style="width: 100%;height: 50%;display:flex;align-items:center;justify-content:flex-end;">
									<input type="text" class='div-inp-trans inf_registro' style='width:100px;text-align:right;' value='Fecha / Hora:' disabled>
									<input type="text" id='filt_registro' class='div-inp-trans inf_registro' style='width:125;text-align: center;' disabled> 
								</div>
							</div>
						</div>
						<div class="div-tbl-fi" style='justify-content: center;height:10px;'></div>
						<div class="div-tbl-fi" style="width:100%;position:absolute"> 	<!-- FOTO/CÁMARA !-->
							<div class="div-tbl-co" style='width:320px;height:320px;top:140px;margin-left:369px;align-items: left;flex-wrap: wrap;justify-content: center;'>
								<img id='filt_foto' class='img_vis' src='multimedia/imagen/visitante/siluetaHombre.png' style='width:100%; height:280px;border:1px solid gray;cursor:pointer;'>
								<div id='filt_webcam' class='img_vis oculto' style='width:100%; height:280px;border:1px solid gray;cursor:pointer;'></div>
								<div style="width:100%;height:32px;cursor:not-allowed;">
									<div id='inf_acceso' class='inf_autoriz' style="width:90%;"></div>
									<div class='load_foto' style="width:10%;">
										<!--<input type="file" id='filt_foto_load' style="width:85px;margin-top:5px;height:30px;cursor:not-allowed;display:none;" disabled>-->
										<input type="image" id='btn_tomar_foto' src="multimedia/imagen/icono/camara.png" class='btn_general deshabilitado' style='width:24px;height:24px;'>
									</div>
								</div>
							</div>
						</div>
						<div class="div-tbl-fi" style="margin-left:19px;width:350px;"> 	<!-- CÉDULA !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' disabled value='Cédula:'>
							</div>
							<div class="div-tbl-co" style='width:50px;'>
								<select class="dsR170 frm_0" id="filt_nac" size="1" style='height:30px;font-weight: bold;' disabled>
									<option value="V">V</option>
									<option value="E">E</option>
									<option value="P">P</option>
								</select> 
							</div>
							<div class="div-tbl-co" style='width:140px;'>
								<input type="text" id='filt_cedula' class='div-inp-dis frm_0' disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content: center;'>
								<input type="image" id='btn_busq_visitante' src="multimedia/imagen/icono/buscar.png" class='btn_general' style='width:23px;height:23px;'>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi" style="margin-left:19px;width:350px;"> 	<!-- CARNÉ !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' disabled value='Carné:'>
							</div>
							<div class="div-tbl-co" style='width:120px;'>
								<input type="text" id='filt_carne' class='div-inp-dis frm_0' disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content: center;'>
								<input type="image" id='btn_busq_pers' src="multimedia/imagen/icono/buscar.png" class='btn_general' style='width:23px;height:23px;'>
							</div>
							<div class="div-tbl-co" style='width:90px;'></div>
						</div>
						<div class="div-tbl-fi" style="margin-left:19px;width:350px;"> 	<!-- NOMBRE !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' disabled value='Nombre:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_nombre' class='div-inp-dis frm_1' disabled>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi" style="margin-left:19px;width:350px;"> 	<!-- APELLIDO !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' disabled value='Apellido:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_apellido' class='div-inp-dis frm_1' disabled>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi" style="margin-left:19px;width:350px;"> 	<!-- ORGANIZACIÓN !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' disabled value='Organización:'>
							</div>
							<div class="div-tbl-co" style='width:220px;'>
								<input type="text" id='filt_org' class='div-inp-dis frm_1' disabled>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi oculto" style='margin-left:19px;width:350px;'> 	<!-- SEDE !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' value='Sede:' disabled>
							</div>
							<div class="div-tbl-co" style='width:190px;'>
								<input type="text" id='filt_sede' name='2' class='div-inp-dis' value='CCO' disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content: center;'>
								<input type="image" id='btn_busq_sede' src="multimedia/imagen/icono/listado.png" class='btn_general deshabilitado frm_2' style='width:23px;height:23px;'>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi" style='margin-left:19px;width:350px;'> 	<!-- ÁREA !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' value='Área:' disabled>
							</div>
							<div class="div-tbl-co" style='width:190px;'>
								<input type="text" id='filt_area' class='div-inp-dis' disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content: center;'>
								<input type="image" id='btn_busq_area' src="multimedia/imagen/icono/listado.png" class='btn_general deshabilitado frm_2' style='width:23px;height:23px;'>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi" style='margin-left:19px;width:350px;'> 	<!-- VISITA A !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' value='Visita a:' disabled>
							</div>
							<div class="div-tbl-co" style='width:190px;'>
								<input type="text" id='filt_recibe' class='div-inp-dis' disabled>
							</div>
							<div class="div-tbl-co" style='width:30px;justify-content: center;'>
								<input type="image" id='btn_busq_pers_vis' src="multimedia/imagen/icono/listado.png" class='btn_general deshabilitado frm_2' style='width:23px;height:23px;'>
							</div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi" style='margin-left:19px;width:350px;'>	<!-- TIPO VISITA !-->
							<div class="div-tbl-co" style='width:110px;'>
								<input type="text" class='div-inp-trans' value='Tipo:' disabled>
							</div>
							<div class="div-tbl-co" style='width:190px;'>
								<select id="filt_tipo" class='frm_2' disabled>
									<option value="0" selected>SELECCIONAR</option>
									<option value="1">LABORAL</option>
									<option value="2">PERSONAL</option>
								</select>
							</div>
							<div class="div-tbl-co" style='width:30px;'></div>
							<div class="div-tbl-co" style='width:20px;'></div>
						</div>
						<div class="div-tbl-fi fila_textarea" style='margin-left:19px;'> 				<!-- OBSERVACIONES !-->
							<div class="div-tbl-co" style='width:400px;'>
								<input type="text" class='div-inp-trans' value='Observaciones / Motivo:' disabled>
							</div>
							<div class="div-tbl-co" style='width:270px;'></div>
						</div>
						<div class="div-tbl-fi fila_textarea" style="height:80px;top:-14px;justify-content:center;"> 	<!-- TEXTAREA OBSERVACIONES !-->
							<div class="div-tbl-co" style='width:670px;'>
								<textarea  id="filt_descripcion" class = 'div-inp-dis frm_2' style="position:relative;width:100%;resize:none;overflow-y:scroll;" disabled></textarea>
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
							<div class="div-tbl-co" style='width:670px;'>
								<textarea id="filt_restriccion" class='div-inp-dis' style="position:relative;width:100%;resize:none;overflow-y:scroll;color:#F2F2F2;font-weight:bolder;text-shadow:0px -1px 0px rgba(0, 0, 0, 0.2);background:rgb(177, 53, 53);" disabled></textarea>
							</div>
						</div>
						<div class="div-tbl-fi" style="height:60px;justify-content: center;"> 			<!-- BOTONERA !-->
							<div class="div-tbl-co" style='width:calc(100% - 40px);justify-content:center;border:1px solid #d8d8d8;border-radius:6px;'>
								<input type="button" id='btn_visita_sal' 		class='btn_hg btnRojo btn_visita_0 oculto' 								style='width:132px;margin-left:20px;'  	value='Procesar Salida'>
								<input type="button" id='btn_visita_ace' 		class='btn_hg btnVerde btn_visita_1 oculto deshabilitado'				style='width:132px;margin-left:20px;'  	value='Procesar Entrada'>
								<input type="button" id='btn_visita_rep' 		class='btn_hg btnVioleta btn_visita_0 oculto' 							style='width:132px;margin-left:20px;'	value='Reporte PDF'>
								<input type="button" id='btn_visita_atr' 		class='btn_hg btnAzul3 btn_visita_0 oculto' 							style='width:132px;margin-left:20px;'  	value='Atrás'>
								<input type="button" id='btn_visita_lim' 		class='btn_hg btnCeleste btn_visita_1 oculto' 							style='width:132px;margin-left:30px;'  	value='Limpiar Ficha'>
								<input type="button" id='btn_visita_can' 		class='btn_hg btnRojo btn_visita_1 oculto' 								style='width:132px;margin-left:30px;'  	value='Cancelar'>
							</div>
						</div>
						<div class="div-tbl-fi" style="height:15px;"></div>
					</div> 
				</div>
				<div id='div_util_visita' class='oculto'></div>
				<div id='div_lista_pers' class='oculto'>
					<iframe id='ifr_lista_pers' name='ifr_lista_pers'></iframe>
				</div>
            </div>
			<div class='preview' style="visibility: hidden;">
				<input type="image" class='img-preview'>
			</div>
			<div class='conexion'></div>
		</div>    
	</body>
</html>