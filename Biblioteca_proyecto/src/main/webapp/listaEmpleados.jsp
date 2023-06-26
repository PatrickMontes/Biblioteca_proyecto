<%@page import="java.util.List"%>
<%@page import="entities.Empleado"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Empleados</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">  
</head>
<body>
    <!-- Inicio del menu -->
	<%@include file="snippet/nav_bar.jsp" %>

	<div class="d-flex align-items-center justify-content-center">
    	<h1 class="d-flex justify-content-center" style="text-transform: uppercase;"><strong>Empleados</strong></h1>
		<%@include file="snippet/search.jsp" %>
	</div>
    <br>
    <div class="container">
    
        <table class="table table-striped"  id="tabla">
            <tr>
                <th scope="col">Codigo</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido</th>
                <th scope="col">Direccion</th>
                <th scope="col">Telefono</th>
                <th scope="col">Email</th>
                <th scope="col">Acciones</th>
            </tr>
			<% for (Empleado empleado : (List<Empleado>) request.getAttribute("empleados")) { %>
            <tr>
                <th><%= empleado.getIdEmpleado() %></th>
                <td><%= empleado.getNombre() %></td>
                <td><%= empleado.getApellido() %></td>
                <td><%= empleado.getDireccion() %></td>
                <td><%= empleado.getTelefono() %></td>
                <td><%= empleado.getEmail() %></td>
                <td><a class="btn btn-outline-success" href="EmpleadoServlet?action=mostrar&id=<%= empleado.getIdEmpleado()%>">Editar</a>
                    <a class="btn btn-outline-danger" href="#" onclick="confirmarEliminacion('<%= empleado.getIdEmpleado() %>')">Eliminar</a>
                </td>
            </tr>
            <%
			}
            %>
        </table>

        <div class="d-flex justify-content-center">
            <input class="btn btn-primary" type="button" value="Crear Empleado" style="color: #fff; font-weight:600"
                onclick="window.location.href='registrarEmpleado.jsp'">
        </div>

    </div>
    
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
        
<script>
	function confirmarEliminacion(id) {
		if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
			window.location.href = "EmpleadoServlet?action=eliminar&id=" + id;
		}
	}
</script>

</html>