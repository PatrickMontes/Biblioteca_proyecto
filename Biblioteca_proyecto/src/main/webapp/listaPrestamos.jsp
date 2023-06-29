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

        <%@include file="snippet/search.jsp" %>
    </div>
    <br>
    <div class="container">
        <table class="table table-striped" id="tablaPrestamo">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Libro</th>
                <th scope="col">Fecha de préstamo</th>
                <th scope="col">Fecha de devolución</th>
                <th scope="col">Alumno</th>
                <th scope="col">Estado</th>
                <th scope="col">Acciones</th>
            </tr>
            <% for (Prestamo prestamo : (List<Prestamo>) request.getAttribute("prestamos")) { %>
            <tr class="filaPrestamo">
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
            <%}%>
        </table>

        <div class="d-flex justify-content-center">
            <input class="btn btn-primary" type="button" value="Agregar" 
                style="color: #fff; font-weight:600"
                onclick="window.location.href='registrarPrestamo.jsp'">
        </div>
    </div>
</body>
</html>

<script>
    function filtrarTabla() {
        var input, filter, table, th, tr, thId, tdLibro, tdFecha, tdAlumno, i;
        input = document.getElementById("busqueda");
        filter = input.value.toUpperCase();
        table = document.getElementById("tablaPrestamo");
        tr = table.getElementsByClassName("filaPrestamo");

        for (i = 0; i < tr.length; i++) {
            tdId = tr[i].querySelectorAll("th")[0];
            tdLibro = tr[i].querySelectorAll("td")[0];
            tdFecha = tr[i].querySelectorAll("td")[1];
            tdAlumno = tr[i].querySelectorAll("td")[3];
            if (tdId || tdLibro || tdPrestamo || tdAlumno) {
                if (tdId.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                    tdLibro.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                    tdFecha.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                    tdAlumno.innerHTML.toUpperCase().indexOf(filter) > -1) {
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
