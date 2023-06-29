package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.PrestamoModel;
import entities.Prestamo;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class PrestamoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null)
            action = "listar";

        switch (action) {
            case "listar":
                listarPrestamos(request, response);
                break;
            case "agregar":
                try {
                    agregarPrestamo(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "mostrar":
                try {
                    mostrarPrestamo(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "actualizar":
                try {
                    actualizarPrestamo(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "eliminar":
                try {
                    eliminarPrestamo(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            default:
                listarPrestamos(request, response);
                break;
        }
    }

    private void listarPrestamos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Prestamo> prestamos = PrestamoModel.listarPrestamos();
            request.setAttribute("prestamos", prestamos);
            request.getRequestDispatcher("listaPrestamos.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void agregarPrestamo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idPrestamo = request.getParameter("id");
        String idLibro = request.getParameter("idLibro");

        String fecPrestamoStr = request.getParameter("fecPrestamo");
        LocalDate fecPrestamo = null;

        if (fecPrestamoStr != null && !fecPrestamoStr.isEmpty()) {
            fecPrestamo = LocalDate.parse(fecPrestamoStr);
        } else {
            fecPrestamo = LocalDate.now();
        }

        String fecDevolucionStr = request.getParameter("fecDevolucion");
        LocalDate fecDevolucion = null;

        if (fecDevolucionStr != null && !fecDevolucionStr.isEmpty()) {
            fecDevolucion = LocalDate.parse(fecDevolucionStr);
        } else {
            fecDevolucion = LocalDate.now();
        }
        String idAlumno = request.getParameter("idAlumno");
        String estDevolucion = request.getParameter("estDevolucion");
        Prestamo prestamo = new Prestamo(idPrestamo, idLibro, fecPrestamo, fecDevolucion, idAlumno, estDevolucion);
        PrestamoModel.agregarPrestamo(prestamo);

        listarPrestamos(request, response);
    }

    private void mostrarPrestamo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idPrestamo = request.getParameter("id");
        Prestamo prestamo = PrestamoModel.mostrarPrestamoLibro(idPrestamo);

        request.setAttribute("prestamo", prestamo);
        request.getRequestDispatcher("editarPrestamo.jsp").forward(request, response);
    }

    private void actualizarPrestamo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idPrestamo = request.getParameter("id");
        String idLibro = request.getParameter("idLibro");
        String fecPrestamoStr = request.getParameter("fecPrestamo");
        LocalDate fecPrestamo = null;

        if (fecPrestamoStr != null && !fecPrestamoStr.isEmpty()) {
            fecPrestamo = LocalDate.parse(fecPrestamoStr);
        } else {
            fecPrestamo = LocalDate.now();
        }

        String fecDevolucionStr = request.getParameter("fecDevolucion");
        LocalDate fecDevolucion = null;

        if (fecDevolucionStr != null && !fecDevolucionStr.isEmpty()) {
            fecDevolucion = LocalDate.parse(fecDevolucionStr);
        } else {
            fecDevolucion = LocalDate.now();
        }
        String idAlumno = request.getParameter("idAlumno");
        String estDevolucion = request.getParameter("estDevolucion");
        Prestamo prestamo = new Prestamo(idPrestamo, idLibro, fecPrestamo, fecDevolucion, idAlumno, estDevolucion);
        PrestamoModel.actualizarPrestamoLibro(prestamo);

        listarPrestamos(request, response);
    }

    private void eliminarPrestamo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idPrestamo = request.getParameter("id");

        PrestamoModel.eliminarPrestamoLibro(idPrestamo);
        listarPrestamos(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
