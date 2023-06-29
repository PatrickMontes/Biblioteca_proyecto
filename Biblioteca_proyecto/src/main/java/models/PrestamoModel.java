package models;

import entities.Prestamo;
import util.MySQLConexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PrestamoModel {
    public static List<Prestamo> listarPrestamos() {
        List<Prestamo> prestamos = new ArrayList<>();

        try (Connection connection = MySQLConexion.getConexion()) {
            String sql = "{CALL ListarPrestamos()}";
            try (CallableStatement statement = connection.prepareCall(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        String idPrestamo = resultSet.getString("idPrestamo");
                        String titulo = resultSet.getString("titulo");
                        LocalDate fecPrestamo = resultSet.getDate("fecPrestamo").toLocalDate();
                        LocalDate fecDevolucion = resultSet.getDate("fecDevolucion").toLocalDate();
                        String alumno = resultSet.getString("alumno");
                        String estDevolucion = resultSet.getString("estDevolucion");

                        Prestamo prestamo = new Prestamo(idPrestamo, fecPrestamo, fecDevolucion, estDevolucion, titulo, alumno);
                        prestamos.add(prestamo);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return prestamos;
    }
    
    public static void agregarPrestamo(Prestamo prestamo) throws Exception {
        try (Connection connection = MySQLConexion.getConexion()) {
            String query = "INSERT INTO Prestamo (idPrestamo, idLibro, fecPrestamo, fecDevolucion, idAlumno, estDevolucion) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, prestamo.getIdPrestamo());
                preparedStatement.setString(2, prestamo.getIdLibro());
                preparedStatement.setDate(3, java.sql.Date.valueOf(prestamo.getFecPrestamo()));
                preparedStatement.setDate(4, java.sql.Date.valueOf(prestamo.getFecDevolucion()));
                preparedStatement.setString(5, prestamo.getIdAlumno());
                preparedStatement.setString(6, prestamo.getEstDevolucion());

                preparedStatement.executeUpdate();
                preparedStatement.close();
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    public static Prestamo mostrarPrestamoLibro(String idPrestamo) {
        Prestamo prestamo = null;
        try (Connection connection = MySQLConexion.getConexion()) {
            String sql = "SELECT P.idPrestamo, L.titulo, P.fecPrestamo, P.fecDevolucion, CONCAT(a.nombre, ' ', a.apellido) AS alumno, P.estDevolucion "
                    + "FROM Prestamo P "
                    + "INNER JOIN Libro L ON P.idLibro = L.idLibro "
                    + "WHERE P.idPrestamo = ?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, idPrestamo);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        String titulo = resultSet.getString("titulo");
                        LocalDate fecPrestamo = resultSet.getDate("fecPrestamo").toLocalDate();
                        LocalDate fecDevolucion = resultSet.getDate("fecDevolucion").toLocalDate();
                        String alumno = resultSet.getString("alumno");
                        String estDevolucion = resultSet.getString("estDevolucion");

                        prestamo = new Prestamo(idPrestamo, null, fecPrestamo, fecDevolucion, alumno, estDevolucion, titulo, null);
                    }
                }
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prestamo;
    }


    public static void actualizarPrestamoLibro(Prestamo prestamo) throws Exception {
    	Connection connection = null;
        CallableStatement callableStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "UPDATE Prestamo SET idLibro = ?, fecPrestamo = ?, fecDevolucion = ?, idAlumno = ?, estDevolucion = ? WHERE idPrestamo = ?";
            callableStatement = connection.prepareCall(query);

            callableStatement.setString(1, prestamo.getIdLibro());
            callableStatement.setDate(2, java.sql.Date.valueOf(prestamo.getFecPrestamo()));
            callableStatement.setDate(3, java.sql.Date.valueOf(prestamo.getFecDevolucion()));
            callableStatement.setString(4, prestamo.getIdAlumno());
            callableStatement.setString(5, prestamo.getEstDevolucion());
            callableStatement.setString(6, prestamo.getIdPrestamo());

            callableStatement.executeUpdate();
            callableStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void eliminarPrestamoLibro(String idPrestamo) {
    	Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = MySQLConexion.getConexion();
            String query = "DELETE FROM Prestamo WHERE idPrestamo = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, idPrestamo);

            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
