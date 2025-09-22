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
('1145835075', 'Calle 12C #6c-54', 'Maria', 'Soledad', 'Araujo', 'Restrepo', 1),
('1012548796', 'Cra 45A #103-22', 'Juan', 'Carlos', 'Pérez', 'González', 2),
('1098435672', 'Calle 8 #23-10', 'Laura', NULL, 'Martínez', 'Lozano', 3),
('1025478963', 'Av. 30 #15-80', 'Andrés', 'Felipe', 'Rodríguez', 'Muñoz', 4),
('1078452198', 'Diagonal 75 #20-50', 'Camila', NULL, 'García', 'López', 5),
('1004598712', 'Transversal 28 #9-45', 'Santiago', NULL, 'Morales', 'Ríos', 1),
('1098745263', 'Calle 13B #77-21', 'Ana', 'Lucía', 'Hernández', 'Ortiz', 2),
('1047856231', 'Cra 7 #42-99', 'Miguel', 'Ángel', 'Torres', 'Ramírez', 3),
('1069321548', 'Av. Esperanza #20-10', 'Daniela', 'Paola', 'Jiménez', 'Castaño', 4),
('1036842195', 'Calle 67 #14-32', 'David', NULL, 'Castro', 'Vargas', 5),
('1057123489', 'Cra 50 #33-18', 'Valentina', NULL, 'Ruiz', 'Salazar', 1),
('1029438751', 'Av. Chile #19-99', 'Felipe', 'Andrés', 'Navarro', 'Delgado', 2),
('1084721369', 'Calle 24 #6-70', 'Juliana', NULL, 'Rojas', 'Arias', 3),
('1015820346', 'Carrera 9 #45-21', 'Sebastián', 'Eduardo', 'Córdoba', 'Mejía', 4),
('1097834256', 'Calle 19 #21-56', 'Catalina', NULL, 'Medina', 'Sánchez', 5),
('1076123458', 'Cra 65 #8A-12', 'Manuel', NULL, 'Silva', 'Montoya', 1),
('1048596237', 'Calle 4 #16-30', 'Isabela', 'María', 'Rivera', 'Pardo', 2),
('1067842135', 'Av. 1 de Mayo #30-10', 'Esteban', NULL, 'Vega', 'Nieto', 3),
('1086593214', 'Transv 60 #70-22', 'Natalia', 'Andrea', 'Peña', 'Forero', 4),
('1056932471', 'Cra 28D #64-80', 'Tomás', NULL, 'Bermúdez', 'Suárez', 5);

/* Insercion larga */
insert into mascota (idMascota, nombreMascota, documentoCliente, raza, generoMascota, tipoMascota, fechaCreacionMascota) 
values (NULL, "Pedro", "1845835075", "Pastor Aleman", "M", "Perro", NULL);

/* Insercion corta múltiple */
insert into mascota values
(NULL, 'Ricky', '1845835075', 'Golden Retriever', 'M', 'Perro', NULL),
(NULL, 'Paola', '1845835075', 'Persa', 'F', 'Gato', NULL),
(NULL, 'Camilo', '1845835075', 'Pincher', 'M', 'Perro', NULL),
(NULL, 'Luna', '1012548796', 'Labrador', 'F', 'Perro', NULL),
(NULL, 'Simba', '1098435672', 'Siamés', 'M', 'Gato', NULL),
(NULL, 'Max', '1025478963', 'Bulldog', 'M', 'Perro', NULL),
(NULL, 'Mía', '1078452198', 'Beagle', 'F', 'Perro', NULL),
(NULL, 'Toby', '1004598712', 'Pastor Alemán', 'M', 'Perro', NULL),
(NULL, 'Nala', '1098745263', 'Angora', 'F', 'Gato', NULL),
(NULL, 'Rocky', '1047856231', 'Dálmata', 'M', 'Perro', NULL),
(NULL, 'Kira', '1069321548', 'Husky Siberiano', 'F', 'Perro', NULL),
(NULL, 'Pelusa', '1036842195', 'Maine Coon', 'F', 'Gato', NULL),
(NULL, 'Coco', '1057123489', 'Chihuahua', 'M', 'Perro', NULL),
(NULL, 'Lola', '1029438751', 'Scottish Fold', 'F', 'Gato', NULL),
(NULL, 'Zeus', '1084721369', 'Boxer', 'M', 'Perro', NULL),
(NULL, 'Sasha', '1015820346', 'Doberman', 'F', 'Perro', NULL),
(NULL, 'Milo', '1097834256', 'Ragdoll', 'M', 'Gato', NULL),
(NULL, 'Greta', '1076123458', 'Pug', 'F', 'Perro', NULL),
(NULL, 'Leo', '1048596237', 'Shih Tzu', 'M', 'Perro', NULL),
(NULL, 'Olivia', '1067842135', 'Bengalí', 'F', 'Gato', NULL),
(NULL, 'Thor', '1086593214', 'Labrador', 'M', 'Perro', NULL),
(NULL, 'Nina', '1056932471', 'Esfinge', 'F', 'Gato', NULL),
(NULL, 'Bruno', '1004598712', 'Gran Danés', 'M', 'Perro', NULL),
(NULL, 'Mandy', '1012548796', 'Samoyedo', 'F', 'Perro', NULL),
(NULL, 'Oscar', '1098435672', 'Persa', 'M', 'Gato', NULL),
(NULL, 'Chispa', '1036842195', 'Pomerania', 'F', 'Perro', NULL),
(NULL, 'Teo', '1078452198', 'Himalayo', 'M', 'Gato', NULL),
(NULL, 'Loki', '1098745263', 'Doberman', 'M', 'Perro', NULL),
(NULL, 'Zara', '1047856231', 'Schnauzer', 'F', 'Perro', NULL),
(NULL, 'Jazz', '1057123489', 'Retriever', 'M', 'Perro', NULL),
(NULL, 'Sol', NULL, 'Persa', 'F', 'Gato', NULL),
(NULL, 'Apolo', NULL, 'Pastor Alemán', 'M', 'Perro', NULL),
(NULL, 'Canela', NULL, 'Labrador', 'F', 'Perro', NULL),
(NULL, 'Tigre', NULL, 'Siberiano', 'M', 'Gato', NULL),
(NULL, 'Negrita', NULL, 'Criolla', 'F', 'Perro', NULL),
(NULL, 'Firu', NULL, 'Pug', 'M', 'Perro', NULL),
(NULL, 'Bombón', NULL, 'Scottish Fold', 'M', 'Gato', NULL),
(NULL, 'Cleo', NULL, 'Siamés', 'F', 'Gato', NULL),
(NULL, 'Daisy', NULL, 'Beagle', 'F', 'Perro', NULL),
(NULL, 'Shadow', NULL, 'Pincher', 'M', 'Perro', NULL);

/* Visualizacion con select */
/* select * from [nombreTabla] */
select * from mascota;

/* Drop BD*/
#DROP DATABASE BDMascotas;
