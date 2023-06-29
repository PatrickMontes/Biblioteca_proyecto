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
    
        <table class="table table-striped"  id="tablaEmpleados">
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
            <tr class="filaEmpleado">
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
            <input class="btn btn-primary" type="button" value="Agregar" style="color: #fff; font-weight:600"
                onclick="window.location.href='registrarEmpleado.jsp'">
        </div>

    </div>
    
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
        
<script>
	function confirmarEliminacion(id) {
	    swal({
	        title: "Seguro?",
	        text: "Una vez eliminado, no podras recuperar este registro",
	        icon: "warning",
	        buttons: true,
	        dangerMode: true,
	    }).then((result) => {
	        if (result) {
				window.location.href = "EmpleadoServlet?action=eliminar&id=" + id;
	        } else {
	            swal("El registro no ha sido eliminado");
	        }
	    });
	}
	
	function filtrarTabla() {
        var input, filter, table, th, tr, thId, tdNombre, tdApellido, i;
        input = document.getElementById("busqueda");
        filter = input.value.toUpperCase();
        table = document.getElementById("tablaEmpleados");
        tr = table.getElementsByClassName("filaEmpleado");

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
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</html>