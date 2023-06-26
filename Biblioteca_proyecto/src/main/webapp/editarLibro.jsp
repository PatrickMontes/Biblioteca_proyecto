<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="util.MySQLConexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="entities.Libro"%>
<%@page import="entities.Editorial"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrar Editorial</title>
	<%@include file="snippet/bootstrap_ini.jsp" %>
</head>
<body>

	<%@ include file="snippet/nav_bar.jsp"%>
	
    <div class="container">
        <br>
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Editar Libro</strong></h1><br>
		<form method="get" action="LibroServlet" style="margin: 0 12%">
			<input type="hidden" name="action" value="actualizar">
			<input type="hidden" name="id" value="${ libro.idLibro }">
			<div class="row mb-3">
				<div class="col-md-6">
					<label for="id" class="form-label"><b>Id Libro:</b></label> <input
						type="text" class="form-control" id="id" name="id" disabled
						value="${ libro.idLibro }">
				</div>
				<div class="col-md-6">
					<label for="titulo" class="form-label"><b>Titulo:</b></label> 
					<input type="text" class="form-control" id="titulo" name="titulo" value="${ libro.titulo }">
				</div>
			</div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="autor" class="form-label"><b>Autor:</b></label>
                    <input type="text" class="form-control" id="autor" name="autor" value="${ libro.autor }">
                </div>
                <div class="col-md-6">
                    <label for="idEditorial" class="form-label"><b>Editorial:</b></label>
				    <select class="form-select" id="idEditorial" name="idEditorial">
				        <option value="${libro.idEditorial }" > ${ libro.editorial }</option>
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
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="stock" class="form-label"><b>Stock:</b></label>
                    <input type="number" class="form-control" id="stock" name="stock" value="${ libro.stock }">
                </div>
                <div class="col-md-6">
                    <label for="estado" class="form-label"><b>Estado:</b></label>
                    <select class="form-select" id="estado" name="estado">
                    <option value="${ libro.estado }" selected > ${ libro.estado }</option>
                        <option value="Disponible" id="Disponible" name="Disponible" >Disponible</option>
                        <option value="Agotado" id="Agotado" name="Agotado">Agotado</option>
                    </select>
                </div>
            </div>
			<div class="row">
				<div class="col-md-12 text-center">
					<br>
					<input type="submit" name="enviar" id="enviar" value="Editar Libro" class="btn btn-primary" style="font-weight: 600" onclick="return confirmarEdicion()">
					<input type="reset" name="borrar" id="borrar" value="Restablecer" class="btn btn-secondary" style="font-weight: 600">
				</div>
			</div>
        </form>
    </div>

</body>
<%@include file="snippet/bootstrap_fin.jsp" %>
<script>
	function confirmarEdicion() {
		return confirm("¿Estás seguro de que deseas guaradr los cambios?");
	}
</script>
</html>