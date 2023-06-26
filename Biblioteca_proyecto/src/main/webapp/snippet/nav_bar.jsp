<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Nav Bar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
</head>
<body class="bg-light">
    <!-- % HttpSession sesion = request.getSession();
            if (sesion.getAttribute("logueado") == null || sesion.getAttribute("logueado").equals("0")) {
                response.sendRedirect("login.jsp");
            }
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
     %-->     
	<!-- Inicio del menu -->
	<nav class="navbar navbar-expand-md navbar-dark bg-dark">
		<div class="container-fluid">

			<!-- icono o nombre -->
			<a class="navbar-brand" href="#"
				style="padding-left: 3rem; padding-right: 3rem;"> <i
				class="bi bi-book" style="font-size: 2rem; color: #bbb"></i> <span
				style="font-size: 2rem; color: #bbb"><b>CiberBiblioteca</b></span>
			</a>

			<!-- boton del menu -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#menu"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- elementos del menu colapsable -->
			<div class="collapse navbar-collapse" id="menu">
				<ul class="navbar-nav me-auto" style="font-size: 20px">
					<li class="nav-item" style="margin: 0 0.5rem"><a class="nav-link" href="LibroServlet?listaLibros&action=listar">Libros</a></li>
					<li class="nav-item" style="margin: 0 0.5rem"><a class="nav-link" href="EmpleadoServlet?ListaEmpleados&action=listar">Empleados</a></li>
					<li class="nav-item" style="margin: 0 0.5rem"><a class="nav-link" href="listaPrestamos.jsp">Préstamos</a></li>
					<li class="nav-item" style="margin: 0 0.5rem"><a class="nav-link" href="AlumnoServlet?listaAlumnos&action=listar">Alumnos</a></li>
					<li class="nav-item" style="margin: 0 0.5rem"><a class="nav-link" href="EditorialServlet?listaEditoriales&action=listar">Editorial</a></li>
					<li class="nav-item" style="margin: 0 0.5rem"><a class="nav-link" href="CompraLibroServlet?listaCompras&action=listar">Compras</a></li>
				</ul>

				<hr class="d-md-none text-white-50">

				<!--boton Informacion -->
				<form class="d-flex" action="logout.jsp">
					<!--<a href="datosUsuario.jsp"><i class="fa fa-user-circle" aria-hidden="true"></i> %= sesion.getAttribute("user")%</a> -->
					<button class="btn btn-danger d-none d-md-inline-block "
						type="submit" style="font-size: 20px; font-weight: 600">					
						<a style="text-decoration: none; color: #fff">Cerrar Sesion</a>
					</button>
				</form>
			</div>
		</div>
	</nav>
	<br>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</html>