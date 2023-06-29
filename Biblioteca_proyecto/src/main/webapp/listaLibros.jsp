<%@page import="java.util.List"%>
<%@page import="entities.Libro"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Libros</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/fontawesome.min.css" integrity="sha384-QYIZto+st3yW+o8+5OHfT6S482Zsvz2WfOzpFSXMF9zqeLcFV0/wlZpMtyFcZALm" crossorigin="anonymous">	<%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

	<%@ include file="snippet/nav_bar.jsp"%>

	<div class="d-flex align-items-center justify-content-center">
		<h1 style="text-transform: uppercase"><strong>Libros</strong></h1>

		<%@include file="snippet/search.jsp" %>
	</div>
	<br>
    <div class="container">

        <table class="table table-striped" id="tabla">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Titulo</th>
                <th scope="col">Autor</th>
                <th scope="col">Editorial</th>
                <th scope="col">Stock</th>
                <th scope="col">Estado</th>
                <th scope="col">Acciones</th>
            </tr>
			<% for (Libro libro : (List<Libro>) request.getAttribute("libros")) { %>
            <tr id="fila">
                <th><%= libro.getIdLibro() %></th>
                <td><%= libro.getTitulo() %></td>
                <td><%= libro.getAutor() %></td>
                <td><%= libro.getEditorial() %></td>
                <td><%= libro.getStock() %></td>
                <td><%= libro.getEstado() %></td>
                <td>
                	<a class="btn btn-outline-success" href="LibroServlet?action=mostrar&id=<%= libro.getIdLibro()%>">Editar</a>
					<a class="btn btn-outline-danger" onclick="confirmarEliminacion('<%= libro.getIdLibro()%>')" href="#">Eliminar</a>
                </td>
            </tr>
            <%} %>
        </table>

        <div class="d-flex justify-content-center">
            <input class="btn btn-primary" type="button" value="Agregar" 
            	style="color: #fff; font-weight:600"
                onclick="window.location.href='registrarLibro.jsp'">
        </div>

    </div>
</body>

<%@include file="snippet/bootstrap_fin.jsp" %>
<script>
function confirmarEliminacion(id) {
    if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
        window.location.href = "LibroServlet?action=eliminar&id=" + id;
    }
}

function filtrarTabla() {
    var input, filter, table, tr, tdId, tdTitulo, tdAutor, tdEditorial, i;
    input = document.getElementById("busqueda");
    filter = input.value.toUpperCase();
    table = document.getElementById("tabla");
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        tdId = tr[i].getElementsByTagName("th")[0];
        tdTitulo = tr[i].getElementsByTagName("td")[0];
        tdAutor = tr[i].getElementsByTagName("td")[1];
        tdEditorial = tr[i].getElementsByTagName("td")[2];
        if (tdId || tdTitulo || tdAutor || tdEditorial) {
            var id = tdId.textContent || tdId.innerText;
            var titulo = tdTitulo.textContent || tdTitulo.innerText;
            var autor = tdAutor.textContent || tdAutor.innerText;
            var editorial = tdEditorial.textContent || tdEditorial.innerText;
            if (id.toUpperCase().indexOf(filter) > -1 ||
                titulo.toUpperCase().indexOf(filter) > -1 ||
                autor.toUpperCase().indexOf(filter) > -1 ||
                editorial.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

</script>
</html>