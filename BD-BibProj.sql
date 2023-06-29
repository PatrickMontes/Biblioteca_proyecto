CREATE DATABASE biblioteca_project CHARACTER SET utf8 COLLATE utf8_general_ci;
USE Biblioteca_Project;

CREATE TABLE Editorial (
  idEditorial char(5) PRIMARY KEY,
  nombre varchar(60),
  direccion varchar(100),
  telefono varchar(12),
  email varchar(100),
  ruc varchar(15)
);
/*select * from editorial;
UPDATE editorial
SET nombre = 'Editorial DEF'
WHERE idEditorial = 'EDI03';*/


CREATE TABLE Alumno (
  idAlumno char(5) PRIMARY KEY,
  nombre varchar(100),
  apellido varchar(100),
  direccion varchar(100),
  telefono varchar(12),
  email varchar(100)
);
/*select * from alumno;*/

CREATE TABLE Empleado (
  idEmpleado char(5) PRIMARY KEY,
  nombre varchar(100),
  apellido varchar(100),
  direccion varchar(100),
  telefono varchar(12),
  email varchar(100),
  dni varchar(8),
  clave varchar(15)
);

CREATE TABLE Libro (
  idLibro char(5) PRIMARY KEY,
  titulo varchar(50),
  autor varchar(100),
  idEditorial char(5),
  stock int,
  estado varchar(10) not null check(estado in('Disponible', 'Agotado')),
  foreign key (idEditorial) REFERENCES Editorial(idEditorial)
);

CREATE TABLE Prestamo (
  idPrestamo char(5) PRIMARY KEY,
  idLibro char(5),
  fecPrestamo date,
  fecDevolucion date,
  idAlumno char(5),
  estDevolucion varchar(10) NOT NULL CHECK (estDevolucion IN ('Prestado', 'Devuelto')),
  foreign key (idAlumno) REFERENCES Alumno(idAlumno),
  foreign key (idLibro) REFERENCES Libro(idLibro)
);

CREATE TABLE DetallePrestamo (
  idPrestamo char(5),
  idEmpleado char(5),
  idLibro char(5),
  FOREIGN KEY (idPrestamo) REFERENCES Prestamo(idPrestamo),
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
  FOREIGN KEY (idLibro) REFERENCES Libro(idLibro)
);

CREATE TABLE CompraLibro (
  idCompra char(5) PRIMARY KEY,
  idLibro char(5),
  idEditorial char(5),
  idEmpleado char(5),
  fecCompra date,
  precio decimal(10,2),
  cantidad int,
  FOREIGN KEY (idLibro) REFERENCES Libro(idLibro),
  FOREIGN KEY (idEditorial) REFERENCES Editorial(idEditorial),
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
);

DELIMITER //
CREATE PROCEDURE SP_MostrarLibros()
BEGIN
    SELECT l.idLibro, l.titulo, l.autor, e.nombre AS editorial, l.stock, l.estado
    FROM Libro l
    INNER JOIN Editorial e ON l.idEditorial = e.idEditorial
    order by l.idLibro;
END //
DELIMITER ;

call sp_mostrarlibros();

DELIMITER //
CREATE PROCEDURE ObtenerDetallesCompra()
BEGIN
    SELECT CL.idCompra, L.titulo, ED.nombre AS editorial, CONCAT(E.nombre, ' ', E.apellido) AS empleado, CL.fecCompra, CL.precio, CL.cantidad
    FROM CompraLibro CL
    INNER JOIN Libro L ON CL.idLibro = L.idLibro
    INNER JOIN Editorial ED ON CL.idEditorial = ED.idEditorial
    INNER JOIN Empleado E ON CL.idEmpleado = E.idEmpleado;
END //

DELIMITER //
CREATE PROCEDURE actualizarCompraLibro (
    IN p_idLibro CHAR(5),
    IN p_idEditorial CHAR(5),
    IN p_idEmpleado CHAR(5),
    IN p_fecCompra DATE,
    IN p_precio DECIMAL(10,2),
    IN p_cantidad INT,
    IN p_idCompra CHAR(5)
)
BEGIN
    UPDATE CompraLibro
    SET idLibro = p_idLibro,
        idEditorial = p_idEditorial,
        idEmpleado = p_idEmpleado,
        fecCompra = p_fecCompra,
        precio = p_precio,
        cantidad = p_cantidad
    WHERE idCompra = p_idCompra;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarPrestamos()
