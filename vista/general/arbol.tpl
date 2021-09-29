<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>

        <!-- -------------------------------------- FUNCIONES JAVASCRIPT -------------------------------------- -->
            <script type="text/javascript">
                $(document).ready(function(){
                    inicioArbol();
                });
            </script>
        <!-- -------------------------------------------------------------------------------------------------- -->
	</head>
	<body>
        <div id='divArbol' class="tree well" style="padding-left:0px;padding-top:0px;">
            <ul style="margin-left:0px;padding-left:0px;">
                <li style="position:relative;left:0%;">
                    <span style="border:0px">
                        <i class="glyphicon glyphicon-record"></i>
                    </span>  
                    <ul>
                        <li id="arbol_[arbol.id;block=li;]" name="[arbol.codigo]" class="parent_li">
                            <input type="hidden" id="[arbol.tipo;noerr]" value="[arbol.padre]">					                	
                            <span style="border:0px" onclick='expandirArbol(this.parentNode.id,"[var.tipoArbol;noerr;]");'>
                                <i id = "est_[arbol.id]" class="glyphicon glyphicon-plus-sign"></i>
                            </span>
                            <a onclick = "[var.accionNodo;noerr;]" name="[arbol.rel_pabx;noerr]_[arbol.pabx;noerr]">[arbol.descripcion]</a>
                        </li>            
                    </ul>
                </li>
                <li>
                    <span title ="Fin de Estructura" style="border:0px">
                        <i class="glyphicon glyphicon-record"></i>
                    </span>
                </li>
            </ul>
            <input type="hidden" id = 'id_txt_rastro' value = '[var.rastro;noerr]' disabled="disabled">
        </div>
	</body>
</html>