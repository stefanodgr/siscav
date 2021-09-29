/* -------------------------- FUNCIONES JS UTILIZADAS EN EL MÓDULO DE INFRACCIONES -------------------------- */ 
    var arrAct      = new Array();
    var arrMod      = new Array();
    var arrFileFoto = new Array();
    var ctrlActIfr  = false;
    var accion      = null;

    $(document).ready(function(){
        $('#panel_right').on('click','input[name = opc_vic]',function(){    // SELECCIÓN DE TIPO DE VICTIMA
			var tipoPers = $(this).val();
            camposVic(tipoPers);
            $('#btn_invol_lim').click();
		});
        $('#panel_right').on('click','#btn_busq_visita',function(){         // BOTÓN BÚSQUEDA DE VISITA
			buscarVisita();
        });
        $('#panel_right').on('click','#btn_busq_visitante',function(){      // BOTÓN BÚSQUEDA DE VISITANTE POR CÉDULA DE FICHA DE VISITA       
            if(!$('#'+this.id).hasClass('deshabilitado')){
                var nac     = $('#filt_nac').val();
                var cedula  = $('#filt_cedula').val();
                
                if(!cedula){
                    alert('ERROR: Debe ingresar un número de cédula para proceder con la búsqueda.');
                    return false;
                }
                else var valorBusq = formatoCedula(nac,cedula);

                xajax_buscarVisitante(valorBusq,'cedula');
            }
        });
        $('#panel_right').on('click','#btn_busq_pers',function(){           // BOTÓN BÚSQUEDA DE PERSONAL POR CARNÉ DE FICHA DE VISITA
            if(!$('#'+this.id).hasClass('deshabilitado')){
                var carne = $('#filt_carne').val();
            
                if(!carne){
                    alert('ERROR: Debe ingresar un número de carné para proceder con la búsqueda.');
                    return false;
                }
                else var valorBusq = carne; 
                
                xajax_buscarVisitante(valorBusq,'carne');
            }
        });
        $('#panel_right').on('click','#btn_busq_area',function(){           // BOTÓN BÚSQUEDA DE ÁREA FICHA DE VISITA
            var sedeId          = snIdEst;
            var rutaArbolEst    = 'controlador/general/lista.php?case=arbol&tipoArbol=lista_estructura&estId='+sedeId;

            $.get(rutaArbolEst, function(rutaExt){ $("#div_util_visita").html(rutaExt); });

            $('#ficha_visita').addClass('oculto');
            $('#div_util_visita').removeClass('oculto');
        });
        $('#panel_right').on('click','#btn_busq_pers_vis',function(){           // BOTÓN BÚSQUEDA DE ÁREA FICHA DE VISITA
            var areaId  = $('#filt_area').attr('name');
            var rutaLista   = 'controlador/general/lista.php?case=estPers&estId='+areaId+"&tipo=lista";

            $('#ifr_lista_pers').attr('src',rutaLista);
            $('#ficha_visita').addClass('oculto');
            $('#div_lista_pers').removeClass('oculto');
        });
        $('#panel_right').on('keypress','#filt_cedula',function(e){         // DISPARADOR DE BÚSQUEDA DE VISITANTE POR CÉDULA EN FICHA DE VISITANTE
            if(e.which != 13){									            // SI LA TECLA PULSADA ES DIFERENTE DE LA TECLA ENTER
                if(e.which != 8){ 								            // SI LA TECLA PULSADA ES DIFERENTE DE LA TECLA BORRAR
                    var ctrl = validarCadena(e,'num');
                    return ctrl;
                }
            }
            else $('#btn_busq_visitante').click();
        }); 
        $('#panel_right').on('keypress','#filt_carne',function(e){          // DISPARADOR DE BÚSQUEDA DE PERSONAL POR CARNÉ EN FICHA DE VISITANTE
            if(e.which == 13){									            // SI LA TECLA PULSADA ES LA TECLA ENTER
                $('#btn_busq_pers').click();
            }
        });
        $('#panel_right').on('click','#btn_rep_lista',function(){           // BOTÓN REPORTE DE LISTA INFRACCIÓN		
            if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')) {
                var rutaReporte = 'controlador/visita/reporte_lista.php';
                formReporte(rutaReporte);
            }
		});
        $('#panel_right').on('click','#filt_fecha_inf',function(){          // DISPARADOR DE DATETIMEPICKER AL PULSAR IMAGEN DE CALENDARIO 
            $('#filt_fecha_inf').datetimepicker({
                timepicker: true,
                format: 	'd-m-Y H:i',
                mask:       '39-19-2299 29:59',
                weeks:		true,
                dayOfWeekStart : 1,
                timepickerScrollbar:false
            });
        });
        $('#panel_right').on('click','#btn_visita_rep',function(){       // BOTÓN REPORTE DE VISITA DETALLADA  
            if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')){
                var visId = $('#filt_visita_id').val();
                var rutaReporte = 'controlador/visita/reporte_visita.php';
                var arrParam    = new Array(visId);
                formReporte(rutaReporte,arrParam);
            }
        });
        $('#panel_right').on('click','#btn_visita_sal',function(){          // BOTÓN PROCESAR SALIDA DE FICHA DE VISITANTE   
            if(!$('#'+this.id).hasClass('deshabilitado')){
                var visId = new Array($('#filt_visita_id').val());

                if(confirm('¿Confirmar la salida de esta persona?')) xajax_procesarSalida(visId);
                else return false;
            }
        });
        $('#panel_right').on('click','#btn_visita_atr',function(){          // BOTÓN ATRÁS DE FICHA DE VISITANTE 
            
            // if(rastroInfractor != null){
            //     $('#panel_left #opcion_Infractores').click();
            //     setTimeout(function(){
            //         xajax_buscarInfractor(rastroInfractor);
            //         rastroInfractor = null;
            //     },250);
            // }
            // else{
                $('#ficha_visita').addClass('oculto');
                $('#div_opc').show();
                $('#div_filtros').removeClass('oculto');
                $('#div_visita').removeClass('oculto');

                limpiarFichaVisitante();
                gestionMostrarBotones(2);

                if(ctrlActIfr){
                    window.frames['ifr_visita'].recargar();
                    ctrlActIfr = false;
                }

                // window.frames['ifr_visita'].$('#tbl').find('.celdaSeleccionada').removeClass('celdaSeleccionada');
                // window.frames['ifr_visita'].$('#tbl').find('.onCeldaPlus').removeClass('onCeldaPlus');
            // }
        }); 
        $('#panel_right').on('click','#btn_visita_ace',function(){          // BOTÓN ACEPTAR MODIFICACIÓN/REGISTRO DE INFRACCIÓN              
            if(!$('#'+this.id).hasClass('deshabilitado')){
                var vteId       = $('#filt_vte_id').val();
                var persId      = $('#filt_pers_id').val();
                var vteCedula   = formatoCedula($('#filt_nac').val(),$('#filt_cedula').val());
                var vteCarne    = $('#filt_carne').val();
                var vteNombre   = $('#filt_nombre').val();
                var vteApellido = $('#filt_apellido').val(); 
                var vteOrg      = $('#filt_org').val();
                var vteSede     = snCodEst;
                var vteArea     = $('#filt_area').attr('name');
                var persVis     = $('#filt_recibe').attr('name');
                var tipoVis     = $('#filt_tipo').val();
                var obsVis      = $('#filt_descripcion').val();

                
                if(!vteNombre){
                    alert('ERROR: Debe ingresar el nombre del visitante.');
                    return false;
                }
                if(!vteApellido){
                    alert('ERROR: Debe ingresar el apellido del visitante.');
                    return false;
                }
                
                if((!tipoVis) || (tipoVis == 0)){
                    alert('ERROR: Debe ingresar el tipo de visita.');
                    return false;
                }
                
                if((!persId) || (persId == 0)){
                    var vteFoto     = $('#filt_foto').attr('src') == 'multimedia/imagen/visitante/siluetaHombre.png' ? '' : $('#filt_foto').attr('src').split(",",2)[1];
                    var vteFotoExt  = 'jpeg';
                }
                if(!vteArea){
                    alert('ERROR: Debe indicar el área a visitar.');
                    return false;
                }
                
                if(confirm('¿Confirmar el ingreso de esta persona?')){
                    // alert(vteId+" -- "+persId+" -- "+vteCedula+" -- "+vteCarne+" -- "+vteNombre+" -- "+vteApellido+" -- "+vteOrg+" -- "+vteSede+" -- "+vteArea+" -- "+persVis+" -- "+tipoVis+" -- "+obsVis);
                    xajax_registrarVisita(vteId,persId,vteCedula,vteCarne,vteNombre,vteApellido,vteOrg,vteSede,vteArea,persVis,tipoVis,obsVis,vteFoto);
                }
                else return false;
            }
        });   
        $('#panel_right').on('click','#btn_visita_can',function(){          // BOTÓN CANCELAR REGISTRO DE VISITA
            // $('.btn_visita_1').addClass('oculto');
            // $('.btn_visita_0').removeClass('oculto');
            $('#btn_visita_atr').click();
            limpiarFichaVisitante();
            accion = null;
            arrAct.length = 0;
        });  
        $('#panel_right').on('click','#btn_visita_lim',function(){          // BOTÓN LIMPIAR DE FICHA DE VISITA
            limpiarFichaVisitante();
            camposVisita(0);
        }); 
        $('#panel_right').on('click','.fileuploader-item-inner',function(){ // CLICK EN FOTO EVIDENCIA
            var src = $(this).find('img').attr('src');

            $('.preview').css('visibility','visible');
            $('.contenido').addClass('oculto');

            $('.img-preview').attr('src',src);
        });
        $('#panel_right').on('click','#btn_tomar_foto',function(){          // BOTÓN TOMAR FOTO DE VISITANTE 
            if(!$('#'+this.id).hasClass('deshabilitado')){
                if($('#'+this.id).hasClass('cam-activa')){
                    $('#'+this.id).removeClass('cam-activa');
                    $('#filt_foto').removeClass('oculto');
                    $('#filt_webcam').addClass('oculto');
                    tomarFoto();
                }
                else{
                    $('#filt_foto').addClass('oculto');
                    $('#filt_webcam').removeClass('oculto');
                    $('#'+this.id).addClass('cam-activa');
                    iniciarWebCam();
                }
            }
            else{
                alert("camara bloqueada");
            }
        });       
	});

    function buscarVisita(){
     
        var filtCodigo  = $('#filt_codigo').val();
        var filtEstado  = $('#filt_estado').prop('checked') ? 1 : 0;
        var filtSede    = $('#selSede').val();
        var filtArea    = 0;
        var filtDesde   = $('#f_desde').val();
        var filtHasta   = $('#f_hasta').val();

        switch($('#selTipo').val()){
            case '0':
                var filtTipo = 'TODOS';
            break;
            case '1':
                var filtTipo = 'LABORAL';
            break;
            case '2':
                var filtTipo = 'PERSONAL';
            break;
        }

        arrFiltros    = new Array();
        arrFiltros[0] = filtCodigo;
        arrFiltros[1] = filtEstado;
        arrFiltros[2] = filtTipo;
        arrFiltros[3] = filtDesde;
        arrFiltros[4] = filtHasta;

        // alert(filtCodigo+" -- "+filtEstado+" -- "+filtTipo+" -- "+filtDesde+" -- "+filtHasta);

        $('#ifr_visita').attr('src','controlador/visita/visita.php?case=1&tipo=filtros&filtros='+arrFiltros);
        
    }
    function cargarVisita(idReg){
        $('#div_opc').hide();
        $('#div_filtros').addClass('oculto');
        $('#div_visita').addClass('oculto');
        $('#ficha_visita').removeClass('oculto');
        $('#ifr_visita').blur();
        $('#titulo_ficha_inf').html('- Ficha de Visita -');
        $('.frm_0').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);
        $('#filt_tipo').prop('disabled',true);
        $('#btn_busq_visitante, #btn_busq_pers').addClass('deshabilitado');
        xajax_buscarVisita(idReg);
    }
    function limpiarFichaVisitante(){
        $('#filt_visita_id')    .val(''); 
        $('#filt_vte_id')       .val(''); 
        $('#filt_pers_id')      .val(''); 
        $('#filt_visita_cod')   .val('');
        $('#filt_usuario')      .val('');
        $('#filt_fecha_inf')    .val('');
        $('#filt_registro')     .val('');
        $('#filt_cedula')       .val('');
        $('#filt_carne')        .val('');
        $('#filt_nombre')       .val('');
        $('#filt_apellido')     .val('');
        $('#filt_org')          .val('');
        $('#filt_area')         .val('');
        $('#filt_recibe')       .val(''); 
        $('#filt_descripcion')  .val('');
        $('#filt_foto')         .attr('src','multimedia/imagen/visitante/siluetaHombre.png');
        document.getElementById('filt_tipo').options[0].selected = 'selected';
        // finalizarCamara();
        $('#filt_foto').removeClass('oculto');
        $('#filt_webcam').addClass('oculto');
    }
    function gestionMostrarBotones(opc){
        var opc = parseInt(opc);
        switch (opc){
            case 0:
                $('.btn_visita_0').removeClass('oculto');
                $('.btn_visita_1').addClass('oculto');
                gestionBtnReporteVisita();
            break;
            case 1:
                $('.btn_visita_0').addClass('oculto');
                $('.btn_visita_1').removeClass('oculto');
            break;
            case 2:
                $('.btn_visita_0, .btn_visita_1').addClass('oculto');
            break;
        }
    }
    function gestionBtnAceptarVisita(opc){
        var opc = parseInt(opc);
        switch (opc){
            case 0:
                $('#btn_visita_ace').prop('disabled',true).addClass('deshabilitado');
            break;
            case 1:
                
                $('#btn_visita_ace').prop('disabled',false).removeClass('deshabilitado');
            break;
        }
    }
    function gestionBtnSalida(opc){
        var opc = parseInt(opc);
        switch (opc){
            case 0:
                $('#btn_visita_sal').prop('disabled',true).addClass('deshabilitado').addClass('oculto');
            break;
            case 1:
                $('#btn_visita_sal').prop('disabled',false).removeClass('deshabilitado').removeClass('oculto');
            break;
        }
    }
    function gestionBtnReporteVisita(){
        if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')) $('#btn_visita_rep').removeClass('oculto');
        else $('#btn_visita_rep').addClass('oculto');
    }
    function confirmarOperacion(){
        ctrlActIfr = true;
        $('#btn_visita_atr').click();
    }
    function cargarArrActual(){
        arrAct['infraccion_id']   = $('#infraccion_id').val();
        arrAct['filt_usuario']    = $('#filt_usuario').val();
        arrAct['filt_registro']   = $('#filt_registro').val();
        arrAct['filt_rim_inf']    = $('#filt_rim_inf').val();
        arrAct['filt_fecha_inf']  = $('#filt_fecha_inf').val();
        arrAct['filt_lugar']      = $('#filt_lugar').val();
        arrAct['filt_descripcion']= $('#filt_descripcion').val();
        arrAct['filt_actividad']  = $('#filt_actividad').val();
        arrAct['filt_estado']     = $('#filt_estado').val();
        arrAct['filt_ubicacion']  = $('#filt_ubicacion').val();
        arrAct['filt_ubicacion2'] = $('#filt_ubicacion2').val();
    }
    function infReincidencia(opc){
        var opc = parseInt(opc);

        switch(opc){
            case 1:
                $('.inf-rei-inv').removeClass('oculto');
            break;
            case 2:
                $('.inf-rei-inv').addClass('oculto');
            break;
        }
    }
    function camposVisita(opc){
        opc = parseInt(opc);
        switch (opc){
            case 0: // AL CARGAR LA FICHA DE VISITANTE
                $('.frm_0').removeClass('div-inp-dis').addClass('div-inp-ena').prop('disabled',false);
                $('.frm_1').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);
                $('.frm_2').prop('disabled',true);
                $('#btn_busq_area, #btn_busq_pers_vis, #btn_tomar_foto').addClass('deshabilitado');
                $('#btn_busq_visitante, #btn_busq_pers').removeClass('deshabilitado');
                $('#filt_descripcion').removeClass('div-inp-ena').addClass('div-inp-dis');
                infAcceso(0);
                gestionBtnAceptarVisita(0);
            break;
            case 1: // PERSONA ENCONTRADA EN TABLA VISITANTE PERSONAL METRO
                $('.frm_0').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);
                $('.frm_2').prop('disabled',false);
                $('#btn_busq_area, #btn_busq_pers_vis').removeClass('deshabilitado');
                $('#btn_busq_visitante, #btn_busq_pers').addClass('deshabilitado');
                $('#filt_descripcion').removeClass('div-inp-dis').addClass('div-inp-ena');
            break;
            case 2: // PERSONA NO ENCONTRADA EN TABLA VISITANTE NI EN TABLA PERSONAL
                $('.frm_0').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);
                $('.frm_2').prop('disabled',false);
                $('.frm_1').removeClass('div-inp-dis').addClass('div-inp-ena').prop('disabled',false);
                $('#filt_descripcion').removeClass('div-inp-dis').addClass('div-inp-ena');
                $('#btn_busq_area, #btn_busq_pers_vis, #btn_tomar_foto').removeClass('deshabilitado');
                $('#btn_busq_visitante, #btn_busq_pers').addClass('deshabilitado'); 
            break;
        }
    }
    function infAcceso(opc){
        var opc = parseInt(opc);
        switch (opc){
            case 0:
                $('.inf_autoriz').addClass('acceso');
                $('.inf_autoriz').removeClass('autorizado');
                $('.inf_autoriz').removeClass('restringido');
                $('.inf_autoriz').html('INFORMACIÓN');
            break;
            case 1:
                $('.inf_autoriz').addClass('autorizado');
                $('.inf_autoriz').removeClass('acceso');
                $('.inf_autoriz').removeClass('restringido');
                $('.inf_autoriz').html('AUTORIZADO');
            break;
            case 2:
                $('.inf_autoriz').addClass('restringido');
                $('.inf_autoriz').removeClass('acceso');
                $('.inf_autoriz').removeClass('autorizado');
                $('.inf_autoriz').html('RESTRINGIDO');
            break;
        }
    }
    function capturarEst(datosEst){
        $("#div_util_visita").html('');
        $('#filt_area').val(datosEst[1]);
        $('#filt_area').attr('name',datosEst[0]);
        $('#ficha_visita').removeClass('oculto');
        $('#div_util_visita').addClass('oculto');
        $('#filt_recibe').val('');
        $('#filt_recibe').attr('name','');
    }
/* ---------------------------------------------------------------------------------------------------------- */