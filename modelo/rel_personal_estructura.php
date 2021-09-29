<?php
	class PersonalEstructura extends ClaseBd {
		function declararTabla() {
			$tabla = "rel_personal_estructura";
			$atributos['rel_pers_est_id']['esPk'] 	= true;
            $atributos['rel_pers_activo']['esPk'] 	= false;
			$atributos['pers_id']['esPk']  			= false;
			$atributos['pabx']['esPk']  			= false;
			$objetos['Estructura']['id'] 			= "est_id";
			$objetos['Conexion']['id'] 				= "conexion_id";
			$strOrderBy 							= "rel_pers_est_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);
		}
	}
?>