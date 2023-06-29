<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="util.MySQLConexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="entities.Prestamo"%>
<%@page import="entities.Libro"%>
<%@page import="entities.Alumno"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Préstamo</title>
    <%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

    <%@ include file="snippet/nav_bar.jsp"%>
    
    <div class="container">
        <br>
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Editar Préstamo</strong></h1><br>
        <form style="margin: 0 12%" method="get" action="PrestamoServlet?action=actualizar">
            <input type="hidden" name="action" value="actualizar">
            <input type="hidden" name="id" value="${ prestamo.idPrestamo }">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="id" class="form-label"><b>Id Préstamo:</b></label>
                    <input type="text" class="form-control" id="id" name="id" disabled value="${ prestamo.idPrestamo }" >         
                </div>
                <div class="col-md-6">
                    <label for="libro" class="form-label"><b>Libro:</b></label>
                    <select class="form-select" id="idLibro" name="idLibro">
                        <option value="${prestamo.idLibro }" > ${ prestamo.libro }</option>
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
                    <label for="fecPrestamo" class="form-label"><b>Fecha de Préstamo:</b></label>
                    <input type="date" class="form-control" id="fecPrestamo" name="fecPrestamo" value="${ prestamo.fecPrestamo }">
                </div>
                <div class="col-md-6">
                    <label for="fecDevolucion" class="form-label"><b>Fecha de Devolución:</b></label>
                    <input type="date" class="form-control" id="fecDevolucion" name="fecDevolucion" value="${ prestamo.fecDevolucion }">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="idAlumno" class="form-label"><b>Alumno:</b></label>
                    <select class="form-select" id="idAlumno" name="idAlumno">
                      <option value="${prestamo.idAlumno }" > ${ prestamo.alumno }</option>
                        <% try {
                            Connection connection = MySQLConexion.getConexion();
                            String sql = "SELECT * FROM Alumno";
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery(sql);
                            while (resultSet.next()) { %>
                                <option value="<%= resultSet.getString("idAlumno") %>"><%= resultSet.getString("nombre") %></option>
                            <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } %>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="estDevolucion" class="form-label"><b>Estado de Devolución:</b></label>
                    <select class="form-select" id="estDevolucion" name="estDevolucion">
                        <option value="${prestamo.estDevolucion }" > ${ prestamo.estDevolucion }</option>
                        <option value="Prestado">Prestado</option>
                        <option value="Devuelto">Devuelto</option>
                    </select>
                </div>            
            </div>
            <div class="row mb-3">
                <div class="col-md-12">
                    <input type="submit" name="enviar" id="enviar" value="Editar Préstamo" class="btn btn-primary" style="font-weight: 600" onclick="return confirmarEdicion()">
                    <a href="" class="btn btn-secondary">Cancelar</a>
                </div>
            </div>
        </form>
    </div>

    <%@include file="snippet/bootstrap_fin.jsp" %>
    <script>
    function confirmarEdicion() {
        return confirm("¿Estás seguro de que deseas guardar los cambios?");
    }
    </script>

</body>
</html>
