package entities;

public class Editorial {
	private String idEditorial;
	private String nombre;
	private String direccion;
	private String telefono;
	private String email;
	private String ruc;

	// Constructor
	public Editorial(String idEditorial, String nombre, String direccion, String telefono, String email, String ruc) {
		this.idEditorial = idEditorial;
		this.nombre = nombre;
		this.direccion = direccion;
		this.telefono = telefono;
		this.email = email;
		this.ruc = ruc;
	}

	// Getters and Setters
	public String getIdEditorial() {
		return idEditorial;
	}

	public void setIdEditorial(String idEditorial) {
		this.idEditorial = idEditorial;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRuc() {
		return ruc;
	}

	public void setRuc(String ruc) {
		this.ruc = ruc;
	}
}