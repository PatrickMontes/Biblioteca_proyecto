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

    public static List<CompraLibro> listarCompras() {
        List<CompraLibro> compras = new ArrayList<>();

        try (Connection connection = MySQLConexion.getConexion()) {
            String sql = "{CALL ObtenerDetallesCompra()}";
            try (CallableStatement statement = connection.prepareCall(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        String idCompra = resultSet.getString("idCompra");
                        String titulo = resultSet.getString("titulo");
                        String editorial = resultSet.getString("editorial");
                        String empleado = resultSet.getString("empleado");
                        LocalDate fecCompra = resultSet.getDate("fecCompra").toLocalDate();
                        BigDecimal precio = resultSet.getBigDecimal("precio");
                        int cantidad = resultSet.getInt("cantidad");

                        CompraLibro compra = new CompraLibro(idCompra, fecCompra, precio, cantidad, titulo, editorial, empleado);
                        compras.add(compra);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return compras;
    }

    public static void agregarCompraLibro(CompraLibro compra) throws Exception {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "INSERT INTO CompraLibro (idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad) VALUES (?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, compra.getIdCompra());
            preparedStatement.setString(2, compra.getIdLibro());
            preparedStatement.setString(3, compra.getIdEditorial());
            preparedStatement.setString(4, compra.getIdEmpleado());
            preparedStatement.setDate(5, java.sql.Date.valueOf(compra.getFecCompra()));
            preparedStatement.setBigDecimal(6, compra.getPrecio());
            preparedStatement.setInt(7, compra.getCantidad());

            preparedStatement.executeUpdate();
            
            // Incrementar el stock del libro en la misma transacción
            String libroId = compra.getIdLibro();
            int cantidadComprada = compra.getCantidad();
            query = "UPDATE Libro SET stock = stock + ? WHERE idLibro = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, cantidadComprada);
            preparedStatement.setString(2, libroId);
            preparedStatement.executeUpdate();
            
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static CompraLibro mostrarCompraLibro(String idCompra) {
        CompraLibro compra = null;
        try (Connection connection = MySQLConexion.getConexion()) {
            String sql = "SELECT CL.idCompra, L.titulo, ED.nombre AS editorial, CONCAT(E.nombre, ' ', E.apellido) AS empleado, CL.fecCompra, CL.precio, CL.cantidad "
                    + "FROM CompraLibro CL "
                    + "INNER JOIN Libro L ON CL.idLibro = L.idLibro "
                    + "INNER JOIN Editorial ED ON CL.idEditorial = ED.idEditorial "
                    + "INNER JOIN Empleado E ON CL.idEmpleado = E.idEmpleado "
                    + "WHERE CL.idCompra = ?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, idCompra);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        String titulo = resultSet.getString("titulo");
                        String editorial = resultSet.getString("editorial");
                        String empleado = resultSet.getString("empleado");
                        LocalDate fecCompra = resultSet.getDate("fecCompra").toLocalDate();
                        BigDecimal precio = resultSet.getBigDecimal("precio");
                        int cantidad = resultSet.getInt("cantidad");

                        compra = new CompraLibro(idCompra, fecCompra, precio, cantidad, titulo, editorial, empleado);
                    }
                }
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return compra;
    }

    public static void actualizarCompraLibro(CompraLibro compra) throws Exception {
        Connection connection = null;
        CallableStatement callableStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "{CALL actualizarCompraLibro(?, ?, ?, ?, ?, ?, ?)}";
            callableStatement = connection.prepareCall(query);

            callableStatement.setString(1, compra.getIdLibro());
            callableStatement.setString(2, compra.getIdEditorial());
            callableStatement.setString(3, compra.getIdEmpleado());
            callableStatement.setDate(4, java.sql.Date.valueOf(compra.getFecCompra()));
            callableStatement.setBigDecimal(5, compra.getPrecio());
            callableStatement.setInt(6, compra.getCantidad());
            callableStatement.setString(7, compra.getIdCompra());

            callableStatement.executeUpdate();
            callableStatement.close();
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
            String query = "DELETE FROM CompraLibro WHERE idCompra IS NULL OR idCompra = ?";
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
