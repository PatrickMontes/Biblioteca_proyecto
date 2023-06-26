<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<title>Login</title>
<style>
        .alert-small {
            padding: 0.7rem 1rem;
            font-size: 0.875rem;
            text-align: center;
            font-weight: bold;
            margin-top: 1rem;
            margin: 0 42%;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4 col-lg-4 d-flex justify-content-center">
        <div class="card col-sm-10">
            <div class="card-body">
                <form method="post" action="login.jsp" class="form-sign">
                    <div class="form-group text-center d-flex flex-column justify-content-center align-items-center">
                        <h3 style="font-weight: 700; font-size: 2rem; text-transform: uppercase;">Login</h3>
                        <img alt="Logo" src="img/people.svg" width="40%">
                    </div>
                    <div class="form-group">
                        <label>Usuario:</label>
                        <input type="text" name="user" id="user" class="form-control">
                    </div>
                    <br>
                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="pass" id="pass" class="form-control">
                    </div>
                    <br>
                    <div style="text-align: center">
                        <input type="submit" name="login" value="Ingresar" class="btn btn-success" style="font-weight: 600">
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<%
    if (request.getParameter("login") != null) {
        String user = request.getParameter("user");
        String password = request.getParameter("pass");
        HttpSession sessionObj = request.getSession();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/biblioteca_project?useTimezone=true&serverTimezone=UTC", "root", "09504055MM");
            String query = "SELECT * FROM Empleado WHERE dni = ? AND clave = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, user);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                sessionObj.setAttribute("logueado", "1");
                sessionObj.setAttribute("user", rs.getString("dni"));
                sessionObj.setAttribute("id", rs.getString("idEmpleado"));
                response.sendRedirect("LibroServlet?listaLibros&action=listar");
            } else {
                out.print("<br> <div class=\"alert alert-danger alert-small\" role=\"alert\"> Usuario o Contraseña no válido </div>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.print(" <div class=\"alert alert-danger\" role=\"alert\"> Error en la conexión con la base de datos </div>");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</html>
