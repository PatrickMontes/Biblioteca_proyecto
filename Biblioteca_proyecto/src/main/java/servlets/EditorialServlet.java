package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.EditorialModel;

import java.io.IOException;
import java.util.List;

import entities.Editorial;

/**
 * Servlet implementation class EditorialServlet
 */
public class EditorialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    String action = request.getParameter("action");

	    if (action == null)
	        // Acción predeterminada: listar editoriales
	        action = "listar";

	    switch (action) {
	        case "listar":
	            listarEditoriales(request, response);
	            break;
	        case "agregar":
	            try {
	                agregarEditorial(request, response);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	            break;
	        case "mostrar":
	            try {
	                mostrarEditorial(request, response);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	            break;
	        case "actualizar":
	            try {
	                actualizarEditorial(request, response);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	            break;
	        case "eliminar":
	            try {
	                eliminarEditorial(request, response);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	            break;
	        default:
	            listarEditoriales(request, response);
	            break;
	    }
	}

	private void listarEditoriales(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        List<Editorial> editoriales = EditorialModel.listarEditoriales();
	        request.setAttribute("editoriales", editoriales);
	        request.getRequestDispatcher("listaEditoriales.jsp").forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	private void mostrarEditorial(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String idEditorial = request.getParameter("id");
	    Editorial editorial = EditorialModel.mostrarEditorial(idEditorial);

	    request.setAttribute("editorial", editorial);
	    request.getRequestDispatcher("editarEditorial.jsp").forward(request, response);
	}

	private void agregarEditorial(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String idEditorial = request.getParameter("id");
	    String nombre = request.getParameter("nombre");
	    String direccion = request.getParameter("direccion");
	    String telefono = request.getParameter("telefono");
	    String email = request.getParameter("email");
	    String ruc = request.getParameter("ruc");

	    Editorial editorial = new Editorial(idEditorial, nombre, direccion, telefono, email, ruc);
	    EditorialModel.agregarEditorial(editorial);
	    listarEditoriales(request, response);
	}

	private void actualizarEditorial(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String idEditorial = request.getParameter("id");
	    String nombre = request.getParameter("nombre");
	    String direccion = request.getParameter("direccion");
	    String telefono = request.getParameter("telefono");
	    String email = request.getParameter("email");
	    String ruc = request.getParameter("ruc");

	    Editorial editorial = new Editorial(idEditorial, nombre, direccion, telefono, email, ruc);
	    EditorialModel.actualizarEditorial(editorial);
	    listarEditoriales(request, response);
	}

	private void eliminarEditorial(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String idEditorial = request.getParameter("id");

	    EditorialModel.eliminarEditorial(idEditorial);
	    listarEditoriales(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
