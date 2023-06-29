<%@page import="java.util.List"%>
<%@page import="entities.Editorial"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editoriales</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>
    <%@include file="snippet/nav_bar.jsp"%>

    <div class="d-flex align-items-center justify-content-center">
        <h1 style="text-transform: uppercase"><strong>Editoriales</strong></h1>
        <%@include file="snippet/search.jsp" %>
    </div>
    <br>
    <div class="container">
        <table class="table table-striped" id="tablaEditoriales">
            <tr>
                <th scope="col">Código</th>
                <th scope="col">Nombre</th>
                <th scope="col">Dirección</th>
                <th scope="col">Teléfono</th>
                <th scope="col">Email</th>
                <th scope="col">RUC</th>
                <th scope="col">Acciones</th>
            </tr>
            <% for (Editorial editorial : (List<Editorial>) request.getAttribute("editoriales")) { %>
            <tr class="filaEditorial">
                <th><%= editorial.getIdEditorial() %></th>
                <td><%= editorial.getNombre() %></td>
                <td><%= editorial.getDireccion() %></td>
                <td><%= editorial.getTelefono() %></td>
                <td><%= editorial.getEmail() %></td>
                <td><%= editorial.getRuc() %></td>
                <td>
                    <a class="btn btn-outline-success" href="EditorialServlet?action=mostrar&id=<%= editorial.getIdEditorial() %>">Editar</a>
                    <a class="btn btn-outline-danger" onclick="confirmarEliminacion('<%= editorial.getIdEditorial() %>')" href="#">Eliminar</a>
                </td>
            </tr>
            <% } %>
        </table>

        <div class="d-flex justify-content-center">
            <input class="btn btn-primary" type="button" value="Agregar"
                style="color: #fff; font-weight: 600"
                onclick="window.location.href='registrarEditorial.jsp'">
        </div>
    </div>

    <%@include file="snippet/bootstrap_fin.jsp" %>
    <script>
    function confirmarEliminacion(id) {
        if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
            window.location.href = "EditorialServlet?action=eliminar&id=" + id;
        }
    }

    function filtrarTabla() {
        var input, filter, table, tr, thId, tdNombre, tdDireccion, i;
        input = document.getElementById("busqueda");
        filter = input.value.toUpperCase();
        table = document.getElementById("tablaEditoriales");
        tr = table.getElementsByClassName("filaEditorial");

        for (i = 0; i < tr.length; i++) {
            thId = tr[i].getElementsByTagName("th")[0];
            tdNombre = tr[i].getElementsByTagName("td")[0];
            tdDireccion = tr[i].getElementsByTagName("td")[1];
            if (thId || tdNombre || tdDireccion) {
                if (thId.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                    tdNombre.innerHTML.toUpperCase().indexOf(filter) > -1 ||
                    tdDireccion.innerHTML.toUpperCase().indexOf(filter) > -1) {
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
