<?php
	class Usuario extends ClaseBd {
		function declararTabla() {
			$tabla                           		= "usuario";
			$atributos['usuario_id']['esPk']    	= true;
			$atributos['usuario_login']['esPk']  	= false;
			$atributos['usuario_clave']['esPk']  	= false;
			$atributos['usuario_activo']['esPk']  	= false;
			$atributos['pers_id']['esPk']  			= false;
			$objetos['Estructura']['id'] 			= "est_id";
			$this->registrarTabla($tabla, $atributos, $objetos, $strOrderBy);
		}
	    function listaUsuarios($sede){
			$ctrlWhere = false;

			$strSelect  = "A.usuario_id AS id,
						A.usuario_login AS login,
						B.est_id AS sede_id,
						B.est_sigla AS sede_sigla,
						A.pers_id,
						D.perfil_desc AS perfil";
        	$strFrom    = "usuario AS A 
						LEFT OUTER JOIN estructura AS B ON B.est_id = A.est_id
						LEFT JOIN rel_perfil_usuario AS C ON C.usuario_id = A.usuario_id
						LEFT JOIN perfil AS D ON D.perfil_id = C.perfil_id";
            $strOrderBy = "A.usuario_login";
            
			if($sede != ''){
				$strWhere = 'B.est_id='.$sede;
				$ctrlWhere = true;
			}
			
			if($ctrlWhere) $strWhere .= ' AND A.usuario_id NOT IN (1,2)';
			else $strWhere .= 'A.usuario_id NOT IN (1,2)';

			$resultado = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy,true);

			$personal = new Personal();
            foreach($resultado as $i => $fila){
				$objeto 	= $personal->buscarPersonal($fila['pers_id']);
				$nombre 	= explode(' ',$objeto[0]['nombre']);
				$nombre 	= $nombre[0];
				$apellido 	= explode(' ',$objeto[0]['apellido']);
				$apellido 	= $apellido[0];
				
				$resultado[$i]['nombre'] = $nombre.' '.$apellido;
				$resultado[$i]['cargo'] = $objeto[0]['cargo'];
                unset($objeto);
			}
			return $resultado;
		}
	}
?>