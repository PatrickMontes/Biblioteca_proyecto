<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Editorial</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.css"> 
</head>
<body>
    <%@ include file="snippet/nav_bar.jsp"%>

    <div class="container">
        <br>
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Registrar Editorial</strong></h1>
        <br>
        <form style="margin: 0 12%" method="get" action="EditorialServlet" onsubmit="return validarCampos();">
            <input type="hidden" name="action" value="agregar">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="id" class="form-label"><b>Id Editorial:</b></label>
                    <input type="text" class="form-control" id="id" name="id">
                </div>
                 <% String error = (String) request.getAttribute("error");
			        if (error != null && !error.isEmpty()) { %>
			            <div class="alert alert-danger" role="alert">
			                <%= error %>
			            </div>
        		<% } %>
                <div class="col-md-6">
                    <label for="nombre" class="form-label"><b>Nombre:</b></label> 
                    <input type="text" class="form-control" id="nombre" name="nombre">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="direccion" class="form-label"><b>Dirección:</b></label>
                    <input type="text" class="form-control" id="direccion" name="direccion">
                </div>
                <div class="col-md-6">
                    <label for="telefono" class="form-label"><b>Teléfono:</b></label> 
                    <input type="text" class="form-control" id="telefono" name="telefono">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="email" class="form-label"><b>Email:</b></label> 
                    <input type="email" class="form-control" id="email" name="email">
                </div>
                <div class="col-md-6">
                    <label for="ruc" class="form-label"><b>RUC:</b></label>
                    <input type="text" class="form-control" id="ruc" name="ruc">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <br>
                    <input type="submit" name="enviar" id="enviar"
                        value="Registrar" class="btn btn-primary"
                        style="font-weight: 600">
                     <a href="EditorialServlet?listaEditoriales&action=listar" class="btn btn-secondary" style="font-weight: 600">Regresar</a>                        
                </div>
            </div>
        </form>
    </div>
</body>
<%@include file="snippet/bootstrap_fin.jsp" %>
<script>
    function validarCampos() {
        var id = document.getElementById("id").value;
        var nombre = document.getElementById("nombre").value;
        var direccion = document.getElementById("direccion").value;
        var telefono = document.getElementById("telefono").value;
        var email = document.getElementById("email").value;
        var ruc = document.getElementById("ruc").value;

        var idPattern = /^EDI\d{2}$/; // Expresión regular para el formato EDI seguido de dos dígitos

        if (id === '' || nombre === '' || direccion === '' || telefono === '' || email === '' || ruc === '') {
        	 swal("Error", "Todos los campos son requeridos.", "error");
             return false; // Evita enviar el formulario
        }

        if (!idPattern.test(id)) {
        	 swal("Error", "El formato de la ID no es válido", "error");
             return false; // Evita enviar el formulario
        }

        return true;
    }
</script>
</html>
