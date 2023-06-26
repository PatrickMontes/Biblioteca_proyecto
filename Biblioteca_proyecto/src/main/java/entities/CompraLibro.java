package entities;

import java.math.BigDecimal;
import java.time.LocalDate;

public class CompraLibro {
	 public String idCompra;
	 public String libro;
	 public String editorial;
	 public String empleado;
	 public LocalDate fecCompra;
	 public BigDecimal precio;
	 public int cantidad;
	 
	public CompraLibro() {
		super();
	}

	public CompraLibro(String idCompra, String libro, String editorial, String empleado, LocalDate fecCompra,
			BigDecimal precio, int cantidad) {
		super();
		this.idCompra = idCompra;
		this.libro = libro;
		this.editorial = editorial;
		this.empleado = empleado;
		this.fecCompra = fecCompra;
		this.precio = precio;
		this.cantidad = cantidad;
	}

	public String getIdCompra() {
		return idCompra;
	}

	public void setIdCompra(String idCompra) {
		this.idCompra = idCompra;
	}

	public String getLibro() {
		return libro;
	}

	public void setLibro(String libro) {
		this.libro = libro;
	}

	public String getEditorial() {
		return editorial;
	}

	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}

	public String getEmpleado() {
		return empleado;
	}

	public void setEmpleado(String empleado) {
		this.empleado = empleado;
	}

	public LocalDate getFecCompra() {
		return fecCompra;
	}

	public void setFecCompra(LocalDate fecCompra) {
		this.fecCompra = fecCompra;
	}

	public BigDecimal getPrecio() {
		return precio;
	}

	public void setPrecio(BigDecimal precio) {
		this.precio = precio;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	
	 
	 
}
