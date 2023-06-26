<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <h1 class="text-center" style="text-transform: uppercase;"><strong>Registrar Editorial</strong></h1>
        <br>
        <form style="margin: 0 12%" method="get" action="EditorialServlet">
            <input type="hidden" name="action" value="agregar">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="id" class="form-label"><b>Id Editorial:</b></label>
                    <input type="text" class="form-control" id="id" name="id">
                </div>
                <div class="col-md-6">
                    <label for="nombre" class="form-label"><b>Nombre:</b></label> 
                    <input type="text" class="form-control" id="nombre" name="nombre">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="direccion" class="form-label"><b>Dirección:</b></label>
                    <input type="text" class="form-control" id="direccion" name="direccion">
                </div>
                <div class="col-md-6">
                    <label for="telefono" class="form-label"><b>Teléfono:</b></label> 
                    <input type="text" class="form-control" id="telefono" name="telefono">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="email" class="form-label"><b>Email:</b></label> 
                    <input type="email" class="form-control" id="email" name="email">
                </div>
                <div class="col-md-6">
                    <label for="ruc" class="form-label"><b>RUC:</b></label>
                    <input type="text" class="form-control" id="ruc" name="ruc">
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <br>
                    <input type="submit" name="enviar" id="enviar"
                        value="Registrar Editorial" class="btn btn-primary"
                        style="font-weight: 600"> <input type="reset"
                        name="borrar" id="borrar" value="Restablecer"
                        class="btn btn-secondary" style="font-weight: 600">
                </div>
            </div>
        </form>
    </div>
</body>
<%@include file="snippet/bootstrap_fin.jsp" %>
</html>
