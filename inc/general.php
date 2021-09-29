<?php
    function validarConexion(){
		$conexion 	= new Conexion();
		$ctrl 		= $conexion->validarConexion($_SESSION['IdConexion']);
		
		if($ctrl > 0){
			$_SESSION['exp'] = time() + EXP;
			cantConexiones();
			return true;
		}
		else return false;
	}
	function cantConexiones(){
		$conexion       = new Conexion();
		$arrConexion    = $conexion->consultarConexion();
		$cantidadConex  = count($arrConexion);
		$_SESSION['cantConexion'] = $cantidadConex;
	}
    function generarCodVisita($sede){
		$conexion  = new ConexionBd();
		$visita = new Visita($conexion);
		$arrCodigo = $visita->consultarUltCodVisita($sede);
		$ultCodVisita = $arrCodigo[0]['ult_cod_visita'];

		$annioAct = date('Y');

		if($ultCodVisita){
			$fragmentos = explode($annioAct,$ultCodVisita);
			$nvoCodVisita = $sede.$annioAct.str_pad(($fragmentos[1]+1), 6, 0, STR_PAD_LEFT);
		}
		else $nvoCodVisita = $sede.$annioAct.str_pad(1, 6, 0, STR_PAD_LEFT);
		return $nvoCodVisita;
	}
	function gestionArchivo($accion,$ruta,$contenido,$cedula){

		$extension 	= array('.jpg','.jpeg','.png','.JPG','.JPEG','.PNG');

		switch($accion){
			case 'subir':
				$archivo = base64_decode($contenido);
				file_put_contents($ruta,$archivo);
			break;
			case 'consultar':
				foreach($extension as $i=>$ext){
					$evaluar = $ruta.$ext;
					if(file_exists($evaluar)) $archivo = $evaluar;
				}
				return $archivo;
			break;
			case 'remover':
				$ruta = 'multimedia/imagen/visitante/';
				foreach($extension as $i=>$ext){
					$archivo = $ruta.$cedula.$ext;
					if(file_exists($archivo)) unlink($archivo);
				}
			break;
		}
    }
?>