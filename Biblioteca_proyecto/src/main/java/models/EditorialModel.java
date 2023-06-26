package models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entities.Editorial;
import util.MySQLConexion;

public class EditorialModel {
    public static List<Editorial> listarEditoriales() throws Exception {
        List<Editorial> editoriales = new ArrayList<>();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            cn = MySQLConexion.getConexion();
            String sql = "SELECT idEditorial, nombre, direccion, telefono, email, ruc FROM Editorial";
            st = cn.createStatement();
            rs = st.executeQuery(sql);

            while (rs.next()) {
                String idEditorial = rs.getString("idEditorial");
                String nombre = rs.getString("nombre");
                String direccion = rs.getString("direccion");
                String telefono = rs.getString("telefono");
                String email = rs.getString("email");
                String ruc = rs.getString("ruc");

                Editorial editorial = new Editorial(idEditorial, nombre, direccion, telefono, email, ruc);
                editoriales.add(editorial);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
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
        return editoriales;
    }

    public static void agregarEditorial(Editorial editorial) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "INSERT INTO Editorial (idEditorial, nombre, direccion, telefono, email, ruc) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, editorial.getIdEditorial());
            preparedStatement.setString(2, editorial.getNombre());
            preparedStatement.setString(3, editorial.getDireccion());
            preparedStatement.setString(4, editorial.getTelefono());
            preparedStatement.setString(5, editorial.getEmail());
            preparedStatement.setString(6, editorial.getRuc());

            preparedStatement.executeUpdate();
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Editorial mostrarEditorial(String idEditorial) throws Exception {
        Editorial editorial = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = MySQLConexion.getConexion();
            String query = "SELECT * FROM Editorial WHERE idEditorial = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idEditorial);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String id = resultSet.getString("idEditorial");
                String nombre = resultSet.getString("nombre");
                String direccion = resultSet.getString("direccion");
                String telefono = resultSet.getString("telefono");
                String email = resultSet.getString("email");
                String ruc = resultSet.getString("ruc");

                editorial = new Editorial(id, nombre, direccion, telefono, email, ruc);
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return editorial;
    }

    public static void actualizarEditorial(Editorial editorial) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "UPDATE Editorial SET nombre = ?, direccion = ?, telefono = ?, email = ?, ruc = ? WHERE idEditorial = ?";
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, editorial.getNombre());
            preparedStatement.setString(2, editorial.getDireccion());
            preparedStatement.setString(3, editorial.getTelefono());
            preparedStatement.setString(4, editorial.getEmail());
            preparedStatement.setString(5, editorial.getRuc());
            preparedStatement.setString(6, editorial.getIdEditorial());

            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void eliminarEditorial(String idEditorial) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "DELETE FROM Editorial WHERE idEditorial = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idEditorial);

            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
