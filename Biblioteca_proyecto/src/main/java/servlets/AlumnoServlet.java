package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.AlumnoModel;

import java.io.IOException;
import java.util.List;

import entities.Alumno;

/**
 * Servlet implementation class AlumnoServlet
 */
public class AlumnoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

		if (action == null)
			// Acción predeterminada: listar alumnos
			action = "listar";

		switch (action) {
		case "listar":
			listarAlumnos(request, response);
			break;
		case "agregar":
			try {
				agregarAlumno(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "mostrar":
			try {
				mostrarAlumno(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "actualizar":
			try {
				actualizarAlumno(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "eliminar":
			try {
				eliminarAlumno(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			listarAlumnos(request, response);
			break;
		}
	}

	private void listarAlumnos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<Alumno> alumnos = AlumnoModel.listarAlumnos();
			request.setAttribute("alumnos", alumnos);
			request.getRequestDispatcher("listaAlumnos.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void mostrarAlumno(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String idAlumno = request.getParameter("id");
		Alumno alumno = AlumnoModel.mostrarAlumno(idAlumno);
		
		request.setAttribute("alumno", alumno);
		request.getRequestDispatcher("editarAlumno.jsp").forward(request, response);
	}

	private void agregarAlumno(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String idAlumno = request.getParameter("id");
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String direccion = request.getParameter("direccion");
		String telefono = request.getParameter("telefono");
		String email = request.getParameter("email");

		Alumno alumno = new Alumno(idAlumno, nombre, apellido, direccion, telefono, email);
		AlumnoModel.agregarAlumno(alumno);
		listarAlumnos(request, response);
	}

	private void actualizarAlumno(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String idAlumno = request.getParameter("id");
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String direccion = request.getParameter("direccion");
		String telefono = request.getParameter("telefono");
		String email = request.getParameter("email");

		Alumno alumno = new Alumno(idAlumno, nombre, apellido, direccion, telefono, email);
		AlumnoModel.actualizarAlumno(alumno);
		listarAlumnos(request, response);
	}

	private void eliminarAlumno(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String idAlumno = request.getParameter("id");

		AlumnoModel.eliminarAlumno(idAlumno);
		listarAlumnos(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
