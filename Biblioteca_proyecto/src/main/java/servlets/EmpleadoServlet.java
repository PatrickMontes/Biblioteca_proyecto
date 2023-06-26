package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.EmpleadoModel;

import java.io.IOException;
import java.util.List;

import entities.Empleado;

public class EmpleadoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null)
            // Acción predeterminada: listar empleados
            action = "listar";

        switch (action) {
            case "listar":
                listarEmpleados(request, response);
                break;
            case "agregar":
                try {
                    agregarEmpleado(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "mostrar":
                try {
                    mostrarEmpleado(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "actualizar":
                try {
                    actualizarEmpleado(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "eliminar":
                try {
                    eliminarEmpleado(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            default:
                listarEmpleados(request, response);
                break;
        }
    }

    private void listarEmpleados(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Empleado> empleados = EmpleadoModel.listarEmpleados();
            request.setAttribute("empleados", empleados);
            request.getRequestDispatcher("listaEmpleados.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void mostrarEmpleado(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idEmpleado = request.getParameter("id");
        Empleado empleado = EmpleadoModel.mostrarEmpleado(idEmpleado);

        request.setAttribute("empleado", empleado);
        request.getRequestDispatcher("editarEmpleado.jsp").forward(request, response);
    }

    private void agregarEmpleado(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idEmpleado = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String dni = request.getParameter("dni");
        String clave = request.getParameter("clave");

        Empleado empleado = new Empleado(idEmpleado, nombre, apellido, direccion, telefono, email, dni, clave);
        EmpleadoModel.agregarEmpleado(empleado);
        listarEmpleados(request, response);
    }

    private void actualizarEmpleado(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idEmpleado = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String dni = request.getParameter("dni");
        String clave = request.getParameter("clave");

        Empleado empleado = new Empleado(idEmpleado, nombre, apellido, direccion, telefono, email, dni, clave);
        EmpleadoModel.actualizarEmpleado(empleado);
        listarEmpleados(request, response);
    }

    private void eliminarEmpleado(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idEmpleado = request.getParameter("id");

        EmpleadoModel.eliminarEmpleado(idEmpleado);
        listarEmpleados(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
