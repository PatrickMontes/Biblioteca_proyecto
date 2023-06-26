<%@page import="java.util.List"%>
<%@page import="entities.Alumno"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Alumnos</title>
	<%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

	<%@include file="snippet/nav_bar.jsp"%>

	<div class="d-flex align-items-center justify-content-center">
		<h1 style="text-transform: uppercase"><strong>Alumnos</strong></h1>

     <%@include file="snippet/search.jsp" %>
	</div>
	<br>
	<div class="container">

		<table class="table table-striped" id="tablaAlumnos">
			<tr>
				<th scope="col">Id</th>
				<th scope="col">Nombre</th>
				<th scope="col">Apellido</th>
				<th scope="col">Direccion</th>
				<th scope="col">Telefono</th>
				<th scope="col">Email</th>
				<th scope="col">Acciones</th>
			</tr>
			<% for (Alumno alumno : (List<Alumno>) request.getAttribute("alumnos")) { %>
			<tr class="filaAlumno">
				<th><%= alumno.getIdAlumno()%></th>
				<td><%= alumno.getNombre()%></td>
				<td><%= alumno.getApellido()%></td>
				<td><%= alumno.getDireccion()%></td>
				<td><%= alumno.getTelefono()%></td>
				<td><%= alumno.getEmail()%></td>
				<td>
					<a class="btn btn-outline-success" href="AlumnoServlet?action=mostrar&id=<%= alumno.getIdAlumno()%>">Editar</a>
					<a class="btn btn-outline-danger" onclick="confirmarEliminacion('<%= alumno.getIdAlumno()%>')" href="#">Eliminar</a>
				</td>
			</tr>
			<% } %>
		</table>

		<div class="d-flex justify-content-center">
			<input class="btn btn-primary" type="button" value="Crear Alumno"
				style="color: #fff; font-weight: 600"
				onclick="window.location.href='registrarAlumno.jsp'">
		</div>
		
	</div>

</body>

<%@include file="snippet/bootstrap_fin.jsp" %>
<script>
function confirmarEliminacion(id) {
    if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
        window.location.href = "AlumnoServlet?action=eliminar&id=" + id;
    }
}

function filtrarTabla() {
    var input, filter, table, th, tr, thId, tdNombre, tdApellido, i;
    input = document.getElementById("busqueda");
    filter = input.value.toUpperCase();
    table = document.getElementById("tablaAlumnos");
    tr = table.getElementsByClassName("filaAlumno");

    for (i = 0; i < tr.length; i++) {
        tdId = tr[i].getElementsByTagName("th")[0];
        tdNombre = tr[i].getElementsByTagName("td")[0];
        tdApellido = tr[i].getElementsByTagName("td")[1];
        if (tdId || tdNombre || tdApellido) {
            if (tdId.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                tdNombre.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                tdApellido.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}
</script>
</body>
</html>