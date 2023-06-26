package models;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entities.Libro;
import util.MySQLConexion;

public class LibroModel {

	public static List<Libro> listarLibros() {
		List<Libro> libros = new ArrayList<>();

		try (Connection connection = MySQLConexion.getConexion()) {
			String sql = "{CALL SP_MostrarLibros()}";
			try (CallableStatement statement = connection.prepareCall(sql)) {
				try (ResultSet resultSet = statement.executeQuery()) {
					while (resultSet.next()) {
						String idLibro = resultSet.getString("idLibro");
						String titulo = resultSet.getString("titulo");
						String autor = resultSet.getString("autor");
						String editorial = resultSet.getString("editorial");
						int stock = resultSet.getInt("stock");
						String estado = resultSet.getString("estado");

						Libro libro = new Libro(idLibro, titulo, autor, stock, estado, editorial);
						libros.add(libro);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return libros;
	}

	public static void agregarLibro(Libro libro) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "INSERT INTO libro (idLibro, titulo, autor, idEditorial, stock, estado) VALUES (?, ?, ?, ?, ?, ?)";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, libro.getIdLibro());
			preparedStatement.setString(2, libro.getTitulo());
			preparedStatement.setString(3, libro.getAutor());
			preparedStatement.setString(4, libro.getIdEditorial());
			preparedStatement.setInt(5, libro.getStock());
			preparedStatement.setString(6, libro.getEstado());

			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static Libro mostrarLibro(String idLibro) {
		Libro libro = null;
		try (Connection connection = MySQLConexion.getConexion()) {
			String sql = "SELECT L.idLibro, L.titulo, L.autor, L.idEditorial, L.stock, L.estado, E.nombre "
					+ "FROM Libro L INNER JOIN Editorial E ON L.idEditorial = E.idEditorial " + "WHERE L.idLibro = ?";

			try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
				preparedStatement.setString(1, idLibro);
				try (ResultSet resultSet = preparedStatement.executeQuery()) {
					if (resultSet.next()) {
						String titulo = resultSet.getString("titulo");
						String autor = resultSet.getString("autor");
						String idEditorial = resultSet.getString("idEditorial");
						int stock = resultSet.getInt("stock");
						String estado = resultSet.getString("estado");
						String editorial = resultSet.getString("nombre");

						libro = new Libro(idLibro, titulo, autor, idEditorial, stock, estado, editorial);
					}
				}
			}
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return libro;
	}

	public static void actualizarLibro(Libro libro) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "UPDATE libro SET titulo = ?, autor = ?, idEditorial = ?, stock = ?, estado = ? WHERE idLibro = ?";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, libro.getTitulo());
			preparedStatement.setString(2, libro.getAutor());
			preparedStatement.setString(3, libro.getIdEditorial());
			preparedStatement.setInt(4, libro.getStock());
			preparedStatement.setString(5, libro.getEstado());
			preparedStatement.setString(6, libro.getIdLibro());

			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void eliminarLibro(String idLibro) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "DELETE FROM libro WHERE idLibro IS NULL OR idLibro = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, idLibro);

			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}