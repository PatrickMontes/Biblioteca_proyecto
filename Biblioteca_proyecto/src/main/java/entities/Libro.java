package entities;

public class Libro {
	private String idLibro;
	private String titulo;
	private String autor;
	private String idEditorial;
	private int stock;
	private String estado;
	private String editorial;

	public Libro() {

	}

	public Libro(String idLibro, String titulo, String autor, String idEditorial, int stock, String estado,
			String editorial) {
		this.idLibro = idLibro;
		this.titulo = titulo;
		this.autor = autor;
		this.idEditorial = idEditorial;
		this.stock = stock;
		this.estado = estado;
		this.editorial = editorial;
	}

	public Libro(String idLibro, String titulo, String autor, String idEditorial, int stock, String estado) {
		this.idLibro = idLibro;
		this.titulo = titulo;
		this.autor = autor;
		this.idEditorial = idEditorial;
		this.stock = stock;
		this.estado = estado;
	}

	public Libro(String idLibro, String titulo, String autor, int stock, String estado, String editorial) {
		this.idLibro = idLibro;
		this.titulo = titulo;
		this.autor = autor;
		this.stock = stock;
		this.estado = estado;
		this.editorial = editorial;
	}

	// Getters y Setters
	public String getIdLibro() {
		return idLibro;
	}

	public void setIdLibro(String idLibro) {
		this.idLibro = idLibro;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getAutor() {
		return autor;
	}

	public void setAutor(String autor) {
		this.autor = autor;
	}

	public String getIdEditorial() {
		return idEditorial;
	}

	public void setIdEditorial(String idEditorial) {
		this.idEditorial = idEditorial;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getEditorial() {
		return editorial;
	}

	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}

	// Método toString()
	@Override
	public String toString() {
		return "Libro [idLibro=" + idLibro + ", titulo=" + titulo + ", autor=" + autor + ", idEditorial=" + idEditorial
				+ ", stock=" + stock + ", estado=" + estado + ", editorial=" + editorial + "]";
	}
}