BEGIN
    SELECT p.idPrestamo, l.titulo, p.fecPrestamo, p.fecDevolucion, CONCAT(a.nombre, ' ', a.apellido) AS alumno, p.estDevolucion
    FROM Prestamo p
    INNER JOIN Libro l ON p.idLibro = l.idLibro
    INNER JOIN Alumno a ON p.idAlumno = a.idAlumno;
END //

INSERT INTO Editorial (idEditorial, nombre, direccion, telefono, email, ruc)
VALUES 	('EDI01', 'Editorial ABC', 'Calle Principal 123', '123456789', 'info@editorialabc.com', '12345678901'),
		('EDI02', 'Editorial XYZ', 'Calle Principal 456', '987654321', 'info@editorialxyz.com', '98765432109'),
        ('EDI03', 'Editorial DEF', 'Calle Principal 789', '555555555', 'info@editorialxyz.com', '12345678903');

INSERT INTO Alumno (idAlumno, nombre, apellido, direccion, telefono, email)
VALUES 	('ALU01', 'Juan', 'Pérez', 'Calle Secundaria 456', '987654321', 'juanperez@gmail.com'),
		('ALU02', 'Ana', 'González', 'Avenida Secundaria 789', '567891234', 'anagonzalez@gmail.com'),
		('ALU03', 'Luis', 'Hernández', 'Avenida Secundaria 123', '444444444', 'luishernandez@gmail.com');

INSERT INTO Empleado (idEmpleado, nombre, apellido, direccion, telefono, email, dni, clave)
VALUES 	('EMP01', 'María', 'López', 'Avenida Central 789', '567891234', 'marialopez@gmail.com', '12345678', 'secreto123'),
		('EMP02', 'Pedro', 'Ramírez', 'Calle Central 123', '123456789', 'pedroramirez@gmail.com', '87654321', 'secreto456'),
        ('EMP03', 'Marcela', 'Torres', 'Calle Central 456', '666666666', 'marcelatorres@gmail.com', '98765432', 'secreto789');

INSERT INTO Libro (idLibro, titulo, autor, idEditorial, stock, estado)
VALUES 	('LIB01', 'El Gran Gatsby', 'F. Scott Fitzgerald', 'EDI01', 10, 'Disponible'),
		('LIB02', 'Cien años de soledad', 'Gabriel García Márquez', 'EDI02', 5, 'Disponible'),
        ('LIB03', '1984', 'George Orwell', 'EDI03', 8, 'Disponible');

INSERT INTO Prestamo (idPrestamo, idLibro, fecPrestamo, fecDevolucion, idAlumno, estDevolucion)
VALUES 	('PRE01', 'LIB01', '2023-05-01', '2023-05-08', 'ALU01', 'Devuelto'),
		('PRE02', 'LIB02', '2023-06-01', '2023-06-08', 'ALU02', 'Prestado'),
        ('PRE03', 'LIB03', '2023-06-05', '2023-06-12', 'ALU03', 'Prestado');

INSERT INTO DetallePrestamo (idPrestamo, idEmpleado, idLibro)
VALUES 	('PRE01', 'EMP01', 'LIB01'),
		('PRE02', 'EMP02', 'LIB02'),
        ('PRE03', 'EMP03', 'LIB03');

INSERT INTO CompraLibro (idCompra, idLibro, idEditorial, idEmpleado, fecCompra, precio, cantidad)
VALUES 	('COM01', 'LIB01', 'EDI01', 'EMP01', '2023-05-15', 25.50, 5),
		('COM02', 'LIB02', 'EDI02', 'EMP02', '2023-05-20', 30.00, 3),
		('COM03', 'LIB03', 'EDI03', 'EMP03', '2023-05-25', 20.50, 4);