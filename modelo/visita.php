<?php
	class Visita extends ClaseBd {
		function declararTabla() {
			$tabla = "visita";
			$atributos['visita_id']['esPk'] 	    = true;
            $atributos['visita_cod']['esPk'] 	    = false;
            $atributos['visita_tipo']['esPk'] 	    = false;
            $atributos['visita_fecha_ent']['esPk'] 	= false;
            $atributos['visita_fecha_sal']['esPk'] 	= false;
            $atributos['visita_observ']['esPk'] 	= false;
			$atributos['pers_id']['esPk']  			= false;
			$objetos['Conexion']['id'] 				= "conexion_id";
            $objetos['Visitante']['id'] 			= "visitante_id";
			$objetos['Estructura']['id'] 		    = "est_id";
			$strOrderBy 							= "visita_id";
			$this->registrarTabla($tabla,$atributos,$objetos,$strOrderBy);
		}
	    function listaVisitas($tipo,$filtros){
            if($filtros != '') $filtros = explode(',',$filtros);
            
			$strSelect  = "A.visita_id AS id,
                        A.visita_cod AS codigo,
                        C.est_id AS area_id,
                        C.est_desc AS area,
                        A.visita_tipo AS tipo,
                        B.visitante_nombre || ' ' || B.visitante_apellido AS visitante,
                        B.visitante_cedula AS cedula,
                        A.pers_id,
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
            $strOrderBy = "A.visita_fecha_ent DESC";
            
            if($tipo != 'inicial'){
                $length = 0;
                if($filtros[0] != ''){
                    $strWhere = "A.visita_cod like '%".strtoupper($filtros[0])."%'";
                    $length++;
                }
                if($filtros[1] == 1){
                    if($length > 0) $strWhere .= ' AND A.visita_fecha_sal IS NULL';
                    else{
                        $strWhere = 'A.visita_fecha_sal IS NULL';
                        $length++;
                    }
                }
                if($filtros[2] != 'TODOS'){
                    if($length > 0) $strWhere .= " AND A.visita_tipo = '".$filtros[2]."'";
                    else{
                        $strWhere = "A.visita_tipo = '".$filtros[2]."'";
                        $length++;
                    }
                }
                if($filtros[3] != null){
                    $ctrlFechaDesde = false;
                    $filtros[3] = formFechaBd($filtros[3],'d/m/Y');

                    if($filtros[4] != null){
                        $filtros[4] = formFechaBd($filtros[4],'d/m/Y');

                        if($length  > 0) $strWhere.= " AND A.visita_fecha_ent BETWEEN '".$filtros[3]." 00:00:00' AND '".$filtros[4]." 23:59:59'";
                        else{
                            $strWhere = "A.visita_fecha_ent BETWEEN '".$filtros[3]." 00:00:00' AND '".$filtros[4]." 23:59:59'";
                            $length++;
                        }
                    }
                    else{
                        if($length  > 0) $strWhere.= " AND A.visita_fecha_ent BETWEEN '".$filtros[3]." 00:00:00' AND '".$filtros[3]." 23:59:59'";
                        else{
                            $strWhere = "A.visita_fecha_ent BETWEEN '".$filtros[3]." 00:00:00' AND '".$filtros[3]." 23:59:59'";
                            $length++;
                        }
                    }
                }
                else{
                    if($filtros[4] != null){
                        $filtros[4] = formFechaBd($filtros[4],'d/m/Y');
                        
                        if($length  > 0) $strWhere.= " AND A.visita_fecha_ent < '".$filtros[4]." 23:59:59'";
                        else{
                            $strWhere = "A.visita_fecha_ent < '".$filtros[4]." 23:59:59'";
                            $length++;
                        }
                    }
                }
            }
            else{
                $strWhere = 'A.visita_fecha_sal IS NULL';
            }            
            
			$resultado = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy,true);
            
            $estructura = new Estructura();
            foreach($resultado as $i => $fila){
				$objeto = $estructura->obtenerRutaEstructura($fila['area_id'],'sede');
				$sede = $objeto[1]['cod'];
                $resultado[$i]['sede'] = utf8_decode($sede);
                unset($objeto);
            }
            
            // $personal = new Personal();
            // foreach($resultado as $j => $fila){
            //     if($fila['pers_id']){
            //         $objeto     = $personal->buscarPersonal($fila['pers_id']);
            //         $personal   = $objeto[0]['carne'];
            //         $resultado[$j]['personal'] = utf8_decode($personal);
            //         unset($objeto);
            //     }
            // }
            
            $perfilUsu = $_SESSION['PerfilUsuario'];
            $codEstUsu = $_SESSION['codEstructura'];

            if($perfilUsu == 'TRANSCRIPTOR'){
                $l = 0;
                foreach ($resultado as $k => $fila) {
                    if($fila['sede'] == $codEstUsu){
                        $resultadoFilt[$l] = $fila;
                        $l++;
                    }
                }
                return $resultadoFilt;
            }
            else return $resultado;
		}
        function buscarVisita($visitaId,$codVisita){
            $strSelect  = "A.visita_id id,
                        A.visita_cod codigo, 
                        A.visita_fecha_ent fecha_ini, 
                        A.visita_fecha_sal fecha_fin,
                        B.visitante_id id_vte, 
                        B.visitante_cedula cedula,
                        B.visitante_nombre nombre,
                        B.visitante_apellido apellido,
                        B.visitante_org organizacion,
                        B.visitante_foto foto,
                        B.pers_id pers_id, 
                        C.est_desc area,
                        A.pers_id personal,
                        A.visita_tipo tipo,
                        A.visita_observ observacion,
                        D.conexion_fecha_ini fecha_reg,
                        F.usuario_login usuario,
                        G.lista_negra_id id_lista";

        	$strFrom    = "visita A
                        INNER JOIN visitante B ON B.visitante_id = A.visitante_id
                        INNER JOIN estructura C ON C.est_id = A.est_id
                        INNER JOIN conexion D ON D.conexion_id = A.conexion_id
                        INNER JOIN rel_perfil_usuario E ON E.rel_perfil_usuario_id = D.rel_perfil_usuario_id
                        INNER JOIN usuario F ON F.usuario_id = E.usuario_id
                        LEFT JOIN lista_negra G ON G.visitante_id = B.visitante_id";
            
			$strWhere 	= "A.visita_id = ".$visitaId;

            $visita = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere);
            
            $personal = new Personal();
            foreach($visita as $i=>$fila){
                if($fila['personal']){
                    $objeto = $personal->buscarPersonal($fila['personal']);
                    $nombre = explode(' ',$objeto[0]['nombre']);
                    $nombre = $nombre[0];
                    $apellido = explode(' ',$objeto[0]['apellido']);
                    $apellido = $apellido[0];
                    $visita[$i]['personal'] = $nombre." ".$apellido;
                    $visita[$i]['carne']    = $objeto[0]['carne'];
                }
            }

			if($visita) return $visita;
			else return false;
        }
        function consultarUltCodVisita($sede){
            $annioAct = date('Y');
            // $annioAct = '2018';
            $annioSig = $annioAct + 1;

            $strSelect 	= 'visita_cod AS ult_cod_visita';
            $strFrom 	= 'visita';
            $strWhere 	= "visita_cod like '".$sede.date('Y')."%'";
            $strOrderBy = 'visita_cod desc limit 1';

            $resultado = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy);
            file_put_contents(RUTA_SISTEMA."documento/txt/ultim.txt", $resultado[0]['ult_cod_visita']);

            return $resultado;
        }
        function consultarVisitaActiva($vteId){
			$strSelect 	= "*";
			$strFrom 	= "visita";
            $strWhere 	= "visitante_id = ".$vteId." AND visita_fecha_sal IS NULL"; 
            $strOrderBy = "visita_id desc limit 1";
            
            $resultado = $this->miConexionBd->hacerSelect($strSelect,$strFrom,$strWhere,null,$strOrderBy);

            return $resultado;
		}
    }
?>