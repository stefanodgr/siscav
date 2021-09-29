<?php
	class EstructuraPabx extends ClaseBd {
		function declararTabla() {
			$tabla = "rel_estructura_pabx";
			$atributos['rel_est_pabx_id']['esPk'] 	= true;
            $atributos['pabx']['esPk'] 	            = false;
			$objetos['Estructura']['id'] 			= "est_id";
			$strOrderBy 							= "rel_est_pabx_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);
		}
	}
?>