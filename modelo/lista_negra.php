<?php
	class ListaNegra extends ClaseBd {
		function declararTabla() {
			$tabla                           	        = "lista_negra";
			$atributos['lista_negra_id']['esPk']    	= true;
			$atributos['lista_negra_observ']['esPk']  	= false;
			$objetos['Visitante']['id'] 				= "visitante_id"; 
            $objetos['Conexion']['id'] 				    = "conexion_id";
			$this->registrarTabla($tabla, $atributos, $objetos, $strOrderBy);
		}
}
?>