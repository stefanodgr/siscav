<?php
	$xajax 			= new xajax();							// INSTANCIA DE CLASE XAJAX
	$objResponse 	= new xajaxResponse();					// INSTANCIA DE CLASE XAJAX RESPONSE

	include_once $rutaDir.'inc/ajax_ext.php';				// INCLUSION DE ARCHIVOS XAJAX EXTERNOS

	$xajaxJs = $xajax->getJavascript($rutaDir.'libreria/'); // CARGA DE FUNCIONES XAJAX EN VARIABLE
		
	$xajax->processRequests();
?>