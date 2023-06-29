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
             // Verificar si hay suficiente stock disponible
             String verificarStockSql = "SELECT stock FROM libro WHERE idLibro = ?";
             try (PreparedStatement verificarStockStatement = connection.prepareStatement(verificarStockSql)) {
                 verificarStockStatement.setString(1, prestamo.getIdLibro());
                 try (ResultSet resultSet = verificarStockStatement.executeQuery()) {
                     if (resultSet.next()) {
                         int stock = resultSet.getInt("stock");
                         if (stock > 0) {
                             // Disminuir el stock en una unidad
                             int nuevoStock = stock - 1;
                             // Actualizar el stock del libro en la base de datos
                             String actualizarStockSql = "UPDATE libro SET stock = ? WHERE idLibro = ?";
                             try (PreparedStatement actualizarStockStatement = connection.prepareStatement(actualizarStockSql)) {
                                 actualizarStockStatement.setInt(1, nuevoStock);
                                 actualizarStockStatement.setString(2, prestamo.getIdLibro());
                                 actualizarStockStatement.executeUpdate();
                             }
                             // Realizar el préstamo
                             String agregarPrestamoSql = "INSERT INTO Prestamo (idPrestamo, idLibro, fecPrestamo, fecDevolucion, idAlumno, estDevolucion) VALUES (?, ?, ?, ?, ?, ?)";
                             try (PreparedStatement agregarPrestamoStatement = connection.prepareStatement(agregarPrestamoSql)) {
                                 agregarPrestamoStatement.setString(1, prestamo.getIdPrestamo());
                                 agregarPrestamoStatement.setString(2, prestamo.getIdLibro());
                                 agregarPrestamoStatement.setDate(3, java.sql.Date.valueOf(prestamo.getFecPrestamo()));
                                 agregarPrestamoStatement.setDate(4, java.sql.Date.valueOf(prestamo.getFecDevolucion()));
                                 agregarPrestamoStatement.setString(5, prestamo.getIdAlumno());
                                 agregarPrestamoStatement.setString(6, prestamo.getEstDevolucion());
                                 agregarPrestamoStatement.executeUpdate();
                             }
                         } else {
                             // No hay suficiente stock disponible
                             // Manejar la situación de acuerdo a tus necesidades
                         }
                     } else {
                         // El libro no fue encontrado
                         // Manejar la situación de acuerdo a tus necesidades
                     }
                 }
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }
     }
    
   
    
    public static Prestamo mostrarPrestamoLibro(String idPrestamo) {
        Prestamo prestamo = null;
        try (Connection connection = MySQLConexion.getConexion()) {
            String sql = "SELECT P.idPrestamo, L.titulo, P.fecPrestamo, P.fecDevolucion, A.nombre AS alumno, P.estDevolucion "
                    + "FROM Prestamo P "
                    + "INNER JOIN Libro L ON P.idLibro = L.idLibro "
                    + "INNER JOIN Alumno A ON P.idAlumno = A.idAlumno "
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
    	try (Connection connection = MySQLConexion.getConexion()) {
            String query = "UPDATE Prestamo SET idLibro = ?, fecPrestamo = ?, fecDevolucion = ?, idAlumno = ?, estDevolucion = ? WHERE idPrestamo = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, prestamo.getIdLibro());
                preparedStatement.setDate(2, java.sql.Date.valueOf(prestamo.getFecPrestamo()));
                preparedStatement.setDate(3, java.sql.Date.valueOf(prestamo.getFecDevolucion()));
                preparedStatement.setString(4, prestamo.getIdAlumno());
                preparedStatement.setString(5, prestamo.getEstDevolucion());
                preparedStatement.setString(6, prestamo.getIdPrestamo());

                preparedStatement.executeUpdate();
            }

            // Aumentar el stock del libro en una unidad si el estado del préstamo es "Devuelto"
            if (prestamo.getEstDevolucion().equals("Devuelto")) {
                String aumentarStockSql = "UPDATE libro SET stock = stock + 1 WHERE idLibro = ?";
                try (PreparedStatement aumentarStockStatement = connection.prepareStatement(aumentarStockSql)) {
                    aumentarStockStatement.setString(1, prestamo.getIdLibro());
                    aumentarStockStatement.executeUpdate();
                }
            }
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
