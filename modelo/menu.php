<?php
	class Menu extends ClaseBd {
		function declararTabla() {
			$tabla                           	= "menu";
			$atributos['menu_id']['esPk']    	= true;
			$atributos['menu_desc']['esPk']  	= false;
			$atributos['menu_link']['esPk']  	= false;
            $atributos['menu_icono']['esPk']  	= false;
            $atributos['menu_orden']['esPk']  	= false;
            $atributos['menu_activo']['esPk']  	= false;
			$atributos['menu_padre_id']['esPk'] = false;
			$this->registrarTabla($tabla, $atributos, null, $strOrderBy);
		}
}
?>