package entities;

import java.time.LocalDate;

public class Prestamo {
	public String idPrestamo;
	public String titulo;
    public LocalDate fecPrestamo;
    public LocalDate fecDevolucion;
	public String idAlumno;
	public String estDevolucion;
	
	public Prestamo(String idPrestamo, String titulo, LocalDate fecPrestamo, LocalDate fecDevolucion, String idAlumno,
			String estDevolucion) {
		super();
		this.idPrestamo = idPrestamo;
		this.titulo = titulo;
		this.fecPrestamo = fecPrestamo;
		this.fecDevolucion = fecDevolucion;
		this.idAlumno = idAlumno;
		this.estDevolucion = estDevolucion;
	}

	public Prestamo() {
		super();
	}

	public String getIdPrestamo() {
		return idPrestamo;
	}

	public void setIdPrestamo(String idPrestamo) {
		this.idPrestamo = idPrestamo;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public LocalDate getFecPrestamo() {
		return fecPrestamo;
	}

	public void setFecPrestamo(LocalDate fecPrestamo) {
		this.fecPrestamo = fecPrestamo;
	}

	public LocalDate getFecDevolucion() {
		return fecDevolucion;
	}

	public void setFecDevolucion(LocalDate fecDevolucion) {
		this.fecDevolucion = fecDevolucion;
	}

	public String getIdAlumno() {
		return idAlumno;
	}

	public void setIdAlumno(String idAlumno) {
		this.idAlumno = idAlumno;
	}

	public String getEstDevolucion() {
		return estDevolucion;
	}

	public void setEstDevolucion(String estDevolucion) {
		this.estDevolucion = estDevolucion;
	}
	
	
	
}
