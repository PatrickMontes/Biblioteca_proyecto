package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.CompraLibroModel;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import entities.CompraLibro;
import entities.Editorial;

public class CompraLibroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null)
            action = "listar";

        switch (action) {
            case "listar":
                listarCompras(request, response);
                break;
            case "agregar":
                try {
                    agregarCompra(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "mostrar":
                try {
                    mostrarCompra(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "actualizar":
                try {
                    actualizarCompra(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "eliminar":
                try {
                    eliminarCompra(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            default:
                listarCompras(request, response);
                break;
        }
    }

    private void listarCompras(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<CompraLibro> compras = CompraLibroModel.listarCompras();
            request.setAttribute("compras", compras);
            request.getRequestDispatcher("listaCompras.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void agregarCompra(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idCompra = request.getParameter("id");
        String idLibro = request.getParameter("idLibro");
        String idEditorial = request.getParameter("idEditorial");
        String idEmpleado = request.getParameter("idEmpleado");
        String fechaCompraStr = request.getParameter("fecCompra");
        LocalDate fecCompra = null;

        if (fechaCompraStr != null && !fechaCompraStr.isEmpty()) {
            fecCompra = LocalDate.parse(fechaCompraStr);
        } else {
            // Manejar el caso cuando el campo de fecha está vacío o nulo
            // Por ejemplo, asignar un valor predeterminado o mostrar un mensaje de error
            // Aquí se asigna la fecha actual como valor predeterminado:
            fecCompra = LocalDate.now();
        }


        String precioStr = request.getParameter("precio");
        BigDecimal precio = null;

        if (precioStr != null && !precioStr.isEmpty()) {
            precio = new BigDecimal(precioStr);
        } else {
            // Manejar el caso cuando el campo de precio está vacío o nulo
        }

        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        CompraLibro compra = new CompraLibro(idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad);
        CompraLibroModel.agregarCompraLibro(compra);

        listarCompras(request, response);
    }

    private void mostrarCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCompra = request.getParameter("id");
        CompraLibro compra = CompraLibroModel.mostrarCompraLibro(idCompra);

        request.setAttribute("compra", compra);
        request.getRequestDispatcher("editarCompras.jsp").forward(request, response);
    }

    private void actualizarCompra(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idCompra = request.getParameter("id");
        String idLibro = request.getParameter("idLibro");
        String idEditorial = request.getParameter("idEditorial");
        String idEmpleado = request.getParameter("idEmpleado");
        String fechaCompraStr = request.getParameter("fecCompra");
        LocalDate fecCompra = null;

        if (fechaCompraStr != null && !fechaCompraStr.isEmpty()) {
            fecCompra = LocalDate.parse(fechaCompraStr);
        } else {
            fecCompra = LocalDate.now();
        }

        String precioStr = request.getParameter("precio");
        BigDecimal precio = null;

        if (precioStr != null && !precioStr.isEmpty()) {
            precio = new BigDecimal(precioStr);
        }

        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        System.out.println("idCompra: " + idCompra);
       System.out.println("idLibro: " + idLibro);
        System.out.println("idEditorial: " + idEditorial);
        System.out.println("idEmpleado: " + idEmpleado);
        System.out.println("fecCompra: " + fecCompra);
        System.out.println("precio: " + precio);
        System.out.println("cantidad: " + cantidad);

        CompraLibro compra = new CompraLibro(idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad);
        CompraLibroModel.actualizarCompraLibro(compra);
        listarCompras(request, response);
    }


    private void eliminarCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCompra = request.getParameter("id");

        CompraLibroModel.eliminarCompraLibro(idCompra);
        listarCompras(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
