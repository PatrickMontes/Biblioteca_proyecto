package models;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import entities.CompraLibro;
import util.MySQLConexion;

public class CompraLibroModel {

	public static List<CompraLibro> obtenerDetallesCompra() {
		List<CompraLibro> detallesCompra = new ArrayList<>();

		try (Connection connection = MySQLConexion.getConexion()) {
			String sql = "{CALL ObtenerDetallesCompra()}";
			try (CallableStatement statement = connection.prepareCall(sql)) {
				try (ResultSet resultSet = statement.executeQuery()) {
					while (resultSet.next()) {
						String idCompra = resultSet.getString("idCompra");
						String titulo = resultSet.getString("titulo");
						String nombreEditorial = resultSet.getString("nombreEditorial");
						String empleado = resultSet.getString("empleado");
						LocalDate fecCompra = resultSet.getDate("fecCompra").toLocalDate();
						BigDecimal precio = resultSet.getBigDecimal("precio");
						int cantidad = resultSet.getInt("cantidad");

						CompraLibro detalleCompra = new CompraLibro(idCompra, titulo, nombreEditorial, empleado, fecCompra, precio, cantidad);
						detallesCompra.add(detalleCompra);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return detallesCompra;
	}

	public static void agregarCompraLibro(CompraLibro compraLibro) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "INSERT INTO CompraLibro (idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad) VALUES (?, ?, ?, ?, ?, ?, ?)";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, compraLibro.getIdCompra());
			preparedStatement.setString(2, compraLibro.getLibro());
			preparedStatement.setString(3, compraLibro.getEditorial());
			preparedStatement.setString(4, compraLibro.getEmpleado());
			preparedStatement.setDate(5, java.sql.Date.valueOf(compraLibro.getFecCompra()));
			preparedStatement.setBigDecimal(6, compraLibro.getPrecio());
			preparedStatement.setInt(7, compraLibro.getCantidad());

			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static CompraLibro mostrarCompraLibro(String idCompra) {
		CompraLibro compraLibro = null;
		try (Connection connection = MySQLConexion.getConexion()) {
			String sql = "SELECT CL.idCompra, CL.idLibro, CL.idEditorial, CL.idEmpleado, CL.fecCompra, CL.precio, CL.cantidad, L.titulo, ED.nombre AS nombreEditorial, CONCAT(E.nombre, ' ', E.apellido) AS nombreEmpleado "
					+ "FROM CompraLibro CL "
					+ "INNER JOIN Libro L ON CL.idLibro = L.idLibro "
					+ "INNER JOIN Editorial ED ON CL.idEditorial = ED.idEditorial "
					+ "INNER JOIN Empleado E ON CL.idEmpleado = E.idEmpleado "
					+ "WHERE CL.idCompra = ?";

			try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
				preparedStatement.setString(1, idCompra);
				try (ResultSet resultSet = preparedStatement.executeQuery()) {
					if (resultSet.next()) {
						String idLibro = resultSet.getString("idLibro");
						String idEditorial = resultSet.getString("idEditorial");
						String idEmpleado = resultSet.getString("idEmpleado");
						LocalDate fecCompra = resultSet.getDate("fecCompra").toLocalDate();
						BigDecimal precio = resultSet.getBigDecimal("precio");
						int cantidad = resultSet.getInt("cantidad");
						String titulo = resultSet.getString("titulo");
						String nombreEditorial = resultSet.getString("nombreEditorial");
						String nombreEmpleado = resultSet.getString("nombreEmpleado");

						compraLibro = new CompraLibro(idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad);
						compraLibro.setLibro(idLibro);
						compraLibro.setEditorial(nombreEditorial);
						compraLibro.setEmpleado(nombreEmpleado);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return compraLibro;
	}

	public static void actualizarCompraLibro(CompraLibro compraLibro) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "UPDATE CompraLibro SET idLibro = ?, idEditorial = ?, idEmpleado = ?, fecCompra = ?, precio = ?, cantidad = ? WHERE idCompra = ?";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, compraLibro.getLibro());
			preparedStatement.setString(2, compraLibro.getEditorial());
			preparedStatement.setString(3, compraLibro.getEmpleado());
			preparedStatement.setDate(4, java.sql.Date.valueOf(compraLibro.getFecCompra()));
			preparedStatement.setBigDecimal(5, compraLibro.getPrecio());
			preparedStatement.setInt(6, compraLibro.getCantidad());
			preparedStatement.setString(7, compraLibro.getIdCompra());

			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void eliminarCompraLibro(String idCompra) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "DELETE FROM CompraLibro WHERE idCompra = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, idCompra);

			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
