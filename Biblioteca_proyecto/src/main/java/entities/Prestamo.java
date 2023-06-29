package entities;

import java.time.LocalDate;

public class Prestamo {
	public String idPrestamo;
	public String idLibro;
    public LocalDate fecPrestamo;
    public LocalDate fecDevolucion;
	public String idAlumno;
	public String estDevolucion;
	public String libro;
	public String alumno;
	
	public Prestamo() {
		super();
	}

	public Prestamo(String idPrestamo, String idLibro, LocalDate fecPrestamo, LocalDate fecDevolucion, String idAlumno,
			String estDevolucion, String libro, String alumno) {
		super();
		this.idPrestamo = idPrestamo;
		this.idLibro = idLibro;
		this.fecPrestamo = fecPrestamo;
		this.fecDevolucion = fecDevolucion;
		this.idAlumno = idAlumno;
		this.estDevolucion = estDevolucion;
		this.libro = libro;
		this.alumno = alumno;
	}

	public Prestamo(String idPrestamo, String idLibro, LocalDate fecPrestamo, LocalDate fecDevolucion, String idAlumno,
			String estDevolucion) {
		super();
		this.idPrestamo = idPrestamo;
		this.idLibro = idLibro;
		this.fecPrestamo = fecPrestamo;
		this.fecDevolucion = fecDevolucion;
		this.idAlumno = idAlumno;
		this.estDevolucion = estDevolucion;
	}

	public Prestamo(String idPrestamo, LocalDate fecPrestamo, LocalDate fecDevolucion, String estDevolucion,
			String libro, String alumno) {
		super();
		this.idPrestamo = idPrestamo;
		this.fecPrestamo = fecPrestamo;
		this.fecDevolucion = fecDevolucion;
		this.estDevolucion = estDevolucion;
		this.libro = libro;
		this.alumno = alumno;
	}

	public String getIdPrestamo() {
		return idPrestamo;
	}

	public void setIdPrestamo(String idPrestamo) {
		this.idPrestamo = idPrestamo;
	}

	public String getIdLibro() {
		return idLibro;
	}

	public void setIdLibro(String idLibro) {
		this.idLibro = idLibro;
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

	public String getLibro() {
		return libro;
	}

	public void setLibro(String libro) {
		this.libro = libro;
	}

	public String getAlumno() {
		return alumno;
	}

	public void setAlumno(String alumno) {
		this.alumno = alumno;
	}
	
	
}