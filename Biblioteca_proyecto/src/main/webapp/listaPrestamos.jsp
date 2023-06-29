<%@page import="java.util.List"%>
<%@page import="entities.Prestamo"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prestamos</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

    <%@include file="snippet/nav_bar.jsp"%>

    <div class="d-flex align-items-center justify-content-center">
        <h1 style="text-transform: uppercase"><strong>Prestamos</strong></h1>

        <nav class="navbar">
            <div class="container-fluid">
                <form class="d-flex" role="search" style="margin-left: 9rem">
                    <input class="form-control me-4" type="search" placeholder="Ingrese su búsqueda" aria-label="Search" id="busqueda" oninput="filtrarTabla()">
                    <button class="btn btn-warning" type="button" style="color: #fff; font-weight: 600">Buscar</button>
                </form>
            </div>
        </nav>
    </div>
    <br>
    <div class="container">
        <table class="table table-striped" id="tabla">
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Libro</th>
                <th scope="col">Fecha de préstamo</th>
                <th scope="col">Fecha de devolución</th>
                <th scope="col">Alumno</th>
                <th scope="col">Estado de devolución</th>
                <th scope="col">Acciones</th>
            </tr>
            <% for (Prestamo prestamo : (List<Prestamo>) request.getAttribute("prestamos")) { %>
            <tr id="fila">
                <th><%= prestamo.getIdPrestamo() %></th>
                <td><%= prestamo.getLibro() %></td>
                <td><%= prestamo.getFecPrestamo() %></td>
                <td><%= prestamo.getFecDevolucion() %></td>
                <td><%= prestamo.getAlumno() %></td>
                <td><%= prestamo.getEstDevolucion() %></td>
                <td>
                    <a class="btn btn-outline-success" href="PrestamoServlet?action=mostrar&id=<%= prestamo.getIdPrestamo()%>">Editar</a>
                    <a class="btn btn-outline-danger" onclick="confirmarEliminacion('<%= prestamo.getIdPrestamo()%>')" href="#">Eliminar</a>
                </td>
            </tr>
            <%} %>
        </table>

        <div class="d-flex justify-content-center">
            <input class="btn btn-primary" type="button" value="Agregar Prestamo" 
                style="color: #fff; font-weight:600"
                onclick="window.location.href='registrarPrestamo.jsp'">
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

    function confirmarEliminacion(idPrestamo) {
        if (confirm("¿Estás seguro de eliminar este préstamo?")) {
            window.location.href = "PrestamoServlet?action=eliminar&id=" + idPrestamo;
        }
    }
</script>
