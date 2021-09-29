// ------------------------------- FUNCIONES JS UTILIZADAS POR LA PANTALLA ESTRUCTURA ------------------------------- //
    var idSeleccionado = '';
    var arrModificados = new Array();
    var accionPersEst  = '';

    $(document).ready(function(){
        // var rastro = $('#id_txt_rastro').val();
        
        // if(rastro != ''){
        //     carUltElem(rastro);
        //     $("#id_txt_rastro").val('');
        // }
        // else inicioArbol();
       
        $('#panel_right').on('keyup','.edit',function(e){    // AL CAMBIAR EL VALOR DE CUALQUIER CAMPO EDITABLE DE LA FICHA DE ESTRUCTURA
            if(e.which != 13){
                var accion = $("#id_txt_accion")    .val();
                var id     = $("#id_txt_elemento")  .val();
                var nombre = $('#est_desc')         .val();
                var codigo = $('#est_cod')          .val();
                var padre  = $('#id_txt_nvo_padre') .val();
                var nvoValor = '';

                gestionBtnAceptarEstructura(accion,this);
            }
        });
        
        // ---------------------------------------------------- BOTONES DE ACCIÓN ----------------------------------------------------- //
            $('#panel_right').on('click','#btn_est_agr',function(){     // BOTÓN AGREGAR ESTRUCTURA  
                $(".btn_est_0").addClass("oculto");
                $(".btn_est_1").removeClass("oculto");

                $('#est_cod, #est_desc, #est_pabx, #est_descPadre').val('');
                $('#est_cod, #est_desc, #est_pabx').removeClass("div-inp-dis").addClass("div-inp-ena agregar").prop('disabled', false);
                $('#est_descPadre').addClass("agregar");
                $('#id_txt_nvo_padre').val($('#id_txt_elemento').val());
                $('#est_descPadre').val($('#id_txt_desc').val());

                $("#id_txt_accion").val('agregar');

                // if(idPadre != ""){  //PARA MODIFICAR LA UNIDAD DE ADSCRIPCION: TRANSFERENCIA DE UNIDAD
                $('#est_descPadre').attr('title',"<Seleccione en la estructura la nueva unidad de adscripción>");
                // }

                if($('#id_txt_elemento').val() == 1){
                    $("#titulo_ficha_inf").text('- Agregar Sede -');
                }
                else{
                    $("#titulo_ficha_inf").text('- Agregar Área -');
                }
            });

            $('#panel_right').on('click','#btn_est_mod',function(){     // BOTÓN MODIFICAR ESTRUCTURA
        
                var idPadre         = $('#id_txt_padre').val();
                var valPadreActual  = $('#id_txt_padre').val();
                var ctrlModificar   = false;
                
                if(idPadre != "principal"){
                    if(idPadre == 1){
                        if(snPerfUsu == 'SISTEMAS') var ctrlModificar = true;
                    }
                    else{
                        if((snPerfUsu == 'SUPERVISOR') || (snPerfUsu == 'SISTEMAS')) var ctrlModificar = true;
                    }

                    if(ctrlModificar){
                        $('#id_txt_nvo_padre').val(valPadreActual);
                        $('#btn_est_ace').prop("disabled",true).addClass('deshabilitado');     
                        $('#est_cod, #est_desc, #est_pabx').removeClass("div-inp-dis");       
                        $('#est_cod, #est_desc, #est_pabx').addClass("div-inp-ena modificar");
                        $('#est_descPadre').addClass("modificar");
                        
                        $('#est_cod, #est_desc, #est_pabx').prop('disabled', false);
    
                        $(".btn_est_0").addClass("oculto");
                        $(".btn_est_1").removeClass("oculto");
    
                        $("#id_txt_accion").val('modificar');
    
                        // if(idPadre != ""){  //PARA MODIFICAR LA UNIDAD DE ADSCRIPCION: TRANSFERENCIA DE UNIDAD
                            $('#est_descPadre').attr('title',"<Seleccione en la estructura la nueva unidad de adscripción>");
                        // }
    
                        if($('#id_txt_elemento').val() == 1){
                            $("#titulo_ficha_inf").text('- Modificar Sede -');
                        }
                        else{
                            $("#titulo_ficha_inf").text('- Modificar Área -');
                        }
                    }
                    else alert("ERROR2X: No posee permisos para modificar esta estructura.");
                    
                }
                else alert("ERROR1X: No puede modificar esta estructura.");
            });

            $('#panel_right').on('click','#btn_est_eli',function(){     // BOTÓN ELIMINAR ESTRUCTURA
                
                var idUnidad    = $('#id_txt_elemento') .val();
                var idPadre     = $('#id_txt_padre')    .val();
                var codPadre    = $('#id_txt_codPadre') .val();
                
                if(confirm("¿Confirmar eliminación de esta unidad?")){
                    xajax_gestionEstructura('eliminar',idUnidad,idPadre);
                }
            });

            $('#panel_right').on('click','#btn_est_tlf',function(){ 
                var estId = $('#id_txt_elemento').val();
                $('#ifr_util_est').attr('src','controlador/referencial/referencial.php?case=4&estId='+estId);
                $('#ficha_estructura').addClass('oculto');
                $('#div_util_est').removeClass('oculto');
            });

            $('#panel_right').on('click','#btn_est_atr',function(){ 
                $('#ifr_util_est').attr('src','');
                $('#div_util_est').addClass('oculto');
                $('#ficha_estructura').removeClass('oculto');
                $('#ifr_util_est').attr('src','');
            });

            $('#panel_right').on('click','#btn_est_per',function(){ 
                var estId = $('#id_txt_elemento').val();
                $('#ifr_util_est').attr('src','controlador/referencial/referencial.php?case=2&estId='+estId);
                $('#ficha_estructura').addClass('oculto');
                $('#div_util_est').removeClass('oculto');
            }); 
            
        // ---------------------------------------------------------------------------------------------------------------------------- //

        // --------------------------------------------------- BOTONES DE OPERACIÓN --------------------------------------------------- //
            $('#panel_right').on('click','#btn_est_ace',function(){     // BOTÓN ACEPTAR 
                var accion      = $("#id_txt_accion")   .val();
                var nombUnidad  = $('#est_desc')        .val().toUpperCase();
                var codUnidad   = $('#est_cod')         .val().toUpperCase();
                var pabxUnidad  = $('#est_pabx')        .val();
                var padreUnidad = $('#id_txt_nvo_padre').val();
                var relPabx     = $('#id_txt_rel_pabx') .val();
                
                if(accion == "agregar"){
                    // var padreUnidad = $('#id_txt_elemento').val();
                    var mensaje = "¿Confirmar creación de esta área?";
                    var accionBd = 'agregar';
                }

                if(accion == "modificar"){
                    var idUnidad    = $("#id_txt_elemento").val();
                    var mensaje = "¿Confirmar modificación de esta área?";
                    var accionBd = 'modificar';
                }

                if(confirm(mensaje)){
                    xajax_gestionEstructura(accionBd, idUnidad, codUnidad, nombUnidad, pabxUnidad, padreUnidad, relPabx);
                }
            });

            $('#panel_right').on('click','#btn_est_can',function(){     // BOTÓN CANCELAR
                
                var accion = $("#id_txt_accion").val();

                $(".btn_est_1").addClass("oculto");
                $(".btn_est_0").removeClass("oculto");
                $('#btn_est_ace').prop("disabled",false);
                $('#id_txt_nvo_padre').val(''); 

                if(accion == "agregar"){
                    $('#est_cod, #est_desc, #est_pabx').removeClass("div-inp-ena agregar").addClass("div-inp-dis").prop('disabled', true);
                    $('#est_descPadre').removeClass("agregar");
                }

                else if(accion == "modificar"){
                    $('#est_cod, #est_desc, #est_pabx').removeClass("div-inp-ena modificar").addClass("div-inp-dis").prop('disabled', true);
                    $('#est_descPadre').removeClass("modificar");
                }

                $('#est_cod')           .val($("#id_txt_cod").val());
                $('#est_desc')          .val($("#id_txt_desc").val());
                $('#est_descPadre')     .val($("#id_txt_descPadre").val());
                $("#id_txt_accion")     .val('');
                $("#titulo_ficha_inf")  .text('- Ficha de Estructura -');
                $('#est_descPadre')     .attr('title',"");
                
                var idElemento = "arbol_"+$('#id_txt_elemento').val();
                cargarFicha(idElemento);
            });
        // ---------------------------------------------------------------------------------------------------------------------------- //
    });
     
    function cargarFicha(element,ctrlDesplegar){    // CARGAR LOS DATOS DE ESTRUCTURA AL HACER CLICK SOBRE EL NOMBRE DE LA MISMA EN EL ARBOL Y LOS MUESTRA EN LA FICHA DE ESTRUCTURA
        
        $('#ficha_estructura').removeClass('oculto');
        $('#div_util_est').addClass('oculto');

        // ----- PARA DEJAR SOMBREADO EL ELEMENTO SELECCIONADO  ----- // 
        if(idSeleccionado == ''){
            idSeleccionado = element;
            $('#'+idSeleccionado+">a").addClass('seleccionado');
        }
        else{
            $('#'+idSeleccionado+">a").removeClass('seleccionado');
            idSeleccionado = element;
            $('#'+idSeleccionado+">a").addClass('seleccionado');
        }
        // --------------------------------------------------------- //
       
        var accion      = $("#id_txt_accion").val();
        var ctrlFicha   = false;
        var idPadre     = $('#'+element).parent().parent().attr('id');
        
        if((accion == 'agregar') || (accion == 'modificar')){    
            var nvoPadre = element.split('_')[1];
            $('#est_descPadre').val($('#'+element+'>a').text());
            $('#id_txt_nvo_padre').val(nvoPadre);
            $('#id_txt_nvo_padre').keyup();

            if(accion == 'agregar'){
                if($('#id_txt_nvo_padre').val() == 1) $("#titulo_ficha_inf").text('- Agregar Sede -');
                else $("#titulo_ficha_inf").text('- Agregar Área -');
            }
            else{
                if($('#id_txt_nvo_padre').val() == 1) $("#titulo_ficha_inf").text('- Modificar Sede -');
                else $("#titulo_ficha_inf").text('- Modificar Área -');
            }
        }
        else{
            $('#btn_est_mod').removeClass('oculto').prop('disabled',false);
            $('#btn_est_tlf').removeClass('oculto').prop('disabled',false);
            $('#btn_est_per').removeClass('oculto').prop('disabled',false);
            var unidad  = $('#'+element+'>input').attr('id');

            $('#divFichaEstructura').removeClass('oculto').addClass('visible');
            
            $('#id_txt_elemento')   .val(element.split('_')[1]);
            $('#id_txt_cod')        .val($('#'+element).attr('name'));
            $('#id_txt_desc')       .val($('#'+element+'>a').text());

            var relPabx = $('#'+element+'>a').attr('name').split('_')[0];
            var pabx    = $('#'+element+'>a').attr('name').split('_')[1];

            $('#id_txt_rel_pabx')   .val(relPabx);
            $('#id_txt_pabx')       .val(pabx);

            if(idPadre != undefined) $('#id_txt_padre').val(idPadre.split('_')[1]);
            else $('#id_txt_padre').val('principal');

            $('#id_txt_descPadre')  .val($('#'+idPadre+'>a').text());
            $('#id_txt_codPadre')   .val($('#'+idPadre).attr('name'));

            $('#est_cod')       .val($('#id_txt_cod').val());
            $('#est_desc')      .val($('#id_txt_desc').val());
            $('#est_descPadre') .val($('#id_txt_descPadre').val());
            $('#est_pabx')      .val($('#id_txt_pabx').val());

            if(idPadre != undefined){
                $('#dtsPadre').removeClass('oculto');
            }
            else{
                $('#dtsPadre').addClass('oculto');
            }
        }

        if(ctrlDesplegar) $('#'+element).children(0).click();
    }

    function marcarEstructura(elemento,descEst){    // CARGA LOS DATOS DE LA ESTRUCTURA SELECCIONADA EN LOS CAMPOS CORRESPONDIENTES DE LA FICHA DE VISITA
        var idEst   = elemento.split('_')[1];
        datosEst = new Array(idEst,descEst);

        capturarEst(datosEst);
    }

    function cleanCampCtrl(){
        $("#id_txt_elemento")   .val('');
        $("#id_txt_desc")       .val('');
        $("#id_txt_cod")        .val('');
        $("#id_txt_pabx")       .val('');
        $("#id_txt_padre")      .val('');
        $("#id_txt_descPadre")  .val('');
        $("#id_txt_tipoPadre")  .val('');
    }

    function gestionBtnAceptarEstructura(accion,elemento){    // GESTIONA LA ACTIVACIÓN Y DESACTIVACIÓN DEL BOTON GUARDAR AL MODIDICAR LOS CAMPOS DISPONIBLES PARA EDICIÓN 
        var id = $("#id_txt_elemento").val();

        if(accion == "modificar"){
            var idInput      = $(elemento).attr('id');
            var segIdInput   = idInput.split('_');
            
            if(idInput == "id_txt_nvo_padre"){  
                var inpControl   = $("#id_txt_padre").val();
                if($("#id_txt_nvo_padre").val() != id){
                    nvoValor = $("#id_txt_nvo_padre").val();
                }
                else{
                    nvoValor = '';
                }
            }
            else{
                var inpControl   = $("#id_txt_"+segIdInput[1]).val();
                nvoValor = $(elemento).val();
            }
            if(arrModificados.length == 0){
                if((nvoValor != inpControl)&&(nvoValor != '')){
                    arrModificados[0] = idInput;
                }
            }
            else{
                var ctrlExiste  = verifExisElement(arrModificados,idInput);
                var cantElemMod = arrModificados.length;

                if (ctrlExiste == false){
                    arrModificados[cantElemMod] = idInput;
                }
                else{
                    if((nvoValor == inpControl)||(nvoValor == '')){   //VERIFICA SI HUBO ALGUNA MODIFICACIÓN DEL VALOR ORIGINAL
                        ctrlPos = verifPosElement(arrModificados,idInput);
                        arrModificados = delPosArr(arrModificados,ctrlPos);
                    }
                }
            }
            
            // if ((arrModificados.length > 0)&&(nombre != '')&&(codigo != '')){
            if (arrModificados.length > 0){
                $('#btn_est_ace').prop("disabled",false).removeClass('deshabilitado');
            }
            else{
                $('#btn_est_ace').prop("disabled",true).addClass('deshabilitado');
            }
        }
    }

// ------------------------------------------------------------------------------------------------------------------ //
/* ************************************ */
/* ** DESARROLLADOR: HÉCTOR GONZÁLEZ ** */
/* ************************************ */