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
            List<CompraLibro> compras = CompraLibroModel.obtenerDetallesCompra();
            request.setAttribute("compras", compras);
            request.getRequestDispatcher("listaCompras.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void agregarCompra(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idCompra = request.getParameter("idCompra");
        String idLibro = request.getParameter("idLibro");
        String idEditorial = request.getParameter("idEditorial");
        String idEmpleado = request.getParameter("idEmpleado");
        LocalDate fecCompra = LocalDate.parse(request.getParameter("fecCompra"));
        BigDecimal precio = new BigDecimal(request.getParameter("precio"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        CompraLibro compra = new CompraLibro(idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad);
        CompraLibroModel.agregarCompraLibro(compra);

        listarCompras(request, response);
    }

    private void mostrarCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCompra = request.getParameter("idCompra");
        CompraLibro compra = CompraLibroModel.mostrarCompraLibro(idCompra);

        request.setAttribute("compra", compra);
        request.getRequestDispatcher("editarCompras.jsp").forward(request, response);
    }

    private void actualizarCompra(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idCompra = request.getParameter("idCompra");
        String idLibro = request.getParameter("idLibro");
        String idEditorial = request.getParameter("idEditorial");
        String idEmpleado = request.getParameter("idEmpleado");
        LocalDate fecCompra = LocalDate.parse(request.getParameter("fecCompra"));
        BigDecimal precio = new BigDecimal(request.getParameter("precio"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        CompraLibro compra = new CompraLibro(idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad);
        CompraLibroModel.actualizarCompraLibro(compra);
        listarCompras(request, response);
    }

    private void eliminarCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCompra = request.getParameter("idCompra");

        CompraLibroModel.eliminarCompraLibro(idCompra);
        listarCompras(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
