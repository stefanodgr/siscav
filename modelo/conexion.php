<?php
	class Conexion extends ClaseBd {
		function declararTabla() {
			$tabla = "conexion";
			$atributos['conexion_id']['esPk'] 			= true; 
			$atributos['conexion_ip']['esPk'] 			= false;
			$atributos['conexion_fecha_ini']['esPk'] 	= false;
			$atributos['conexion_fecha_fin']['esPk'] 	= false;
			$objetos['PerfilUsuario']['id'] 			= "rel_perfil_usuario_id";
			$strOrderBy = "conexion_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);		
		}

		function consultarConexion($direccionIp, $idRelPerfilUsu){
			$strSelect 	= '	A.conexion_id AS id, 
							D.usuario_login AS login, 
							C.perfil_desc AS perfil, 
							A.conexion_fecha_ini AS fecha_inicio, 
							A.conexion_fecha_fin AS fecha_fin,
							A.conexion_ip AS ip';
			$strFrom  	= 'conexion AS A
							INNER JOIN rel_perfil_usuario AS B ON B.rel_perfil_usuario_id = A.rel_perfil_usuario_id
							INNER JOIN perfil AS C ON C.perfil_id = B.perfil_id
							INNER JOIN usuario AS D ON D.usuario_id = B.usuario_id';
			
			if($direccionIp) 	$strWhere 	= "A.conexion_ip = '".$direccionIp."' AND A.conexion_fecha_fin IS null";
			if($idRelPerfilUsu) $strWhere 	= "A.rel_perfil_usuario_id = ".$idRelPerfilUsu." AND A.conexion_fecha_fin IS null";
			if((!$direccionIp) && (!$idRelPerfilUsu)) $strWhere = "conexion_fecha_fin IS null";
			
			$strOrderBy	= "conexion_fecha_ini";
			$resultado 	= $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy); 

			return $resultado;
		}

		function cerrarConexion($direccionIp, $conexId){
			$fechaRegistro = formatoFechaHoraBd();

			if($direccionIp) 	$strQuery = "UPDATE conexion set conexion_fecha_fin = '".$fechaRegistro."' WHERE conexion_ip = '".$direccionIp."' AND conexion_fecha_fin IS NULL";
			if($conexId) 		$strQuery = "UPDATE conexion set conexion_fecha_fin = '".$fechaRegistro."' WHERE conexion_id = ".$conexId." AND conexion_fecha_fin IS NULL";

			$ctrlMod = $this->miConexionBd->hacerConsulta($strQuery);
			
			return $ctrlMod;
		}

		function validarConexion($conexId){
			$strSelect 	= '*';
			$strFrom  	= 'conexion';
			$strWhere 	= 'conexion_fecha_fin IS NULL AND conexion_id = '.$conexId;
			$resultado 	= count($this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere));

			return $resultado;
		}
	}
?>