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

insert into mascota values
(NULL, 'Ricky', '1145835075', 'Golden Retriever', 'M', 'Perro', NULL),
(NULL, 'Paola', '1012548796', 'Persa', 'F', 'Gato', NULL),
(NULL, 'Camilo', '1098435672', 'Pincher', 'M', 'Perro', NULL),
(NULL, 'Luna', '1025478963', 'Labrador', 'F', 'Perro', NULL),
(NULL, 'Simba', '1078452198', 'Siamés', 'M', 'Gato', NULL);

insert into Vacuna values
(NULL, 'Antirrábica', '1ml', 'Rabia', NULL),
(NULL, 'Triple Felina', '0.5ml', 'Leucemia Felina', NULL),
(NULL, 'Moquillo', '1ml', 'Distemper', NULL),
(NULL, 'Parvovirus', '0.8ml', 'Parvovirosis', NULL),
(NULL, 'Hepatitis', '1ml', 'Adenovirus Canino', NULL);

insert into Producto values
(NULL, 'Collar', 'PetLovers', 25000, NULL),
(NULL, 'Juguete de Goma', 'HappyPets', 15000, NULL),
(NULL, 'Comida Perro 5kg', 'DogChow', 80000, NULL),
(NULL, 'Comida Gato 3kg', 'CatPro', 60000, NULL),
(NULL, 'Shampoo Antipulgas', 'PetClean', 30000, NULL);

INSERT INTO Venta VALUES
(NULL, '1145835075', NULL, 120000),
(NULL, '1012548796', NULL, 85000),
(NULL, '1098435672', NULL, 45000),
(NULL, '1025478963', NULL, 220000),
(NULL, '1078452198', NULL, 99000);

-- Venta 1: Total 120000
INSERT INTO DetalleVenta VALUES
(NULL, 1, 1, 2, 50000),   -- 2 x Collar (25,000)
(NULL, 1, 5, 1, 30000),   -- 1 x Shampoo Antipulgas (30,000)
(NULL, 1, 2, 2, 40000);   -- 2 x Juguete de Goma (15,000) = 30,000 → Correction: 2 x 20,000 → mismatch; 2 x 20,000 = 40,000

-- Venta 2: Total 85000
INSERT INTO DetalleVenta VALUES
(NULL, 2, 3, 1, 80000),   -- 1 x Comida Perro 5kg (80,000)
(NULL, 2, 2, 1, 5000);    -- 1 x Juguete de Goma partially discounted (Fake price: 5,000)

-- Venta 3: Total 45000
INSERT INTO DetalleVenta VALUES
(NULL, 3, 2, 3, 45000);   -- 3 x Juguete de Goma (15,000)

-- Venta 4: Total 220000
INSERT INTO DetalleVenta VALUES
(NULL, 4, 3, 2, 160000),  -- 2 x Comida Perro 5kg (80,000)
(NULL, 4, 5, 2, 60000);   -- 2 x Shampoo Antipulgas (30,000)

-- Venta 5: Total 99000
INSERT INTO DetalleVenta VALUES
(NULL, 5, 4, 1, 60000),   -- 1 x Comida Gato 3kg (60,000)
(NULL, 5, 1, 1, 25000),   -- 1 x Collar
(NULL, 5, 2, 1, 14000);   -- 1 x Juguete de Goma with discount

describe producto;
select * from detalleVenta;

INSERT INTO Telefono VALUES
(NULL, '1145835075', '3009991111', NULL),
(NULL, '1012548796', '3018882222', NULL),
(NULL, '1098435672', '3027773333', NULL),
(NULL, '1025478963', '3036664444', NULL),
(NULL, '1078452198', '3045555555', NULL);

INSERT INTO DetalleVacuna VALUES
(NULL, 1, 1, NULL), -- Ricky -> Antirrábica
(NULL, 1, 3, NULL), -- Ricky -> Moquillo
(NULL, 2, 2, NULL), -- Paola -> Triple Felina
(NULL, 3, 4, NULL), -- Camilo -> Parvovirus
(NULL, 5, 5, NULL); -- Simba -> Hepatitis

/* Consultas específicas */
/* Alias */
SELECT idMascota AS 'Código Mascota', nombreMascota AS 'Nombre Mascota' FROM Mascota;

#Condiciones operadores lógicos and, or, not operadores de copmaración <, >, <=, =>, =, !=, between, like, in

#Clausula de Bd Where
SELECT * FROM Cliente WHERE nombreCliente1 = 'Juan';

#Diferente != <>
SELECT * FROM Cliente WHERE nombreCliente1 != 'Juan';
SELECT * FROM Cliente WHERE nombreCliente1 <> 'Paula Vargas';

#Mayor que
SELECT * FROM Vacuna WHERE idVac < 2;

#Mayor o menor igual
SELECT * FROM Vacuna WHERE idVac >= 2;

#Between and
SELECT * FROM Vacuna WHERE idVac BETWEEN 2 AND 5;

/* Patron LIKE partrones de texto campos varchar, char, texto
	% -> Representa 0, 1 o muchos caracteres
    _ -> Representa un solo caracter
    Empiece por cierto caracter like xxxxx%
    Termine por cierto caracter like %xxxxx
    Contenga ciertos caracteres like %xxxxx%
    Un caracter like x-X
*/

# Me consulta los productos que comienzan por "Comida"
SELECT * FROM Producto WHERE nombreProd LIKE 'Comida%';
# Me consulta los productos que terminan por "pulgas"
SELECT * FROM Mascota WHERE nombreMascota LIKE '%pulgas';

#DROP DATABASE bdmascotas;
