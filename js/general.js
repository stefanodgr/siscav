/* ------------------------------------ FUNCIONES JS UTILIZADAS EN MÚLTIPLES MÓDULOS DEL SISTEMA ------------------------------------ */
    var accionFichaPers = null;

    $(document).ready(function(){
        gestBtnFichaPers(0);

        $('#panel_right').on('click','#ficha_pers_btn_busq',function(){         // BOTÓN BÚSQUEDA DE PERSONAL POR CARNÉ DE FICHA GENERAL DE PERSONAL	
            var persCarne = $('#ficha_pers_carne').val();

            if(!persCarne){
                alert('ERROR: Debe ingresar un número de carné para proceder con la búsqueda.');
                return false;
            }
            limpiarFichaPers();
            xajax_buscarPersonal(null,null,persCarne,'general');
        });
        $('#panel_right').on('keypress','#ficha_pers_carne',function(e){        // DISPARADOR DE BÚSQUEDA DE PERSONAL POR CARNÉ DE FICHA GENERAL DE PERSONAL
            if(e.which == 13){									                // SI LA TECLA PULSADA ES LA TECLA ENTER
                $('#ficha_pers_btn_busq').click();
            }
        });
        $('#panel_right').on('click','#ficha_pers_btn_atr',function(){         // BOTÓN ATRÁS DE FICHA GENERAL DE PERSONAL									              
            if(moduloFichaPers == 'usuario'){
                $('#div_ref').removeClass('oculto');
                $('#div_ref_aux').addClass('oculto');
                $('#div_ref_aux').html('');
                window.frames['ifr_ref'].$('#tbl').find('.celdaSeleccionada').removeClass('celdaSeleccionada');
                window.frames['ifr_ref'].$('#tbl').find('.onCeldaPlus').removeClass('onCeldaPlus');
            }
            if(moduloFichaPers == 'estructura'){
                $('#div_util_arbol').removeClass('oculto');
                $('#div_util_est').removeClass('oculto');
                $('#div_util_ficha').addClass('oculto');
                $('#div_util_ficha').html('');
                window.frames['ifr_util_est'].$('#tbl').find('.celdaSeleccionada').removeClass('celdaSeleccionada');
                window.frames['ifr_util_est'].$('#tbl').find('.onCeldaPlus').removeClass('onCeldaPlus');
            }
            moduloFichaPers = null;
        });
        $('#panel_right').on('click','#ficha_pers_btn_ace',function(){         // BOTÓN ACEPTAR DE FICHA GENERAL DE PERSONAL	
            var persId      = $('#ficha_pers_id').val();	        // ID DEL PERSONAL EN TABLA PERSONAL SICTRA
            var usuId       = $('#ficha_pers_usu_id').val();        // SEDE A LA QUE PERTENECE EL USUARIO (PERSONAL)
            var persEstId   = $('#ficha_pers_rel_est_id').val();    // ID DE LA TABLA RELACION 'personal_estructura'. SI YA SE ENCONTRABA ASIGNADO A ALGUN ÁREA
            var persCarne   = $('#ficha_pers_carne').val();         // CARNÉ DEL PERSONAL
            var persPabx    = $('#ficha_pers_pabx').val();          // PABX DEL PERSONAL
            var persPerfil  = $('#ficha_pers_perfil').val();        // PERFIL DEL PERSONAL

            if(moduloFichaPers == 'estructura'){
                var estIdNvo = $('#id_txt_elemento').val();    // ID DEL AREA A LA CUAL SERÁ VINCULADO EL PERSONAL

                if(persEstId) var msgConfirm = '¿Confirmar modificación?';
                else var msgConfirm = '¿Confirmar asignación de personal a unidad?';

                if(confirm(msgConfirm)){
                    xajax_gestionPersonalEst(persId,estIdNvo,persPabx,persEstId);
                }
            }

            if(moduloFichaPers == 'usuario'){
                var estIdNvo = $('#ficha_pers_sede').val();	    // ID DE LA SEDE A LA CUAL SERÁ ASIGNADO EL USUARIO

                if(estIdNvo == 0){
                    alert("ERROR: Debe especificar la sede a la cual será asignado el usuario.");
                    $('#ficha_pers_sede').focus();
                    return false;
                }
        
                if(!usuId) var msgConfFichaPers = '¿Confirmar creación de este usuario?';
                else var msgConfFichaPers = '¿Confirmar modificación de la sede?';
        
                if(confirm(msgConfFichaPers)){
                    xajax_gestionUsuario(persId,persCarne,estIdNvo,usuId,persPerfil,accionFichaPers);
                }
            }
        });
        $('#panel_right').on('click','#ficha_pers_btn_can',function(){         // BOTÓN CANCELAR DE FICHA GENERAL DE PERSONAL									              
            if(accionFichaPers == 'modificar'){
                $('#ficha_pers_btn_atr').click();
                accionFichaPers = '';
            }
            else limpiarFichaPers();
        });
    });

    function gestBtnFichaPers(opc){
        var opc = parseInt(opc);
        switch (opc){
            case 0:
                $('#titulo_ficha_pers').html('- Búsqueda de Personal -');
                $('.ficha_pers_btn_0').removeClass('oculto');
                $('.ficha_pers_btn_1').addClass('oculto').prop('disabled',true);
                $('#ficha_pers_btn_busq').removeClass('deshabilitado').prop('disabled',false);
            break;
            case 1:
                $('#titulo_ficha_pers').html('- Ficha de Personal -');
                $('.ficha_pers_btn_0').addClass('oculto');
                $('.ficha_pers_btn_1').removeClass('oculto').prop('disabled',false);
                $('#ficha_pers_btn_busq').addClass('deshabilitado').prop('disabled',true);
            break;
            case 2:
                $('.ficha_pers_btn_0, .ficha_pers_btn_1').addClass('oculto');
                $('#ficha_pers_carne').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);    
                $('#ficha_pers_btn_busq').addClass('deshabilitado').prop('disabled',true);
            break;
        }
    }
    function gestCmpFichaPers(opc){
        var opc = parseInt(opc);

        if(moduloFichaPers == 'estructura') var campoFichaPers = '#ficha_pers_pabx';
        if(moduloFichaPers == 'usuario')    var campoFichaPers = '#ficha_pers_sede';  

        switch (opc){
            case 0: // DESACTIVA LOS CAMPOS EDITABLES DEL FORMULARIO
                $('#ficha_pers_carne').removeClass('div-inp-dis').addClass('div-inp-ena').prop('disabled',false);
                $(campoFichaPers).removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);
                
                if((moduloFichaPers == 'usuario') && (snPerfUsu == 'SISTEMAS')){
                    $('.fila_perfil').addClass('oculto');
                    $('#ficha_pers_perfil').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);
                }
            break;
            case 1: // ACTIVA LOS CAMPOS EDITABLES DEL FORMULARIO
                $('#ficha_pers_carne').removeClass('div-inp-ena').addClass('div-inp-dis').prop('disabled',true);   
                $(campoFichaPers).removeClass('div-inp-dis').addClass('div-inp-ena').prop('disabled',false);   

                if((moduloFichaPers == 'usuario') && (snPerfUsu == 'SISTEMAS')){
                    $('.fila_perfil').removeClass('oculto');
                    $('#ficha_pers_perfil').addClass('div-inp-ena').removeClass('div-inp-dis').prop('disabled',false);
                }
            break;
        }
    }
    function limpiarFichaPers(){
        $('#ficha_pers_id')         .val(''); 
        $('#ficha_pers_rel_est_id') .val(''); 
        $('#ficha_pers_usu_id')     .val(''); 
        $('#ficha_pers_carne')      .val(''); 
        $('#ficha_pers_cedula')     .val(''); 
        $('#ficha_pers_nombre')     .val('');
        $('#ficha_pers_apellido')   .val('');
        $('#ficha_pers_cargo')      .val(''); 
        $('#ficha_pers_est')        .val('');
        $('#ficha_pers_est')        .attr('name','');
        $('#ficha_pers_pabx')       .val('');
        $('#ficha_pers_sede')       .val(0);
        $('#ficha_pers_perfil')     .val(0);
        $('#ficha_pers_foto')       .attr('src','multimedia/imagen/visitante/siluetaHombre.png');
        gestBtnFichaPers(0);
        gestCmpFichaPers(0);
    }
    function actualizarIframe(){
        var modulo = moduloFichaPers;
        accionFichaPers = '';

        $('#ficha_pers_btn_atr').click();
        if(modulo == 'estructura')  window.frames['ifr_util_est'].recargar();
        if(modulo == 'usuario')     window.frames['ifr_ref'].recargar(); 
        
    }
/* ---------------------------------------------------------------------------------------------------------------------------------- */