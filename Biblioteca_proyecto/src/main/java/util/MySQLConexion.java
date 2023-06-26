package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLConexion {
	
	public static Connection getConexion() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/biblioteca_project?useTimezone=true&serverTimezone=UTC";
			String usr = "root";
			String psw = "09504055MM";
			con = DriverManager.getConnection(url, usr, psw);
			System.out.println("Conexión establecida correctamente");
		} catch (ClassNotFoundException ex) {
			System.out.println("No se encontró el controlador JDBC");
		} catch (SQLException ex) {
			System.out.println("Error al conectar con la base de datos");
		}
		return con;
	}

	public static void closeConexion(Connection con) {
		try {
			if (con != null) {
				con.close();
				System.out.println("Conexión cerrada correctamente");
			}
		} catch (SQLException e) {
			System.out.println("Problemas al cerrar la conexión");
		}
	}
}