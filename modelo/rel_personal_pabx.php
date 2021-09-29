<?php
	class PersonalPabx extends ClaseBd {
		function declararTabla() {
			$tabla = "rel_personal_pabx";
			$atributos['rel_pers_pabx_id']['esPk'] 	= true;
			$atributos['pers_id']['esPk']  			= false;
            $atributos['pabx']['esPk'] 	            = false;
			$strOrderBy 							= "rel_pers_pabx_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);
		}
	}
?>