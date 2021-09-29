/* ------------------------------- FUNCIONES JS UTILIZADAS EN EL MÓDULO VISITANTES ------------------------------- */
    var arrActual       = new Array();
    var arrModificado   = new Array();
    var accion          = null;

    $(document).ready(function(){
        /* ----------------- BOTON CONSULTAR (LUPA) --------------- */
        $('#panel_right').on('click','#btn_busq_infractor', function(){		    // CLICK EN EL BOTÓN LUPA BÚSQUEDA DE FICHA
            if(rastroInfraccion == null) buscarVisitante();
        });
        /* -------------------------------------------------------- */
        
        /* -------------------- BOTON CONSULTAR ------------------- */
        $('#panel_right').on('click','#btn_visitante_bus', function(){		    // DETECTA CLICK EN EL BOTON 'btn_visitante_bus' (Consultar)
            if(rastroInfraccion != null){
                $('#panel_left #opcion_Infracciones').click();
                setTimeout(function(){
                    cargarVisita(rastroInfraccion)
                    rastroInfraccion = null;
                },250);
            }
            else buscarVisitante();
        });
        /* -------------------------------------------------------- */

        /* ------------------- BOTON REPORTE PDF ------------------ */
        $('#panel_right').on('click','#btn_visitante_rep', function(){ 		    // DETECTA CLICK EN EL BOTON 'btn_visitante_rep' (Generar Reporte)
            if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')){
                var idVisitante = $('#filt_id').val();
                var rutaReporte = 'controlador/visitante/reporte_visitante.php';
                var arrParam    = new Array(idVisitante);
                formReporte(rutaReporte,arrParam);
            }
        });
        /* -------------------------------------------------------- */

        /* --------------------- BOTON LIMPIAR -------------------- */
        $('#panel_right').on('click','#btn_visitante_lim', function(){ 		    // DETECTA CLICK EN EL BOTON 'btn_visitante_lim' (Limpiar)
            // if(rastroInfraccion != null){
            //     $('#panel_left #opcion_Infracciones').click();
            //     setTimeout(function(){
            //         cargarVisita(rastroInfraccion)
            //         rastroInfraccion = null;
            //     },250);
            // }
            // else{

            $('.frm_vis_0').val('').prop('disabled',false).removeClass('div-inp-dis').addClass('div-inp-ena');
            $('.frm_vis_1').val('');
            $('#filt_nac').val('').prop('disabled',false);
            $('#filt_carne').val('').prop('disabled',true).removeClass('div-inp-ena').addClass('div-inp-dis');;
            $('#btn_busq_infractor').prop('disabled',false);
            $('#filt_foto').attr('src','multimedia/imagen/visitante/siluetaHombre.png');
            $('.modal_titulo').text('- Búsqueda de Visitante -');
            $('#historial_visitante').addClass('oculto');
            $('#ifr_historial').attr('src','');
            $('#btn_visitante_rep').addClass('oculto');
            $('#filt_visitas, #filt_ult_visita').val('');
            $('#filt_restringir').prop('checked',false);
            $('#lblRestringido').addClass('oculto');
            $('#filt_restringir').addClass('oculto');
            $('#divEtiquetObserv').html('');
            $('#visit_id').val('');
            $('#filt_restriccion').val('');
            document.getElementById('filt_nac').options[0].selected = 'selected';
            gestionBtnInfractor(0);
            gestionAcceso(0);
            accion = null;
            // }
        });
        /* -------------------------------------------------------- */

        /*CLICK AL CHECKBOX DE RESTRICCIÓN DE ACCESO (LISTA NEGRA) */
        $('#panel_right').on('click',"#filt_restringir", function (){

            if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')){
                if($(this).is(':checked')){
                    var visit_id=  document.getElementById('filt_id').value;

                    if(visit_id != ''){
                        var observ = prompt("Indique el motivo por el cual se restringe el acceso:");
                        if(observ == null) $('#filt_restringir').prop('checked',false);
                        else{
                            if(observ == ''){
                                alert("ERROR: Debe endicar el motivo por el cual se aplica la restricción.");
                                $('#filt_restringir').prop('checked',false);
                            }
                            else{
                                xajax_agregarListaNegra(visit_id,observ);
                                buscarVisitante();
                            }
                        }
                    }
                } 
                else{
                    var conf = confirm("¿Confirmar eliminación de restricción?");
                    if(conf){
                        var listaNegraId = document.getElementById('filt_restriccion').name;
                        xajax_eliminarListaNegra(listaNegraId);
                        buscarVisitante();
                    }
                    else $('#filt_restringir').prop('checked',true);
                }
            }
            else{
                alert("ERROR5X: No posee permisos para gestionar el acceso de visitantes.");

                if($(this).is(':checked')) $(this).prop('checked',false);
                else $(this).prop('checked',true);
            }
        });
        /* -------------------------------------------------------- */ 
        
        $('#panel_right').on('keypress','.frm_vis_0',function(e){ 				// DETECTA EL PULSO DE UNA TECLA SOBRE LOS ELEMENTOS CON CLASE 'frm_vis_0'
            if(e.which != 13){									            // SI LA TECLA PULSADA ES DIFERENTE DE LA TECLA ENTER
                if(e.which != 8){ 								            // SI LA TECLA PULSADA ES DIFERENTE DE LA TECLA BORRAR
                    var idElement = this.id;
                    if(idElement == 'filt_cedula_vte'){
                        var ctrl = validarCadena(e,'num');
                        return ctrl;
                    }
                }
            }
            else{
                buscarVisitante();
                this.blur();
            }
        });

        $('#panel_right').on('change','#filt_nac',function(){
            gestBtnAceptar(null,this.id,this.value);
        });

        $('#panel_right').on('keyup','.edit',function(e){
            if(e.which != 13){
                if(accion == 'modificar'){
                    var valor   = this.value;
                    var id      = this.id;
                    var existe  = false;
                    gestBtnAceptar(null,id,valor);
                }
            }
        });    
    });

    function buscarVisitante(tipo,idVisitante){
        var filtTipoCedula 	= document.getElementById('filt_nac')		.value;
        var filtCedula 		= document.getElementById('filt_cedula_vte').value.toUpperCase();
        var filtNombre 		= document.getElementById('filt_nombre')	.value.toUpperCase();
        var filtApellido 	= document.getElementById('filt_apellido')	.value.toUpperCase();

        if(tipo){
            if(tipo == 'infraccion'){
                $('#btn_visitante_lim').val('Atrás');
                $('#btn_visitante_bus').val('Atrás');
                xajax_buscarVisitanteFiltro(idVisitante);
            }
        }
        else{
            if((filtCedula == '')&&(filtNombre == '')&&(filtApellido == '')) {
                alert("ERROR: Debe establecer al menos un parámetro de búsqueda.")
                document.getElementById('filt_cedula_vte').focus();
            }
            else{
                $('#btn_visitante_lim').click();
                xajax_buscarVisitanteFiltro(null,filtTipoCedula,filtCedula,filtNombre,filtApellido);
            }
        }
    }

    function mostrarVisitante(idVisitante,infractorNombre,$metroId){
        $('#lista_visitante').addClass('oculto'); 
        $('#ficha_visitante').removeClass('oculto'); 
        $('.modal_titulo').text('- Ficha del Visitante -');

        bloquearFiltros();
        gestionBtnInfractor(1);
        cargarHistorial(idVisitante,infractorNombre);

        // if($metroId != '') $('.inf-metro').removeClass('oculto');
        $('#historial_visitante').removeClass('oculto');

        if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')) $('#btn_visitante_rep').removeClass('oculto');
        accion = null;
    }

    function bloquearFiltros(){
        $('.frm_vis_0, .frm_vis_1').prop('disabled',true);
        $('.frm_vis_0, .frm_vis_1').removeClass('div-inp-ena').addClass('div-inp-dis');
        $('#filt_nac').prop('disabled',true);
        $('#btn_busq_infractor').prop('disabled',true);
    }

    function listaVisitante(lista){
        $('#ifr_lista_visitante').attr('src','controlador/visitante/visitante.php?case=2&lista='+lista);
        $('#ficha_visitante').addClass('oculto');
        $('#historial_visitante').addClass('oculto');
        $('#lista_visitante').removeClass('oculto');
    }

    function cargarHistorial(idVisitante,infractorNombre){
        var ifr = document.getElementById('ifr_historial');
        ifr.src = 'controlador/visitante/visitante.php?case=1&infId='+idVisitante+"&infNombre="+infractorNombre;
    }

    function gestionBtnInfractor(caso){
        switch (caso){
            case 0: 	
                $('.btn_infractor_0').removeClass('oculto');
                $('.btn_infractor_1').addClass('oculto');
                $('.btn_infractor_2').addClass('oculto');
            break;
            case 1:	
                $('.btn_infractor_0').addClass('oculto');
                $('.btn_infractor_1').removeClass('oculto');
                $('.btn_infractor_2').addClass('oculto');
            break;
            case 2: 
                $('.btn_infractor_0').addClass('oculto');
                $('.btn_infractor_1').addClass('oculto');
                $('.btn_infractor_2').removeClass('oculto');
            break;
        }
        // if(snPerfUsu != 'SUPERVISOR'){
        //     if(!$('#btn_infractor_mod').hasClass('oculto')) $('#btn_infractor_mod').addClass('oculto');
        // }
    }

    function cargarDatos(){
        arrActual['filt_id']         = $('#filt_id').val();
        arrActual['filt_nac']        = $('#filt_nac').val();
        arrActual['filt_cedula']     = $('#filt_cedula_vte').val();
        arrActual['filt_nombre']     = $('#filt_nombre').val();
        arrActual['filt_apellido']   = $('#filt_apellido').val();
        arrActual['filt_telefono']   = $('#filt_telefono').val();
        arrActual['filt_direccion']  = $('#filt_direccion').val();
        arrActual['filt_foto']       = $('#filt_foto').attr('src').split(",",2)[1] == '' ? '' : $('#filt_foto').attr('src').split(",",2)[1];
    }

    function restaurarDatos(){
        $('#filt_id')           .val(arrActual['filt_id']);
        $('#filt_nac')          .val(arrActual['filt_nac']);
        $('#filt_cedula_vte')   .val(arrActual['filt_cedula']);
        $('#filt_nombre')       .val(arrActual['filt_nombre']);
        $('#filt_apellido')     .val(arrActual['filt_apellido']);
        $('#filt_telefono')     .val(arrActual['filt_telefono']);
        $('#filt_direccion')    .val(arrActual['filt_direccion']);
        $('#filt_foto')         .attr('src',arrActual['filt_foto']);

        arrActual.length = 0;
    }

    function infReincidenciaInf(opc){
        var opc = parseInt(opc);

        switch(opc){
            case 1:
                $('.inf_reincidencia').show();
            break;
            case 2:
                $('.inf_reincidencia').hide();
            break;
        }
    }

    function gestionAcceso(opc){
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
                $('#filt_restringir').prop('checked',false);
            break;
            case 2:
                $('.inf_autoriz').addClass('restringido');
                $('.inf_autoriz').removeClass('acceso');
                $('.inf_autoriz').removeClass('autorizado');
                $('.inf_autoriz').html('RESTRINGIDO');
                $('#filt_restringir').prop('checked',true);
            break;
        }
    }
/* ---------------------------------------------------------------------------------------------------------------- */