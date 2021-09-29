<?php
	class PerfilUsuario extends ClaseBd {
		function declararTabla() {
			$tabla 										= "rel_perfil_usuario";
			$atributos['rel_perfil_usuario_id']['esPk'] = true;
			$objetos['Usuario']['id'] 					= "usuario_id";
			$objetos['Perfil']['id'] 					= "perfil_id";
			$strOrderBy 								= "rel_perfil_usuario_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);
		}
	}
?>