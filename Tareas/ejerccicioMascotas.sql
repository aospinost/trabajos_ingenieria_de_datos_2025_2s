/* Create BD*/
CREATE DATABASE BDMascotas;

USE BDMascotas;

CREATE TABLE Cliente(
	nit VARCHAR(255) NOT NULL,
    direccion VARCHAR(255),
    nombre1 VARCHAR(255),
    nombre2 VARCHAR(255),
    apellido1 VARCHAR(255),
    apellido2 VARCHAR(255),
    PRIMARY KEY (nit)
);

CREATE TABLE Telefono(
	idTelefono INT NOT NULL,
    nit VARCHAR(255),
    telefono VARCHAR(255),
    PRIMARY KEY (idTelefono),
    FOREIGN KEY (nit) REFERENCES Cliente(nit)
);

CREATE TABLE Mascota(
	codigoMasc INT NOT NULL,
    nombreMasc VARCHAR(255),
    raza VARCHAR(255),
    tipoMasc VARCHAR(255),
    genero VARCHAR(255),
    nit VARCHAR(255),
    PRIMARY KEY (codigoMasc),
    FOREIGN KEY (nit) REFERENCES Cliente(nit)
);

CREATE TABLE Vacuna(
	codigoVac INT NOT NULL,
    nombreVac VARCHAR(255),
    dosis VARCHAR(255),
    enfermedad VARCHAR(255),
    PRIMARY KEY (codigoVac)
);

CREATE TABLE VacunaMascota(
	codigoVacunaMascota INT NOT NULL,
    codigoMasc INT,
    codigoVac INT,
    PRIMARY KEY (codigoVacunaMascota),
    FOREIGN KEY (codigoMasc) REFERENCES Mascota(codigoMasc),
    FOREIGN KEY (codigoVac) REFERENCES Vacuna(codigoVac)
);

CREATE TABLE Producto(
	codigoProd INT NOT NULL,
    nombreProd VARCHAR(255),
    marca VARCHAR(255),
    precio INT,
    PRIMARY KEY (codigoProd)
);

CREATE TABLE Venta(
	idVenta INT NOT NULL,
    nit VARCHAR(255),
    fecha DATETIME,
    total INT,
    PRIMARY KEY (idVenta),
    FOREIGN KEY (nit) REFERENCES Cliente(nit)
);

CREATE TABLE DetalleVenta(
	idDetalleVenta INT NOT NULL,
    codigoProd INT,
    cantidad INT,
    subtotal INT,
    PRIMARY KEY (idDetalleVenta),
    FOREIGN KEY (codigoProd) REFERENCES Producto(codigoProd)
);

/* Drop BD*/
#DROP TABLE Telefono;
#DROP TABLE VacunaMascota;
#DROP TABLE Producto;
#DROP TABLE DetalleVenta;
#DROP TABLE Venta;
#DROP TABLE Cliente;
#DROP TABLE Mascota;
#DROP TABLE Vacuna;
#DROP DATABASE BDMascotas;