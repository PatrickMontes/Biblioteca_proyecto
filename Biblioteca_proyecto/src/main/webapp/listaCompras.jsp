<%@page import="java.util.List"%>
<%@page import="entities.CompraLibro"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compras</title>
	<%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>
	<!--%
        HttpSession sesion=request.getSession();
        if( sesion.getAttribute("logueado")==null ||  sesion.getAttribute("logueado").equals("0") ){
            response.sendRedirect("login.jsp");
        }
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
    %-->
	<%@include file="snippet/nav_bar.jsp"%>

	<div class="d-flex align-items-center justify-content-center">
		<h1 style="text-transform: uppercase"><strong>Compras</strong></h1>

		<%@include file="snippet/search.jsp" %>
	</div>
	<br>
	<div class="container">
		<table class="table table-striped" id="tabla">
			<tr>
				<th scope="col">Id</th>
				<th scope="col">Libro</th>
				<th scope="col">Editorial</th>
				<th scope="col">Empleado</th>
				<th scope="col">Fecha de compra</th>
				<th scope="col">Precio</th>
				<th scope="col">Cantidad</th>
				<th scope="col">Acciones</th>
			</tr>
			<% for (CompraLibro compra : (List<CompraLibro>) request.getAttribute("compras")) { %>
			<tr id="fila">
				<th><%= compra.getIdCompra() %></th>
				<td><%= compra.getLibro() %></td>
				<td><%= compra.getEditorial() %></td>
				<td><%= compra.getEmpleado() %></td>
				<td><%= compra.getFecCompra() %></td>
				<td><%= compra.getPrecio() %></td>
				<td><%= compra.getCantidad() %></td>
				<td>
					<a class="btn btn-outline-success" href="CompraLibroServlet?action=mostrar&id=<%= compra.getIdCompra()%>">Editar</a>
					<a class="btn btn-outline-danger" onclick="confirmarEliminacion('<%= compra.getIdCompra()%>')" href="#">Eliminar</a>
				</td>
			</tr>
			<%} %>
		</table>

		<div class="d-flex justify-content-center">
			<input class="btn btn-primary" type="button" value="Agregar Compra" 
				style="color: #fff; font-weight:600"
				onclick="window.location.href='registrarCompra.jsp'">
		</div>
	</div>
</body>
</html>

<script>
    function filtrarTabla() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("busqueda");
        filter = input.value.toUpperCase();
        table = document.getElementById("tabla");
        tr = table.getElementsByTagName("tr");

        for (i = 1; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1]; // Filtrar por la segunda columna (Libro)
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    function confirmarEliminacion(idCompra) {
        if (confirm("¿Estás seguro de eliminar esta compra?")) {
            window.location.href = "CompraLibroServlet?action=eliminar&id=" + idCompra;
        }
    }
</script>
