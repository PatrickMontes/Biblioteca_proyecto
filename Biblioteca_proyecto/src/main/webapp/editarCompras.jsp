<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="util.MySQLConexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="entities.CompraLibro"%>
<%@page import="entities.Editorial"%>
<%@page import="entities.Libro"%>
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
</head>
<body>

	<%@ include file="snippet/nav_bar.jsp"%>
	
    <div class="container">
        <br>
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Editar Compra</strong></h1><br>
		<form method="get" action="CompraLibroServlet" style="margin: 0 12%">
			<input type="hidden" name="action" value="actualizar">
			<input type="hidden" name="idCompra" value="${compra.}">
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="idCompra" class="form-label"><b>Id Compra:</b></label>
					<input type="text" class="form-control" id="idCompra" name="idCompra" disabled
						   value="${compra.idCompra}">
				</div>
				<div class="col-md-6">
					<label for="libro" class="form-label"><b>Libro:</b></label>
					<select class="form-select" id="libro" name="libro">
                        <option value="${compra.libroId}">${compra.libro}</option>
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM libro";
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
                    <label for="editorial" class="form-label"><b>Editorial:</b></label>
                    <select class="form-select" id="editorial" name="editorial">
                        <option value="${compra.editorialId}">${compra.editorial}</option>
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM editorial";
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
                    <label for="empleado" class="form-label"><b>Empleado:</b></label>
                    <select class="form-select" id="empleado" name="empleado">
                        <option value="${compra.empleadoId}">${compra.empleado}</option>
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM empleado";
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
                    <label for="fechaCompra" class="form-label"><b>Fecha Compra:</b></label>
                    <input type="date" class="form-control" id="fechaCompra" name="fechaCompra"
                           value="${compra.fechaCompra}">
                </div>
                <div class="col-md-6">
                    <label for="cantidad" class="form-label"><b>Cantidad:</b></label>
                    <input type="text" class="form-control" id="cantidad" name="cantidad"
                           value="${compra.cantidad}">
                </div>
            </div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">Actualizar Compra</button>
			</div>
		</form>
	</div>
	
	<%@include file="snippet/bootstrap_fin.jsp" %>
	
</body>
</html>
