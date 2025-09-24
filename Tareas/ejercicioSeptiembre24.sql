/* Create BD*/
CREATE DATABASE BDMascotas;

USE BDMascotas;

CREATE TABLE Usuario(
	idUsuario int PRIMARY KEY AUTO_INCREMENT,
    nombreUsuario varchar(50) NOT NULL,
    rolUsuario varchar(50)
);

CREATE TABLE Cliente(
    documentoCliente varchar(50) NOT NULL PRIMARY KEY,
    direccion varchar(50) NOT NULL,
    nombreCliente1 varchar(50) NOT NULL,
    nombreCliente2 varchar(50),
    apellidoCliente1 varchar(50) NOT NULL,
    apellidoCliente2 varchar(50) NOT NULL,
    idUsuario int,
    fechaCreacionCliente timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Telefono(
	idTelefono INT PRIMARY KEY AUTO_INCREMENT,
    documentoCliente varchar(50),
    telefono varchar(255),
    fechaCreacionTelefono timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (documentoCliente) REFERENCES Cliente(documentoCliente)
);

CREATE TABLE Mascota(
    idMascota int PRIMARY KEY AUTO_INCREMENT,
    nombreMascota varchar(50) NOT NULL,
    documentoCliente varchar(50) default NULL,
    raza varchar(25) NOT NULL,
    generoMascota varchar(25) NOT NULL,
    tipoMascota varchar(25) NOT NULL,
    fechaCreacionMascota timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (documentoCliente) REFERENCES Cliente(documentoCliente)
);

CREATE TABLE Vacuna(
	idVac int PRIMARY KEY AUTO_INCREMENT,
    nombreVac varchar(50) NOT NULL,
    dosis varchar(50) NOT NULL,
    enfermedad varchar(50) NOT NULL,
    fechaCreacionVacuna timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE DetalleVacuna(
	idDetalleVacuna int PRIMARY KEY AUTO_INCREMENT,
    idMascota int,
    idVac int,
    fechaVacunacion timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (idMascota) REFERENCES Mascota(idMascota),
    FOREIGN KEY (idVac) REFERENCES Vacuna(idVac)
);

CREATE TABLE Producto(
	idProd int PRIMARY KEY AUTO_INCREMENT,
    nombreProd varchar(50) NOT NULL,
    marca varchar(50) NOT NULL,
    precio double,
    fechaCreacionProducto timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE Venta(
	idVenta int PRIMARY KEY AUTO_INCREMENT,
    documentoCliente varchar(50),
    fechaVenta timestamp default CURRENT_TIMESTAMP,
    total double NOT NULL,
    FOREIGN KEY (documentoCliente) REFERENCES Cliente(documentoCliente)
);

CREATE TABLE DetalleVenta(
	idDetalleVenta int PRIMARY KEY AUTO_INCREMENT,
    idVenta int,
    idProd int,
    cantidad int NOT NULL,
    subtotal int NOT NULL,
    FOREIGN KEY (idProd) REFERENCES Producto(idProd),
    FOREIGN KEY (idVenta) REFERENCES Venta(idVenta)
);

/* Inserción de datos */
/* Forma larga del insert:
insert into [nombreTabla] ([campo1], [campo2], [campo3]) values ([valor1], [valor2], [valor3])
Nota: deben haber tantos valores como campos. Los campos con auto_increment no se envian*/
/* Forma corta del insert:
insert into [nombreTabla] values ([valor1], [valor2], [valor3])
*/

insert into usuario values
(NULL, "Juan Pablo Gomez", "Administrador"),
(NULL, "Macarena Gonzalez", "Vendedor"),
(NULL, "Susana Perez", "Vendedor"),
(NULL, "Daniela Lopez", "Vendedor"),
(NULL, "Daniel Tellez", "Vendedor");

insert into cliente values
('1145835075', 'Calle 12C #6c-54', 'Maria', 'Soledad', 'Araujo', 'Restrepo', 1, NULL),
('1012548796', 'Cra 45A #103-22', 'Juan', 'Carlos', 'Pérez', 'González', 2, NULL),
('1098435672', 'Calle 8 #23-10', 'Laura', NULL, 'Martínez', 'Lozano', 3, NULL),
('1025478963', 'Av. 30 #15-80', 'Andrés', 'Felipe', 'Rodríguez', 'Muñoz', 4, NULL),
('1078452198', 'Diagonal 75 #20-50', 'Camila', NULL, 'García', 'López', 5, NULL);

/* Insercion corta múltiple */
insert into mascota values
(NULL, 'Ricky', '1145835075', 'Golden Retriever', 'M', 'Perro', NULL),
(NULL, 'Paola', '1012548796', 'Persa', 'F', 'Gato', NULL),
(NULL, 'Camilo', '1098435672', 'Pincher', 'M', 'Perro', NULL),
(NULL, 'Luna', '1025478963', 'Labrador', 'F', 'Perro', NULL),
(NULL, 'Simba', '1078452198', 'Siamés', 'M', 'Gato', NULL);

INSERT INTO Vacunas VALUES (1, '1ml', 'Antirrábica', 'Rabia');
INSERT INTO Vacunas VALUES (2, '0.5ml', 'Triple Felina', 'Leucemia Felina');
INSERT INTO Vacunas VALUES (3, '1ml', 'Moquillo', 'Distemper');
INSERT INTO Vacunas VALUES (4, '0.8ml', 'Parvovirus', 'Parvovirosis');
INSERT INTO Vacunas VALUES (5, '1ml', 'Hepatitis', 'Adenovirus Canino');

INSERT INTO Producto VALUES ('P001', 'Collar', 'PetLovers', '25000');
INSERT INTO Producto VALUES ('P002', 'Juguete de Goma', 'HappyPets', '15000');
INSERT INTO Producto VALUES ('P003', 'Comida Perro 5kg', 'DogChow', '80000');
INSERT INTO Producto VALUES ('P004', 'Comida Gato 3kg', 'CatPro', '60000');
INSERT INTO Producto VALUES ('P005', 'Shampoo Antipulgas', 'PetClean', '30000');

INSERT INTO Venta VALUES (1, NULL, 'C001');
INSERT INTO Venta VALUES (2, NULL, 'C002');
INSERT INTO Venta VALUES (3, NULL, 'C003');
INSERT INTO Venta VALUES (4, NULL, 'C004');
INSERT INTO Venta VALUES (5, NULL, 'C005');

INSERT INTO DetalleVenta VALUES (1, 1, 'P001');
INSERT INTO DetalleVenta VALUES (2, 1, 'P003');
INSERT INTO DetalleVenta VALUES (3, 2, 'P002');
INSERT INTO DetalleVenta VALUES (4, 3, 'P004');
INSERT INTO DetalleVenta VALUES (5, 4, 'P005');

INSERT INTO Telefono VALUES (1, '3009991111', 'C001');
INSERT INTO Telefono VALUES (2, '3018882222', 'C002');
INSERT INTO Telefono VALUES (3, '3027773333', 'C003');
INSERT INTO Telefono VALUES (4, '3036664444', 'C004');
INSERT INTO Telefono VALUES (5, '3045555555', 'C005');

INSERT INTO VacunaMascota VALUES (1, 1, 1);
INSERT INTO VacunaMascota VALUES (2, 1, 3);
INSERT INTO VacunaMascota VALUES (3, 2, 2);
INSERT INTO VacunaMascota VALUES (4, 3, 4);
INSERT INTO VacunaMascota VALUES (5, 5, 5);

/* Consultas específicas */
/* Alias */
SELECT idMascota AS 'Código Mascota', nombreMascota AS 'Nombre Mascota' FROM Mascota;

#Condiciones operadores lógicos and, or, not operadores de copmaración <, >, <=, =>, =, !=, between, like, in

#Clausula de Bd Where
SELECT * FROM Cliente WHERE nombreCliente1 = 'Paula Vargas';

#Diferente != <>
SELECT * FROM Cliente WHERE nombreCliente1 != 'Paula Vargas';
SELECT * FROM Cliente WHERE nombreCliente1 <> 'Paula Vargas';

#Mayor que
SELECT * FROM Vacunas WHERE codVacuna < 2;

#Mayor o menor igual
SELECT * FROM Vacunas WHERE codVacuna >= 2;

#Between and
SELECT * FROM Vacunas WHERE codVacuna BETWEEN 2 AND 5;

/* Patron LIKE partrones de texto campos varchar, char, texto
	% -> Representa 0, 1 o muchos caracteres
    _ -> Representa un solo caracter
    Empiece por cierto caracter like xxxxx%
    Termine por cierto caracter like %xxxxx
    Contenga ciertos caracteres like %xxxxx%
    Un caracter like x-X
*/

SELECT * FROM Mascota WHERE nombreMascota LIKE 'In%';
SELECT * FROM Mascota WHERE nombreMascota LIKE 'In%';

#DROP DATABASE bdmascotas;
