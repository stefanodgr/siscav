<?php
	class Visitante extends ClaseBd {
		function declararTabla() {
			$tabla = "visitante";
			$atributos['visitante_id']['esPk'] 	        = true;
            $atributos['visitante_cedula']['esPk'] 	    = false;
            $atributos['visitante_nombre']['esPk'] 	    = false;
            $atributos['visitante_apellido']['esPk'] 	= false;
            $atributos['visitante_telefono']['esPk'] 	= false;
            $atributos['visitante_direccion']['esPk'] 	= false;
            $atributos['visitante_foto']['esPk'] 	    = false;
            $atributos['visitante_org']['esPk'] 	    = false;
			$atributos['pers_id']['esPk']  				= false;
			$objetos['Conexion']['id'] 					= "conexion_id";
			$strOrderBy 								= "visitante_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);
		}

		function buscarVisitante($visitanteId, $visitanteCed, $visitanteNomb, $involApe){

			$visitanteNomb  = utf8_encode($visitanteNomb);
            $visitanteApe   = utf8_encode($visitanteApe);

			$conexionBd = new ConexionBd();

			$strFrom = 'visitante AS A LEFT JOIN lista_negra AS B ON B.visitante_id = A.visitante_id';

            if($visitanteId != null){
				$ctrlUnico = true;
                $strWhere = 'A.visitante_id = '.$visitanteId;
            }
            elseif($visitanteCed != null){
				$ctrlUnico = true;
                $strWhere = "A.visitante_cedula = '".$visitanteCed."'";
            }
            else{
				$ctrlUnico = false;
                $arrFiltros = 0;
                if($visitanteNomb != null){
                    if($arrFiltros > 0) $strWhere.= " AND A.visitante_nombre LIKE '%".$visitanteNomb."%'";
                    else{
                        $strWhere.= "A.visitante_nombre LIKE '%".$visitanteNomb."%'";
                        $arrFiltros++;
                    }
                }
                if($visitanteApe != null){
                    if($arrFiltros > 0) $strWhere.= " AND A.visitante_apellido LIKE '%".$visitanteApe."%'";
                    else{
                        $strWhere.= "A.visitante_apellido LIKE '%".$visitanteApe."%'";
                        $arrFiltros++;
                    }
                }
            }
            if($ctrlUnico){
				$strSelect  = "distinct(A.visitante_id) AS id,
							A.visitante_cedula AS cedula, 
							A.visitante_nombre AS nombre, 
							A.visitante_apellido AS apellido, 
							A.visitante_telefono AS telefono,
							A.visitante_direccion AS direccion,
							A.visitante_foto AS foto,
							A.visitante_org AS organizacion,
							A.pers_id AS metro,
							B.lista_negra_id as lista";
			}
			else{
				$strSelect  = 'A.visitante_id AS id';
                $strGroupBy = 'A.visitante_id';
			}
            
            $resultado = $conexionBd->hacerSelect($strSelect,$strFrom,$strWhere,$strGroupBy,null,$ctrol);

			return $resultado;
		}
		function consultarHistorial($visitanteId){
            $strSelect  = "A.visita_id as id,
                        A.visita_cod AS codigo,
						C.est_id AS area_id,
                        C.est_desc AS area,
						A.visita_tipo AS tipo,
						A.visita_observ AS observacion,
                        A.visita_fecha_ent AS entrada,
						A.visita_fecha_sal AS salida,
                        G.usuario_login AS usuario";
        	$strFrom    = "visita AS A
						INNER JOIN visitante AS B ON B.visitante_id = A.visitante_id
						INNER JOIN estructura AS C ON C.est_id = A.est_id
						INNER JOIN conexion AS E ON E.conexion_id = A.conexion_id
						INNER JOIN rel_perfil_usuario AS F ON F.rel_perfil_usuario_id = E.rel_perfil_usuario_id
						INNER JOIN usuario AS G ON G.usuario_id = F.usuario_id";
            $strWhere 	= 'B.visitante_id= '.$visitanteId;
			$strOrderBy = 'A.visita_id DESC';

            if($_SESSION['PerfilUsuario'] == 'TRANSCRIPTOR') $strWhere .= " AND G.usuario_login = '".$_SESSION['Login']."'";
			
			$resultado 	= $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy,true);
			
			foreach($resultado as $i => $fila){
				$estructura = new Estructura();
				$objeto = $estructura->obtenerRutaEstructura($fila['area_id'],'sede');
				$sede = $objeto[1]['cod'];
				$resultado[$i]['sede'] = utf8_decode($sede);
			}

            return $resultado;
		}
	}
?>