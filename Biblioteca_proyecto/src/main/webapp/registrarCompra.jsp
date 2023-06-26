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
        <form style="margin: 0 12%" method="post" action="CompraLibroServlet">
            <input type="hidden" name="action" value="agregar">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="idCompra" class="form-label"><b>Id Compra:</b></label>
                    <input type="text" class="form-control" id="idCompra" name="idCompra">
                </div>
                <div class="col-md-6">
                    <label for="libro" class="form-label"><b>Libro:</b></label>
                    <select class="form-select" id="libro" name="libro">
                        <% 
                        Connection connection = null;
                        Statement statement = null;
                        ResultSet resultSet = null;
                        try {
                            connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Libro";
                            statement = connection.createStatement();
                            resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { 
                                String idLibro = resultSet.getString("idLibro");
                                String titulo = resultSet.getString("titulo");
                        %>
                        <option value="<%= idLibro %>"><%= titulo %></option>
                        <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (resultSet != null) {
                                try {
                                    resultSet.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            if (statement != null) {
                                try {
                                    statement.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            if (connection != null) {
                                try {
                                    connection.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                        %>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="editorial" class="form-label"><b>Editorial:</b></label>
                    <select class="form-select" id="editorial" name="editorial">
                        <% 
                        try {
                            connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Editorial";
                            statement = connection.createStatement();
                            resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { 
                                String idEditorial = resultSet.getString("idEditorial");
                                String nombre = resultSet.getString("nombre");
                        %>
                        <option value="<%= idEditorial %>"><%= nombre %></option>
                        <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (resultSet != null) {
                                try {
                                    resultSet.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            if (statement != null) {
                                try {
                                    statement.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            if (connection != null) {
                                try {
                                    connection.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                        %>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="empleado" class="form-label"><b>Empleado:</b></label>
                    <select class="form-select" id="empleado" name="empleado">
                        <% 
                        try {
                            connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Empleado";
                            statement = connection.createStatement();
                            resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { 
                                String idEmpleado = resultSet.getString("idEmpleado");
                                String nombre = resultSet.getString("nombre");
                        %>
                        <option value="<%= idEmpleado %>"><%= nombre %></option>
                        <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (resultSet != null) {
                                try {
                                    resultSet.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            if (statement != null) {
                                try {
                                    statement.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                            if (connection != null) {
                                try {
                                    connection.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                        %>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="fecha" class="form-label"><b>Fecha:</b></label>
                    <input type="date" class="form-control" id="fecha" name="fecha">
                </div>
                <div class="col-md-6">
                    <label for="cantidad" class="form-label"><b>Cantidad:</b></label>
                    <input type="number" class="form-control" id="cantidad" name="cantidad">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="precio" class="form-label"><b>Precio:</b></label>
                    <input type="number" step="0.01" class="form-control" id="precio" name="precio">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-12">
                    <input type="submit" class="btn btn-primary" value="Guardar">
                    <a href="" class="btn btn-secondary">Cancelar</a>
                </div>
            </div>
        </form>
    </div>

    <%@include file="snippet/bootstrap_fin.jsp" %>

</body>
</html>
