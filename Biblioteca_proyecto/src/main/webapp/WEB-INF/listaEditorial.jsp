<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Editorial</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
</head>
<body class="bg-light">

    <!-- Inicio del menu -->
      <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="container-fluid">

        <!-- icono o nombre -->
        <a class="navbar-brand" href="#" style="padding-left: 3rem; padding-right: 3rem;">
            <i class="bi bi-book" style="font-size: 2rem; color:#bbb"></i>
            <span style="font-size: 2rem; color:#bbb"><b>CiberBiblioteca</b></span>
          </a>  
            
        <!-- boton del menu -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

          <!-- elementos del menu colapsable -->
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav me-auto" style="font-size: 20px">
                  <li class="nav-item" style="margin:0 0.5rem">
                    <a class="nav-link" href="ControladorLibros?listaLibros&instruccion=listar">Libros</a>
                  </li>
                  <li class="nav-item" style="margin:0 0.5rem">
                    <a class="nav-link" href="listaEmpleados.jsp">Empleados</a>
                  </li>
                  <li class="nav-item" style="margin:0 0.5rem">
                    <a class="nav-link" href="listaPrestamos.jsp">Prestamos</a>
                  </li>
                  <li class="nav-item" style="margin:0 0.5rem">
                    <a class="nav-link" href="ControladorAlumnos?listaAlumnos&instruccion=listar">Alumnos</a>
                  </li>
                   <li class="nav-item" style="margin:0 0.5rem">
                    <a class="nav-link" href="listaEditorial.jsp">Editorial</a>
                  </li>
                  <li class="nav-item" style="margin:0 0.5rem">
                    <a class="nav-link" href="listaCompras.jsp">Compras</a>
                  </li>
                 </ul>

          <hr class="d-md-none text-white-50">

         <!--boton Informacion -->
          <form class="d-flex">
            <button class="btn btn-danger d-none d-md-inline-block " type="submit" style="font-size: 20px; font-weight:600"><a href="login.jsp" style="text-decoration: none; color: #fff">Cerrar Sesion</a></button>
          </form>
        </div>
        </div>  
      </nav>
      
    <br>
    <h1 class="d-flex justify-content-center" style="text-transform: uppercase;"><strong>Lista de Editorial</strong></h1>

    <nav class="navbar">
        <div class="container-fluid">
            <form class="d-flex" role="search" style="margin-left: 9rem">
                <input class="form-control me-4" type="search" placeholder="Ingese su búsqueda" aria-label="Search">
                <button class="btn btn-warning" type="submit" style="color: #fff; font-weight:600">Buscar</button>
            </form>
        </div>
    </nav><br>

    <div class="container">

        <table class="table table-striped">
            <tr>
                <th scope="col">Codigo</th>
                <th scope="col">Nombre</th>
                <th scope="col">Direccion</th>
                <th scope="col">Telefono</th>
                <th scope="col">Email</th>
                <th scope="col">RUC</th>
                <th scope="col">Acciones</th>
            </tr>

            <tr>
                <th></th>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><a class="btn btn-outline-success" href="editarEditorial.jsp">Editar</a>
                    <a class="btn btn-outline-danger" href="#" onclick="confirmarEliminacion()">Eliminar</a>
                </td>
            </tr>
        </table>

        <div class="d-flex justify-content-center">
            <input class="btn btn-primary" type="button" value="Añadir Editorial" style="color: #fff; font-weight:600"
                onclick="window.location.href='registrarEditorial.jsp'">
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
        
<script>
	function confirmarEliminacion(codigo) {
		if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
			window.location.href = "ControladorClientes?instruccion=eliminar&codigo=" + codigo;
		}
	}
</script>
    
</body>
</html>