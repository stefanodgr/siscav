<?php
	class Estructura extends ClaseBd {
		function declararTabla(){
			$tabla                           	= "estructura";
			$atributos['est_id']['esPk']    	= true;
			$atributos['est_sigla']['esPk']  	= false;
			$atributos['est_desc']['esPk']  	= false;
			$atributos['est_activo']['esPk']  	= false;
			$atributos['est_padre_id']['esPk'] 	= false;
			$objetos['Conexion']['id']       	= "conexion_id";
			$strOrderBy = "est_id";
			$this->registrarTabla($tabla, $atributos, $objetos, $strOrderBy);
		}

		function consultarEstructura($padreEst,$idEst){
			$strSelect 	= 'A.est_id AS id,
						A.est_sigla AS sigla,
						A.est_desc AS descripcion,
						A.est_activo AS activo,
						A.est_padre_id AS padre';
			$strFrom 	= 'estructura AS A';
			$strWhere 	= "A.est_activo = 'T'";
			$strOrderBy = 'A.est_padre_id';

			if($padreEst) $strWhere .= " AND A.est_padre_id = ".$padreEst;
			if($idEst) $strWhere .= " AND A.est_id = ".$idEst;

			$resultado = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy,true);

			foreach($resultado as $i=>$registro){
				$arrPabx = $this->consultarPabx($registro['id']);
				if(count($arrPabx)>0){
					$resultado[$i]['rel_pabx'] 	= $arrPabx[0]['id'];
					$resultado[$i]['pabx'] 		= $arrPabx[0]['pabx'];
				}
			}

			return $resultado;
		}

		function obtenerRutaEstructura($estId,$destino,$accion){
			$ctrlSalir = false;
			$contador  = 0;
			
			switch($destino){
				case 'sede':
					$finRuta = 1;	// SI SE DESEA OBTENER LA RUTA DESDE LA SEDE DEL ÁREA BUSCAR
				break;
				default:	
					$finRuta = 0;	// SI SE DESEA OBTENER LA RUTA DESDE EL ORIGEN DEL ARBOL
				break;
			}

			do{
                $estructura = new Estructura(null,$estId);

				$objEst['id'] 	= $estructura->getAtributo('est_id');
				$objEst['cod'] 	= $estructura->getAtributo('est_sigla');
				$objEst['desc'] = $estructura->getAtributo('est_desc');
				$objEst['padre']= $estructura->getAtributo('est_padre_id');

				if($contador == 0){
					if($accion != 'eliminar') $rutaEst[] = $objEst['id'];
				}
				else $rutaEst[] = $objEst['id'];
				
                if($objEst['padre'] == $finRuta) $ctrlSalir = true;
                else $estId = $objEst['padre'];

				$contador++;
            }
            while ($ctrlSalir == false);
			
			$rutaEst = array_reverse($rutaEst);
			$resultado[0] = implode(',',$rutaEst);
			$resultado[1] = $objEst;

			return $resultado;
		}

		function consultarPabx($estId){
			$strSelect 	= 'rel_est_pabx_id AS id,pabx,est_id';
			$strFrom 	= 'rel_estructura_pabx';
			$strWhere 	= 'est_id = '.$estId;
			$strOrderBy = 'rel_est_pabx_id limit 1';

			$resultado = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy);

			return $resultado;
		}
	}
?>