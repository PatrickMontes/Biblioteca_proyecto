package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entities.Alumno;
import util.MySQLConexion;

public class AlumnoModel {
	//esto es para listar 
	public static List<Alumno> listarAlumnos() throws Exception {
		List<Alumno> alumnos = new ArrayList<>();
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			connection = MySQLConexion.getConexion();
			String sql = "SELECT * FROM alumno";
			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				String idAlumno = resultSet.getString("idAlumno"); //nombre de las columnas de last tablas 
				String nombre = resultSet.getString("nombre");
				String apellido = resultSet.getString("apellido");
				String direccion = resultSet.getString("direccion");
				String telefono = resultSet.getString("telefono");
				String email = resultSet.getString("email");

				Alumno alumno = new Alumno(idAlumno, nombre, apellido, direccion, telefono, email);
				alumnos.add(alumno);
			}
			resultSet.close();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return alumnos;
	}

	public static void agregarAlumno(Alumno alumno) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "INSERT INTO alumno (idAlumno, nombre, apellido, direccion, telefono, email) VALUES (?, ?, ?, ?, ?, ?)";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, alumno.getIdAlumno());
			preparedStatement.setString(2, alumno.getNombre());
			preparedStatement.setString(3, alumno.getApellido());
			preparedStatement.setString(4, alumno.getDireccion());
			preparedStatement.setString(5, alumno.getTelefono());
			preparedStatement.setString(6, alumno.getEmail());

			preparedStatement.executeUpdate();
			preparedStatement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static Alumno mostrarAlumno(String idAlumno) throws Exception {
		Alumno alumno = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			connection = MySQLConexion.getConexion();
			String query = "SELECT * FROM alumno WHERE idAlumno = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, idAlumno);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				String id = resultSet.getString("idAlumno");
				String nombre = resultSet.getString("nombre");
				String apellido = resultSet.getString("apellido");
				String direccion = resultSet.getString("direccion");
				String telefono = resultSet.getString("telefono");
				String email = resultSet.getString("email");

				alumno = new Alumno(id, nombre, apellido, direccion, telefono, email);
			}

			resultSet.close();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return alumno;
	}

	public static void actualizarAlumno(Alumno alumno) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "UPDATE alumno SET nombre = ?, apellido = ?, direccion = ?, telefono = ?, email = ? WHERE idAlumno = ?";
			preparedStatement = connection.prepareStatement(query);

			preparedStatement.setString(1, alumno.getNombre());
			preparedStatement.setString(2, alumno.getApellido());
			preparedStatement.setString(3, alumno.getDireccion());
			preparedStatement.setString(4, alumno.getTelefono());
			preparedStatement.setString(5, alumno.getEmail());
			preparedStatement.setString(6, alumno.getIdAlumno());
			
			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void eliminarAlumno(String idAlumno) throws Exception {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = MySQLConexion.getConexion();
			String query = "DELETE FROM alumno WHERE idAlumno IS NULL OR idAlumno = ?";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, idAlumno);
			
			preparedStatement.executeUpdate();
			preparedStatement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}