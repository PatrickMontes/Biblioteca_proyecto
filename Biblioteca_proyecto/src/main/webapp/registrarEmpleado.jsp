<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Registrar Empleado</title>
	<%@include file="snippet/bootstrap_ini.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.css"> 
</head>
<body>

	<%@ include file="snippet/nav_bar.jsp"%>

	<div class="container">
		<br>
		<h1 class="text-center" style="text-transform: uppercase;"><strong>Registrar Empleado</strong></h1>
		<br>
		<form style="margin: 0 12%" method="get" action="EmpleadoServlet" onsubmit="return validarCampos();">
			<input type="hidden" name="action" value="agregar">
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="id" class="form-label"><b>Id Empleado:</b></label>
					<input type="text" class="form-control" id="id" name="id">
				</div>
				<div class="col-md-6">
					<label for="nombre" class="form-label"><b>Nombre:</b></label> 
					<input type="text" class="form-control" id="nombre" name="nombre">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="apellido" class="form-label"><b>Apellido:</b></label> 
					<input type="text" class="form-control" id="apellido" name="apellido">
				</div>
				<div class="col-md-6">
					<label for="direccion" class="form-label"><b>Direccion:</b></label>
					<input type="text" class="form-control" id="direccion" name="direccion">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="telefono" class="form-label"><b>Telefono:</b></label> 
					<input type="text" class="form-control" id="telefono" name="telefono">
				</div>
				<div class="col-md-6">
					<label for="email" class="form-label"><b>Email:</b></label> 
					<input type="email" class="form-control" id="email" name="email">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="dni" class="form-label"><b>DNI:</b></label> 
					<input type="number" class="form-control" id="dni" name="dni">
				</div>
				<div class="col-md-6">
					<label for="clave" class="form-label"><b>Contrasena:</b></label> 
					<input type="password" class="form-control" id="clave" name="clave">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<br>
					<input type="submit" name="enviar" id="enviar"
						value="Registrar" class="btn btn-primary"
						style="font-weight: 600">
					<a href="EmpleadoServlet?ListaEmpleados&action=listar" class="btn btn-secondary" style="font-weight: 600">Regresar</a>
				</div>
			</div>
		</form>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert@2.1.2/dist/sweetalert.min.js"></script>
<%@include file="snippet/bootstrap_fin.jsp" %>
<script>
function validarCampos() {
    var id = document.getElementById("id").value;
    var nombre = document.getElementById("nombre").value;
    var apellido = document.getElementById("apellido").value;
    var direccion = document.getElementById("direccion").value;
    var telefono = document.getElementById("telefono").value;
    var email = document.getElementById("email").value;
    var dni = document.getElementById("dni").value;
    var clave = document.getElementById("clave").value;

    var idPattern = /^EMP\d{2}$/;

    // Validación para campos vacíos
    if (id === '' || nombre === '' || apellido === '' || direccion === '' || telefono === '' || email === '' || dni === '' || clave === '') {
        Swal.fire("Error", "Todos los campos son requeridos.", "error");
        return false;
    }

    // Validación para el formato de la ID
    if (!idPattern.test(id)) {
        Swal.fire("Error", "El formato de la ID no es válido.", "error");
        return false;
    }

    return true;
}

</script>
</html>