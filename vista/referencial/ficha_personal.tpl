<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	</head>
	<body>
        <div id='ficha_personal' class=''>
            <div class='div-tbl'>
                <div class="div-tbl-fi" style="height: 30px;">
                    <div id='titulo_ficha_pers' class="modal_titulo div-tbl-co" style='width:620px;'>- Búsqueda de Personal -</div>
                </div>
                <div class="div-tbl-fi" style="height: 10px;"></div>
                <div class="div-tbl-fi oculto" style="width: 100%;">
                    <div class="div-tbl-co" style='width:20px;'></div>	
                    <div class="div-tbl-co" style='width:110px;'>
                        <input type="text" class='div-inp-trans' disabled value='Id. Pers:'>
                    </div>
                    <div class="div-tbl-co" style='width:60px;'>
                        <input type="text" id='ficha_pers_id' class='div-inp-dis' disabled>
                    </div>
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:110px;'>
                        <input type="text" class='div-inp-trans' disabled value='Id. RelPersEst:'>
                    </div>
                    <div class="div-tbl-co" style='width:60px;'>
                        <input type="text" id='ficha_pers_rel_est_id' class='div-inp-dis' disabled>
                    </div>
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:110px;'>
                        <input type="text" class='div-inp-trans' disabled value='Id. UsuEst:'>
                    </div>
                    <div class="div-tbl-co" style='width:60px;'>
                        <input type="text" id='ficha_pers_usu_id' class='div-inp-dis' disabled>
                    </div>
                </div>
                <div class="div-tbl-fi" style="width:100%;position:absolute"> 	<!-- FOTO !-->
                    <div class="div-tbl-co" style='width:230px;height:240px;top:100px;margin-left:349px;align-items: left;flex-wrap: wrap;justify-content: center;'>
                        <img id='ficha_pers_foto' class='img_vis' src='multimedia/imagen/visitante/siluetaHombre.png' style='width:100%; height:240px;border:1px solid gray;cursor:pointer;'>
                    </div>
                </div>
                <div class="div-tbl-fi" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>	
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Carné:'>
                    </div>
                    <div class="div-tbl-co" style='width:140px;'>
                        <input type="text" id='ficha_pers_carne' class='div-inp-ena'>
                    </div>
                    <div class="div-tbl-co" style='width:30px;justify-content: center'>
                        <input type="image" id='ficha_pers_btn_busq' src="multimedia/imagen/icono/buscar.png" class='btn_general' style='width:23px;height:23px;'>
                    </div>
                </div>
                <div class="div-tbl-fi" style="width: 340px;">
                        <div class="div-tbl-co" style='width:20px;'></div>
                        <div class="div-tbl-co" style='width:100px;'>
                            <input type="text" class='div-inp-trans' disabled value='Cédula:'>
                        </div>
                        <div class="div-tbl-co" style='width:140px;'>
                            <input type="text" id='ficha_pers_cedula' class='div-inp-dis' disabled>
                        </div>
                    </div>
                <div class="div-tbl-fi" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>	
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Nombre:'>
                    </div>
                    <div class="div-tbl-co" style='width:220px;'>
                        <input type="text" id='ficha_pers_nombre' class='div-inp-dis' disabled>
                    </div>
                </div>
                <div class="div-tbl-fi" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Apellido:'>
                    </div>
                    <div class="div-tbl-co" style='width:220px;'>
                        <input type="text" id='ficha_pers_apellido' class='div-inp-dis' disabled>
                    </div>
                </div>
                <div class="div-tbl-fi" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Cargo:'>
                    </div>
                    <div class="div-tbl-co" style='width:220px;'>
                        <input type="text" id='ficha_pers_cargo' class='div-inp-dis' disabled>
                    </div>
                </div>
                <div class="div-tbl-fi [var.ctrlEstAct;noerr]" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Est. Actual:'>
                    </div>
                    <div class="div-tbl-co" style='width:220px;'>
                        <input type="text" id='ficha_pers_est' class='div-inp-dis' disabled>
                    </div>
                </div>
                <div class="div-tbl-fi [var.ctrlPabx;noerr]" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='PABX:'>
                    </div>
                    <div class="div-tbl-co" style='width:140px;'>
                        <input type="text" id='ficha_pers_pabx' class='div-inp-dis' disabled>
                    </div>
                </div>
                <div class="div-tbl-fi [var.ctrlSede;noerr]" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Sede:'>
                    </div>
                    <div class="div-tbl-co" style='width:140px;'>
                        <select id='ficha_pers_sede' class='div-inp-dis' style='font-weight:normal !important;'disabled>
                            <option value='[sede.id;block=option;noerr;]'>[sede.codigo]</option>
                        </select>
                    </div>
                </div>
                <div class="div-tbl-fi fila_perfil oculto" style="width: 340px;">
                    <div class="div-tbl-co" style='width:20px;'></div>
                    <div class="div-tbl-co" style='width:100px;'>
                        <input type="text" class='div-inp-trans' disabled value='Perfil:'>
                    </div>
                    <div class="div-tbl-co" style='width:140px;'>
                        <select id='ficha_pers_perfil' class='div-inp-dis' style='font-weight:normal !important;'disabled>
                            <option value='[perfil.id;block=option;noerr;]'>[perfil.codigo]</option>
                        </select>
                    </div>
                </div>
                
                <div class="div-tbl-fi" style="width: 20px;height:30px;"></div>
                <div class="div-tbl-fi" style="width:100%;height:60px;border: 0px solid red;">
                    <div class="div-tbl-co" style='width:calc(100% - 40px);left:20px;justify-content:center;'>
                        <input type="button" id='ficha_pers_btn_atr' class='btn_hg btnAzul3 ficha_pers_btn_0' 			style='width:132px;margin-left:30px;' 	value='Atrás'>
                        <input type="button" id='ficha_pers_btn_ace' class='btn_hg btnVerde ficha_pers_btn_1 oculto' 	style='width:132px;cursor:pointer;' 	value='Aceptar' disabled>
                        <input type="button" id='ficha_pers_btn_can' class='btn_hg btnRojo ficha_pers_btn_1 oculto' 	style='width:132px;margin-left:30px;' 	value='Cancelar'>
                    </div>
                </div>
            </div> 
        </div>
	</body>
</html>