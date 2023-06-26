package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.LibroModel;

import java.io.IOException;
import java.util.List;

import entities.Libro;

public class LibroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

		if (action == null)
			action = "listar";

		switch (action) {
		case "listar":
			listarLibros(request, response);
			break;
		case "agregar":
			try {
				agregarLibro(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "mostrar":
			try {
				mostrarLibro(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "actualizar":
			try {
				actualizarLibro(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "eliminar":
			try {
				eliminarLibro(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		default:
			listarLibros(request, response);
			break;
		}
	}

    private void listarLibros(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			List<Libro> libros = LibroModel.listarLibros();
			request.setAttribute("libros", libros);
			request.getRequestDispatcher("listaLibros.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

    private void agregarLibro(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String idLibro = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String idEditorial = request.getParameter("idEditorial");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String estado = request.getParameter("estado");

        Libro libro = new Libro(idLibro, titulo, autor, idEditorial, stock, estado, "");
        LibroModel.agregarLibro(libro);
        
        listarLibros(request, response);
    }

    private void mostrarLibro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String idLibro = request.getParameter("id");
        Libro libro = LibroModel.mostrarLibro(idLibro);

        request.setAttribute("libro", libro);
        request.getRequestDispatcher("editarLibro.jsp").forward(request, response);
    }

    private void actualizarLibro(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String idLibro = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String idEditorial = request.getParameter("idEditorial");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String estado = request.getParameter("estado");

        Libro libro = new Libro(idLibro, titulo, autor, idEditorial, stock, estado);
        LibroModel.actualizarLibro(libro);
        listarLibros(request, response);
    }

    private void eliminarLibro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idLibro = request.getParameter("id");

        LibroModel.eliminarLibro(idLibro);
        listarLibros(request, response);
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
