<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="util.MySQLConexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="entities.CompraLibro"%>
<%@page import="entities.Libro"%>
<%@page import="entities.Editorial"%>
<%@page import="entities.Empleado"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Compra</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

    <%@ include file="snippet/nav_bar.jsp"%>
    
    <div class="container">
        <br>
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Registrar Compra</strong></h1><br>
        <form style="margin: 0 12%" method="post" action="CompraLibroServlet?action=agregar" onsubmit="return validarCampos();">
            <input type="hidden" name="action" value="agregar">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="id" class="form-label"><b>Id Compra:</b></label>
                    <input type="text" class="form-control" id="id" name="id">
                </div>
                <div class="col-md-6">
                    <label for="idLibro" class="form-label"><b>Libro:</b></label>
                    <select class="form-select" id="idLibro" name="idLibro">
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Libro";
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { %>
                                <option value="<%= resultSet.getString("idLibro") %>"><%= resultSet.getString("titulo") %></option>
                            <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="idEditorial" class="form-label"><b>Editorial:</b></label>
                    <select class="form-select" id="idEditorial" name="idEditorial">
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Editorial";
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { %>
                                <option value="<%= resultSet.getString("idEditorial") %>"><%= resultSet.getString("nombre") %></option>
                            <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="idEmpleado" class="form-label"><b>Empleado:</b></label>
                    <select class="form-select" id="idEmpleado" name="idEmpleado">
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Empleado";
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { %>
                                <option value="<%= resultSet.getString("idEmpleado") %>"><%= resultSet.getString("nombre") %></option>
                            <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="fecCompra" class="form-label"><b>Fecha:</b></label>
                    <input type="date" class="form-control" id="fecCompra" name="fecCompra">
                </div>
                <div class="col-md-6">
                    <label for="precio" class="form-label"><b>Precio:</b></label>
                    <input type="number" step="0.01" class="form-control" id="precio" name="precio">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="cantidad" class="form-label"><b>Cantidad:</b></label>
                    <input type="number" class="form-control" id="cantidad" name="cantidad">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <br>
                    <input type="submit" name="enviar" id="enviar"
                        value="Registrar" class="btn btn-primary"
                        style="font-weight: 600"> 
                    <a href="CompraLibroServlet?listaCompras&action=listar" class="btn btn-secondary" style="font-weight: 600">Regresar</a>
                </div>
            </div>
        </form>
    </div>

    <%@include file="snippet/bootstrap_fin.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert@2.1.2/dist/sweetalert.min.js"></script>
    <script>
        function validarCampos() {
            var id = document.getElementById("id").value;
            var idLibro = document.getElementById("idLibro").value;
            var idEditorial = document.getElementById("idEditorial").value;
            var idEmpleado = document.getElementById("idEmpleado").value;
            var fecCompra = document.getElementById("fecCompra").value;
            var precio = document.getElementById("precio").value;
            var cantidad = document.getElementById("cantidad").value;

            var idPattern = /^COM\d{2}$/;

            if (id === '' || idLibro === '' || idEditorial === '' || idEmpleado === '' || fecCompra === '' || precio === '' || cantidad === '') {
                swal("Error", "Todos los campos son requeridos.", "error");
                return false; // Evita enviar el formulario
            }

            if (!idPattern.test(id)) {
                swal("Error", "El formato de la ID no es válido.", "error");
                return false; // Evita enviar el formulario
            }

            return true; // Envía el formulario si todos los campos están llenos
        }
    </script>

</body>
</html>
