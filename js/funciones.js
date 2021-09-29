/* ------------------------------------ FUNCIONES JS UTILIZADAS EN TODO EL SISTEMA ------------------------------------ */
    var rastroInfractor     = null;
    var rastroInfraccion    = null;
    var arrId               = new Array;
    var arrIdRastro         = new Array();
    var moduloFichaPers     = null;

    $(document).ready(function() {     
        $('#panel_right').on('click','#toggle_menu',function(){
            if($('#panel_left').hasClass('toggle_activo')){
                $(this).removeClass('rotar');
                $('#panel_left').removeClass('toggle_activo');
                $("#panel_left").animate({
                    // 'left': "0px"
                });
                var anchoActual = $("#panel_right").width();
                var anchoNvo = anchoActual - 285;
                $("#panel_right").animate({
                    'width':anchoNvo,
                    'left': "285px"
                });
            }
            else{
                $(this).addClass('rotar');
                $('#panel_left').addClass('toggle_activo');
                $("#panel_left").animate({
                    // 'left': "-300px"
                });
                $("#panel_right").animate({
                    'left': "0px",
                    'width':"100%"
                });
            }
        });
        $('#panel_right').on('click','#btn_f_desde',function(){
            $('#f_desde').datetimepicker({
                timepicker: false,
                format: 	'd/m/Y',
                weeks:		true,
                dayOfWeekStart : 1,
                timepickerScrollbar:false,
                onShow:function( ct ){
                    this.setOptions({
                        maxDate:jQuery('#f_hasta').val()?jQuery('#f_hasta').val():false
                    })
                }
            });
            $('#f_desde').datetimepicker('show');
        });
        $('#panel_right').on('click','#btn_f_hasta',function(){
            $('#f_hasta').datetimepicker({
                timepicker: false,
                format: 	'd/m/Y',
                weeks:		true,
                dayOfWeekStart : 1,
                timepickerScrollbar:false,
                onShow:function( ct ){
                    this.setOptions({
                        minDate:jQuery('#f_desde').val()?jQuery('#f_desde').val():false
                    })
                }
            });
            $('#f_hasta').datetimepicker('show');
        });
        $('#panel_right').on('click','.img_inf',function(e){                // AL HACER CLICK EN LA FOTO
            var src         = $(this).attr('src');
            var silueta     = 'multimedia/imagen/infractor/siluetaHombre.png';
            
			if(src != silueta){
                $('.contenido').addClass('oculto');
                $('.preview').css('visibility','visible');
                $('.img-preview').attr('src',src);
            }
		});
        $('#panel_right').on('click','.img-preview',function(){             // AL HACER CLICK EN LA VISTA PREVIA DE LA FOTO
            $('.preview').css('visibility','hidden');
            $('.img-preview').attr('src','');
            $('.contenido').removeClass('oculto');
        });
        $('#panel_right').on('mouseover','#inf_acceso',function(e){         // AL PASAR EL MOUSE SOBRE LA INFORMACIÓN DE ACCESO
            mostrarMotivoRest(1);
        });  
        $('#panel_right').on('mouseout','#inf_acceso',function(e){          // AL RETIRAR EL MOUSE DE LA INFORMACIÓN DE ACCESO
            mostrarMotivoRest(0);
        });
    });
	function dimensionDtb(dtb,ancho,alto){
        switch(dtb){
            case 'exp': 
                $('#ifr_historial').parent().parent().css('height',alto);
            break;
            case 'vta': 
                $('#ifr_visita').parent().css('height',alto);
            break;
            case 'ref':
                $('#ifr_ref').parent().css('height',alto);
            break;
            case 'sed':
                $('#ifr_ref').parent().css('height',alto);
            break; 
            case 'are':
                $('#ifr_ref_aux').parent().css('height',alto);
            break;
            case 'per':
                $('#ifr_infraccion_per').parent().parent().css('height',alto);
            break;
            case 'con':
                $('#ifr_conexion').parent().css('height',alto + 20);
            break;
            case 'tel':
            case 'pes':
                $('#ifr_util_est').parent().css('height',alto + 10); 
                $('#ifr_lista_pers').parent().css('height',alto + 10);
            break;
        }
	}
    function apertura(siglas,idReg,elementTr,elementTd){
        switch (siglas){
            case 'exp':
                rastroInfractor = $('#filt_id').val();
                
                $('#panel_left #opcion_Infracciones').click();
                setTimeout(function(){
                    cargarVisita(idReg);
                },250);
            break;
            case 'sed':
                $("#div_ref").animate({
                    'width': "48.9%",
                    'left':'0%'
                });
                window.frames['ifr_ref'].dimensiones();
                $('#div_ref_aux').show();
                $('#ifr_ref_aux').attr('src','controlador/referencial/referencial.php?case=1&sedeId='+idReg);
                $('#ifr_ref').blur();
            break;
            case "vta":
                camposVisita(0);
                gestionMostrarBotones(0);
                cargarVisita(idReg);
                $('#ifr_visita').blur();
                retirarSombreadoDtb('ifr_visita');
            break;
            case 'lis':
            break;
        } 
    }
    function capturar(siglas,idReg,elementTr,elementTd){
        switch (siglas){
            case 'lis':
                $('#ifr_lista_visitante').attr('src','');
                $('#ifr_lista_visitante').blur();
                xajax_buscarVisitanteFiltro(idReg);
            break;
            case 'pes':
                var persId      = idReg;
                var persCarne   = elementTr.children[1].innerHTML;
                var persNombre  = elementTr.children[2].innerHTML;
                $('#filt_recibe').val(persNombre);
                $('#filt_recibe').attr('name',persId);
            break;
        } 
        cerrarLista(siglas);
    }
    function cerrarLista(siglas){
        switch (siglas){
            case 'lis':
                $('#ifr_lista_visitante').attr('src','');
                $('#lista_visitante').addClass('oculto'); 
                $('#ficha_visitante').removeClass('oculto'); 
            break;
            case 'pes':
                $('#ifr_lista_pers').attr('src','');
                $('#ifr_lista_pers').blur();
                $('#ficha_visita').removeClass('oculto');
                $('#div_lista_pers').addClass('oculto');
            break;
        } 
    }       
    function agregar(siglas){
        switch (siglas){
            case 'vta':
                $('#div_opc')           .hide();
                $('#div_filtros')       .addClass('oculto');
                $('#div_visita')        .addClass('oculto');
                $('#ficha_visita')      .removeClass('oculto');
                camposVisita(0);
                gestionMostrarBotones(1);
                accion = 'registrar';
                $('#titulo_ficha_inf').text('- Nueva Visita -');
                $('#ifr_visita').blur();
            break;
            case 'pes':
                moduloFichaPers = 'estructura';
                var rutaFichaPers = 'controlador/referencial/referencial.php?case=3&modulo=estructura';
                $.get(rutaFichaPers, function(rutaExt){ 
                    $("#div_util_ficha").html(rutaExt); 
                });
                $('#div_util_arbol').addClass('oculto');
                $('#div_util_est').addClass('oculto');
                $('#div_util_ficha').removeClass('oculto');
                $('#ifr_util_est').blur();
            break;
            case 'usu':
                if(snPerfUsu == 'SISTEMAS'){
                    moduloFichaPers = 'usuario';
                    var rutaFichaPers = 'controlador/referencial/referencial.php?case=3&modulo=usuario';
                    $.get(rutaFichaPers, function(rutaExt){ 
                        $("#div_ref_aux").html(rutaExt); 
                    });
                    $('#div_ref').addClass('oculto');
                    $('#div_ref_aux').removeClass('oculto');
                    $('#ifr_ref').blur();
                    accionFichaPers = 'agregar';
                }
                else alert("ERROR3X: No posee permisos para agregar nuevos usuarios.");
                
            break;
        }
        $('#ifr_visita'+siglas).blur();
    }
    function modificar(siglas,idReg,elementTr,elementTd){
        switch (siglas){
            case 'pes':
                moduloFichaPers = 'estructura';
                var carne = elementTr.children[1].innerHTML;

                if((carne != '') && (carne != null)){
                    accionFichaPers = 'modificar';
                    var rutaFichaPers = 'controlador/referencial/referencial.php?case=3&modulo=estructura';
                    $.get(rutaFichaPers, function(rutaExt){ 
                        $("#div_util_ficha").html(rutaExt); 
                    });

                    $('#div_util_arbol').addClass('oculto');
                    $('#div_util_est').addClass('oculto');
                    $('#div_util_ficha').removeClass('oculto');
                    $('#ifr_util_est').blur();
                    xajax_buscarPersonal(null,null,carne,'general');
                }
            break;
            case 'usu':
                var persId   = elementTr.children[6].innerHTML;

                moduloFichaPers = 'usuario';
                var rutaFichaPers = 'controlador/referencial/referencial.php?case=3&modulo=usuario';
                $.get(rutaFichaPers, function(rutaExt){ 
                    $("#div_ref_aux").html(rutaExt); 
                });

                $('#div_ref').addClass('oculto');
                $('#div_ref_aux').removeClass('oculto');
                $('#ifr_ref').blur();
                
                xajax_buscarPersonal(persId,null,null,'general');
                accionFichaPers = 'modificar';
            break;
        }
    } 
    function eliminar(siglas,arreglo){
        var infraccionId = $('#infraccion_id').val();
        switch (siglas){
            case 'vta':
                xajax_procesarSalida(arreglo);
            break;
            case 'pes':
                if(confirm("¿Confirmar desvinculación de personal a unidad?")){
                    xajax_eliminarPersonalEst(arreglo);
                }
            break;
            case 'usu':
                moduloFichaPers = 'usuario';
                if(snPerfUsu == 'SISTEMAS'){
                    if(confirm("¿Confirmar eliminación de este usuario?")){
                        var stringId = arreglo.join();
                        xajax_gestionUsuario('','','',stringId,'','eliminar');
                    }
                    else moduloFichaPers = null;
                }
                else alert("ERROR4X: No posee permisos para eliminar usuarios.");
            break;
        }
        $('#ifr_infraccion_'+siglas).blur();
    }
    function validaFecha(fecha){
        // alert("validando");
        var array_fecha = fecha.split("-");
        if(array_fecha.length!=3)  return false;
        
        var ano;
        ano = array_fecha[2];
        ano = parseInt(array_fecha[2],10);
        if(isNaN(ano))   return false;   
        if(ano.length<4) return false;
        var mes;
        mes = parseInt(array_fecha[1],10);
        if(isNaN(mes))   return false;   
        var dia;
        dia = parseInt(array_fecha[0],10);
        if(isNaN(dia))   return false;   
        

        if(mes==1 && dia<=31 || mes==2 && dia<=28 || mes==3 && dia<=31 || mes==4 && dia<=30 || mes==5 && dia<=31 || mes==6 && dia<=30 || mes==7 && dia<=31 || mes==8 && dia<=31 || mes==9 && dia<=30 || mes==10 && dia<=31 || mes==11 && dia<=30 || mes==12 && dia<=31){          
            return true;
        }
        else{
            if(mes==2 && dia==29){
                if(bisiesto(ano)) return true; 
                else return false;
            }
        }

    }
    function selectManual(idSelect,valor){
        var select = document.getElementById(idSelect);
        var cantOpc= select.options.length;
        for(var i=1;i<cantOpc;i++){
            var opcion = select.options[i].text;
            if(opcion == valor){
                var pos = select.options[i].selected = 'selected';
            }
        }
    }
    function cargarFotoInvol(evento,opc){
        
        if(opc == 'infractor')      var campoFoto = 'filt_foto';
        if(opc == 'involucrado')    var campoFoto = 'inv_foto';

        var input   = evento.target;
        var size    = input.files[0].size / 1000;
        var formato = input.files[0].type;
        var nombre  = input.files[0].name.toLowerCase();

        console.log(input.files[0]);

        if ((!formato.match('jpg')) && (!formato.match('jpeg'))){
            alert('ERROR: Sólo puede cargar fotos con formato jpg/jpeg.');
            return false;
        }
        if (size > 700){
            alert('ERROR: El tamaño de la foto seleccionada no puede ser mayor a 700kb.');
            return false;
        }

        if(nombre.match('.jpg'))    var extension = 'jpg';
        if(nombre.match('.jpeg'))   var extension = 'jpeg';
        if(nombre.match('.png'))    var extension = 'png';

        var reader = new FileReader();
        reader.onload = function(){
            console.log(reader);
            var dataURL = reader.result;
            var output  = document.getElementById(campoFoto);
            output.src  = dataURL;
            output.name = extension;

            if(opc == 'infractor'){
                gestBtnAceptar(null,'filt_foto',dataURL);
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
    function formReporte(rutaReporte,arrParametros){
        var div = document.getElementById('panel_right');
        var form = document.createElement("form");
        form.setAttribute('id','form_reporte');
        form.setAttribute('target','_BLANK');
        form.setAttribute('method','post');
        form.setAttribute('action',rutaReporte);
        form.setAttribute('style','display:none');

        if(arrParametros){
            for(var i=0; i < arrParametros.length; i++){
                var input = document.createElement("input");
                input.setAttribute("type","hidden");
                input.setAttribute("name", "param"+i);
                input.setAttribute("value",arrParametros[i]);
                form.appendChild(input);
                input = null;
            }
        }
        
        div.appendChild(form);
        $('#form_reporte').submit();
        $('#form_reporte').remove();
    }
    function verifExisElement(arreglo,valBusq){	 	//VERIFICA LA EXISTENCIA DE UN VALOR ESPECIFICO EN EL ARREGLO A CONSULTAR	
		var i = 0;
		var control = false;

		for (i; i<arreglo.length;i++){
			//alert(valBusq +" = " + arreglo[i]+ " ?");
			if (valBusq == arreglo[i]) control = true;
		}
		return control;
	}
    function compValArr(arreglo, valor){			//ELIMINA LOS VALORES REPETIDOS DE UN ARREGLO	
        var longitud = arreglo.length;
        var check = false;
        
        if (longitud==0) arreglo[longitud]=valor;
        else{		
            for (var i=0;i<arreglo.length;i++){
                if (arreglo[i]==valor) check = true;
            }
            if(check==false) arreglo[longitud]=valor;
        }
        return arreglo;
    }
    function inicioArbol(origen){                   // CARGA FUNCIONALIDADES INICIALES DEL ARBOL
        var rastro = $('#id_txt_rastro').val();
        
        $('.tree > ul').attr('role','tree').find('ul').attr('role', 'group');
        $('.tree').find('li:has(ul)').addClass('parent_li').attr('role', 'treeitem');
        
        if(origen == 'ajax'){
            $('.tree').find('li:has(ul)').each(function(e){       
                if($(this).attr('id') == undefined){
                    $(this).find('span i').attr('title','Expandir elemento');
                }
                else{
                    if($(this).find('li').length > 0){
                        $(this).find('span i').attr('title','Contraer elemento');
                    }
                    else{
                        $(this).find('span i').attr('title','Expandir elemento');
                    }
                }
            });
        }
        else{
            arrId.length        = 0;
            arrIdRastro.length  = 0;
        }
        $('span').on('mouseover',function(){
            $(this).parent().find('ul >li > span').addClass('sombrearHijo');
        });
        $('span').on('mouseout',function(){
            $(this).parent().find('ul >li > span').removeClass('sombrearHijo');
        });

        if(rastro != ''){
            carUltElem(rastro);
            $("#id_txt_rastro").val('');
        }
    }
    function expandirArbol(element,arbol,elementBusq,ctrlDesplegar){         // FUNCIÓN QUE SE ENCARGA DE EXPANDIR EL ARBOL
        var elemento    = element.split('_')[1];
        var enlace      = $('#'+element).children(1).children(0).attr('id');
        var longArrId   = arrId.length;
        var ctrlExiste  = false;
        var ctrlAjax    = false;
        
        if(longArrId <= 0){
            arrId[longArrId] = element;
            ctrlAjax = true;
        }
        else{
            ctrlExiste = verifExisElement(arrId,element);
            
            if(ctrlExiste == false){
                arrId[longArrId] = element;
                ctrlAjax = true;
            }
        }
        if(ctrlAjax == true){
            // if(arbol == "estructura") xajax_gestionArbol(elemento,elementBusq,ctrlDesplegar,arbol);
            // if(arbol == 'lista_estructura') xajax_gestionArbol(elemento,elementBusq,ctrlDesplegar,arbol);
            xajax_gestionArbol(elemento,elementBusq,ctrlDesplegar,arbol);

            ctrlAjax = false;
        }
        
        if($('#'+enlace).hasClass('glyphicon-plus-sign')){
            $('#'+element+'>ul').show('fast');
            $('#'+enlace).attr('title', 'Contraer elemento').addClass('glyphicon-minus-sign').removeClass('glyphicon-plus-sign');
        }
        else if($('#'+enlace).hasClass('glyphicon-minus-sign')){
            $('#'+element+'>ul').hide('fast');
            $('#'+enlace).attr('title', 'Expandir elemento').addClass('glyphicon-plus-sign').removeClass('glyphicon-minus-sign');
        }
    }
    function carUltElem(rastro){
        var rastro = rastro.split(',');
        var rastroVia = new Array();

        for(var i=0, id=rastro[i]; i<rastro.length; i++, id=rastro[i]){
            if(i == rastro.length - 1) var rastroId = "arbol_"+id;
            else rastroVia[i] = id;
        }

        cantPadres = rastroVia.length;
        // inicioArbol();
        cicloRetardo(0, cantPadres, rastroVia, rastroId, 'estructura');
    }
    function cicloRetardo(i,j,arreglo,rastroId,arbol){ 
        var id = 'arbol_'+arreglo[i];
        var ctrlExis = false;

        if(i==0) padre = 'divArbol'; 
        else padre = 'arbol_'+arreglo[i-1];

        if($('#'+padre).find('#'+id).length > 0) ctrlExis = true;

        if(ctrlExis == true){
            if(j>0){
                if(j==1){
                    expandirArbol(id,arbol,rastroId,true); 
                }
                else{
                    i++;
                    j--;
                    expandirArbol(id,arbol,undefined);
                    cicloRetardo(i,j,arreglo,rastroId,arbol);
                }
            }
        }
        else{
            setTimeout(function(){
                cicloRetardo(i,j,arreglo,rastroId,arbol);
            },100);
        }
    }
    function moverScroll(rastroId){
        $('#divArbol').animate({scrollTop: $('#'+idElemento).offset().top-190}, 1000);
    }
    function recargarArbol(){
        $('#panel_left #opcion_Estructura').click();
    }
    function pad(n, length){        //COMPLETA CON CEROS EL VALOR INGRESADO. "n" ES LA CIFRA A COMPLETAR Y "lenght" ES LA CANTIDAD DE CARACTERES QUE CONTENDRÁ EL RESULTADO
        var  n = n.toString();
        while(n.length < length)
             n = "0" + n;
        return n;
    }
    function formatoCedula(nac, cedula){
        cedula = pad(cedula, 8);
        cedula = nac+cedula;

        return cedula;
    }
    function formatoRif(tipo,rif){
        rif = pad(rif, 9); 
        rif = tipo.rif;

        return rif;
    }
    function iniciarWebCam(){
        // var shutter = new Audio();
        // shutter.autoplay = false;
        // shutter.src = navigator.userAgent.match(/Firefox/) ? 'shutter.ogg' : 'shutter.mp3';
        Webcam.set({
			width: 318,
			height: 280,
			image_format: 'jpeg'      
		});
		Webcam.attach('#filt_webcam');
    }
 	function tomarFoto(){
        // try { shutter.currentTime = 0; } catch(e) {;} // fails in IE
        // shutter.play();
            
        Webcam.snap(function(data){
            $('#filt_foto').attr('src',data);
		} );
    }   
    // function finalizarCamara(){
    //     Webcam.reset();
    //     Webcam.init();
    // }
    function mostrarMotivoRest(opc){
        var motivoRest = $('#filt_restriccion').val();
    
        if((motivoRest != '') && (motivoRest != null)){
            if(opc == '1'){
                $('.fila_textarea').addClass('oculto');
                $('.fila_rest').removeClass('oculto');
            }
            else{
                $('.fila_rest').addClass('oculto');
                $('.fila_textarea').removeClass('oculto');
            }
        }
    }
    function retirarSombreadoDtb(ifr){
        window.frames["'"+ifr+"'"].$('#tbl').find('.celdaSeleccionada').removeClass('celdaSeleccionada');
        window.frames["'"+ifr+"'"].$('#tbl').find('.onCeldaPlus').removeClass('onCeldaPlus');
        window.frames["'"+ifr+"'"].$('#tbl').find('.onCelda').removeClass('onCeldaPlus');
    }
/* -------------------------------------------------------------------------------------------------------------------- */