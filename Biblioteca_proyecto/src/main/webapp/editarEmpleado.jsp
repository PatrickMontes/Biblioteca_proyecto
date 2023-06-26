<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Editar Empleado</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

	<%@include file="snippet/nav_bar.jsp"%>

	<div class="container">
		<br>
		<h1 class="text-center" style="text-transform: uppercase;"><strong>Editar Empleado</strong></h1>
		<br>
		<form method="get" action="EmpleadoServlet" style="margin: 0 12%">
			<input type="hidden" name="action" value="actualizar">
			<input type="hidden" name="id" value="${ empleado.idEmpleado }">
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="id" class="form-label"><b>Id Empleado:</b></label> <input
						type="text" class="form-control" id="id" name="id" disabled
						value="${ empleado.idEmpleado }">
				</div>
				<div class="col-md-6">
					<label for="nombre" class="form-label"><b>Nombre:</b></label> <input
						type="text" class="form-control" id="nombre" name="nombre"
						value="${ empleado.nombre }">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="apellido" class="form-label"><b>Apellido:</b></label> <input
						type="text" class="form-control" id="apellido" name="apellido"
						value="${ empleado.apellido }">
				</div>
				<div class="col-md-6">
					<label for="direccion" class="form-label"><b>Dirección:</b></label>
					<input type="text" class="form-control" id="direccion"
						name="direccion" value="${ empleado.direccion }">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="telefono" class="form-label"><b>Telefono:</b></label> <input
						type="number" class="form-control" id="telefono" name="telefono"
						value="${ empleado.telefono }">
				</div>
				<div class="col-md-6">
					<label for="email" class="form-label"><b>Email:</b></label> <input
						type="email" class="form-control" id="email" name="email"
						value="${ empleado.email }">
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="dni" class="form-label"><b>DNI:</b></label> <input
						type="text" class="form-control" id="dni" name="dni"
						value="${ empleado.dni }">
				</div>
				<div class="col-md-6">
					<label for="clave" class="form-label"><b>Contaseña:</b></label> <input
						type="password" class="form-control" id="clave" name="clave"
						value="${ empleado.pass }">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<br>
					<input type="submit" name="enviar" id="enviar" value="Editar Empleado" class="btn btn-primary" style="font-weight: 600" onclick="return confirmarEdicion()">
					<input type="reset" name="borrar" id="borrar" value="Restablecer" class="btn btn-secondary" style="font-weight: 600">
				</div>
			</div>
		</form>
	</div>

</body>
<%@include file="snippet/bootstrap_fin.jsp" %>
<script>
	function confirmarEdicion() {
		return confirm("¿Estás seguro de que deseas guaradr los cambios?");
	}
</script>
</html>