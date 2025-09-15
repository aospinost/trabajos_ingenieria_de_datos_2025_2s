/* BDL CREATE ALTER-DROP-TRUNCATE-RENAME */

/* CREAR BD */
CREATE DATABASE BDMascotasClase;

/* HABILITAR BD */
USE BDMascotasClase;

/* CREAR TABLA EN BD HABILITADO */
CREATE TABLE Mascosta(
	# Tuve un typo con el nombre de la tabla
    idMascota int PRIMARY KEY AUTO_INCREMENT,
    # con AUTO_INCREMENT la base de datos asigna el dato automaticamente
    # problematico cuando borro un registro (continua de donde quedo)
    nombreMascota varchar(50) NOT NULL,
    raza varchar(25) NOT NULL,
    generoMascota varchar(25) NOT NULL,
    tipoMascota varchar(25) NOT NULL,
    fechaCreacion timestamp default current_timestamp
);

CREATE TABLE Cliente(
    documentoCliente varchar(50) NOT NULL PRIMARY KEY,
    direccion varchar(50) NOT NULL,
    nombreCliente1 varchar(50) NOT NULL,
    nombreCliente2 int NULL, #Lo defini mal como entero
    apellidoCliente1 varchar(50) NOT NULL,
    apellidoCliente2 varchar(50) NOT NULL
);

/* RENOMBRAR */
RENAME TABLE Mascosta to Mascota;

/* DESCRIBE */
DESCRIBE Mascota;

/* ALTERACIONES */
ALTER TABLE Cliente MODIFY COLUMN nombreCliente2 varchar(50) NOT NULL;
# RELACION MASCOTA N - 1 CLIENTE
# Creo la columna de la llave foranea
ALTER TABLE Mascota ADD COLUMN documentoClienteFK varchar(50) NOT NULL;

ALTER TABLE Mascota
# Nombre de la relacion
ADD CONSTRAINT FKClienteMascota
# Declaro la llave como foranea
FOREIGN KEY (documentoClienteFK)
# Me tomo el valor de documentoCliente
REFERENCES Cliente(documentoCliente);

/* DROP BD */
#DROP DATABASE BDMascotasClase;