<?php
	class Perfil extends ClaseBd{
		function declararTabla() {
			$tabla                           	= "perfil";
			$atributos['perfil_id']['esPk']    	= true;
			$atributos['perfil_desc']['esPk']  	= false;
			$atributos['perfil_activo']['esPk'] = false;
			$this->registrarTabla($tabla, $atributos, null, $strOrderBy);
		}
}
?>