package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entities.Empleado;
import util.MySQLConexion;

public class EmpleadoModel {
	public static List<Empleado> listarEmpleados() throws Exception {
	    List<Empleado> empleados = new ArrayList<>();
	    Connection cn = null;
	    Statement st = null;
	    ResultSet rs = null;

	    try {
	        cn = MySQLConexion.getConexion();
	        String sql = "SELECT idEmpleado, nombre, apellido, direccion, telefono, email FROM empleado";
	        st = cn.createStatement();
	        rs = st.executeQuery(sql);

	        while (rs.next()) {
	            String idEmpleado = rs.getString("idEmpleado");
	            String nombre = rs.getString("nombre");
	            String apellido = rs.getString("apellido");
	            String direccion = rs.getString("direccion");
	            String telefono = rs.getString("telefono");
	            String email = rs.getString("email");

	            Empleado empleado = new Empleado(idEmpleado, nombre, apellido, direccion, telefono, email);
	            empleados.add(empleado);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // Cerrar recursos en finally para asegurarse de que se cierren incluso si se produce una excepción
	        if (rs != null) {
	            rs.close();
	        }
	        if (st != null) {
	            st.close();
	        }
	        if (cn != null) {
	            cn.close();
	        }
	    }
	    return empleados;
	}

    public static void agregarEmpleado(Empleado empleado) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "INSERT INTO Empleado (idEmpleado, nombre, apellido, direccion, telefono, email, dni, clave) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, empleado.getIdEmpleado());
            preparedStatement.setString(2, empleado.getNombre());
            preparedStatement.setString(3, empleado.getApellido());
            preparedStatement.setString(4, empleado.getDireccion());
            preparedStatement.setString(5, empleado.getTelefono());
            preparedStatement.setString(6, empleado.getEmail());
            preparedStatement.setString(7, empleado.getDni());
            preparedStatement.setString(8, empleado.getPass());

            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Empleado mostrarEmpleado(String idEmpleado) throws Exception {
        Empleado empleado = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = MySQLConexion.getConexion();
            String query = "SELECT * FROM Empleado WHERE idEmpleado = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idEmpleado);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String id = resultSet.getString("idEmpleado");
                String nombre = resultSet.getString("nombre");
                String apellido = resultSet.getString("apellido");
                String direccion = resultSet.getString("direccion");
                String telefono = resultSet.getString("telefono");
                String email = resultSet.getString("email");
                String dni = resultSet.getString("dni");
                String clave = resultSet.getString("clave");

                empleado = new Empleado(id, nombre, apellido, direccion, telefono, email, dni, clave);
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return empleado;
    }

    public static void actualizarEmpleado(Empleado empleado) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "UPDATE Empleado SET nombre = ?, apellido = ?, direccion = ?, telefono = ?, email = ?, dni = ?, clave = ? WHERE idEmpleado = ?";
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, empleado.getNombre());
            preparedStatement.setString(2, empleado.getApellido());
            preparedStatement.setString(3, empleado.getDireccion());
            preparedStatement.setString(4, empleado.getTelefono());
            preparedStatement.setString(5, empleado.getEmail());
            preparedStatement.setString(6, empleado.getDni());
            preparedStatement.setString(7, empleado.getPass());
            preparedStatement.setString(8, empleado.getIdEmpleado());

            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void eliminarEmpleado(String idEmpleado) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "DELETE FROM Empleado WHERE idEmpleado = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idEmpleado);

            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
