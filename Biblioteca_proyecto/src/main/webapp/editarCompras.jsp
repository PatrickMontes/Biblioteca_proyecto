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
    <title>Editar Compra</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.css">
</head>
<body>

    <%@ include file="snippet/nav_bar.jsp"%>
    
    <div class="container">
        <br>
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Editar Compra</strong></h1><br>
        <form style="margin: 0 12%" method="get" action="CompraLibroServlet?action=actualizar">
            <input type="hidden" name="action" value="actualizar">
            <input type="hidden" name="id" value="${compra.idCompra}">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="id" class="form-label"><b>Id Compra:</b></label>
                    <input type="text" class="form-control" id="id" name="id" disabled value="${compra.idCompra}">
                </div>
                <div class="col-md-6">
                    <label for="libro" class="form-label"><b>Libro:</b></label>
                    <select class="form-select" id="idLibro" name="idLibro">
                        <option value="${compra.idLibro}" > ${compra.libro }</option>
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
                      <option value="${compra.idEditorial}" > ${compra.editorial }</option>
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
                       <option value="${compra.idEmpleado}" > ${compra.empleado }</option>
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
                    <input type="date" class="form-control" id="fecCompra" name="fecCompra" value="${compra.fecCompra}">
                </div>
                <div class="col-md-6">
                    <label for="precio" class="form-label"><b>Precio:</b></label>
                    <input type="number" step="0.01" class="form-control" id="precio" name="precio" value="${compra.precio}">
                </div>             
            </div>
            <div class="row mb-3">
                  <div class="col-md-6">
                    <label for="cantidad" class="form-label"><b>Cantidad:</b></label>
                    <input type="number" class="form-control" id="cantidad" name="cantidad" value="${compra.cantidad}">
                </div>
            </div>
            <div class="row">
				<div class="col-md-12 text-center">
					<br>
					<input type="submit" name="enviar" id="enviar" value="Editar" class="btn btn-primary" style="font-weight: 600" onclick="confirmarEdicion(event)">
					<a href="CompraLibroServlet?listaCompras&action=listar" class="btn btn-secondary" style="font-weight: 600">Regresar</a>
				</div>
			</div>
        </form>
    </div>

    <%@include file="snippet/bootstrap_fin.jsp" %>
    <script>
        function confirmarEdicion(event) {
            event.preventDefault(); // Evitar que el formulario se envíe automáticamente
            
            Swal.fire({
                title: '¿Estás seguro de que deseas guardar los cambios?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Sí',
                cancelButtonText: 'No'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si se confirma, enviar el formulario
                    document.getElementById('enviar').disabled = true; // Deshabilitar el botón para evitar múltiples envíos
                    document.getElementById('enviar').form.submit();
                }
            });
        }
    </script>

</body>
</html>
