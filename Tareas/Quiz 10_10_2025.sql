create database quizAyuda;

use quizAyuda;

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
    idUsuarioFK int,
    fechaCreacionCliente timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuarioFK) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Telefono(
	idTelefono INT PRIMARY KEY AUTO_INCREMENT,
    documentoClienteFK varchar(50),
    telefono varchar(255),
    fechaCreacionTelefono timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (documentoClienteFK) REFERENCES Cliente(documentoCliente)
);

CREATE TABLE Mascota(
    idMascota int PRIMARY KEY AUTO_INCREMENT,
    nombreMascota varchar(50) NOT NULL,
    documentoClienteFK varchar(50) default NULL,
    raza varchar(25) NOT NULL,
    generoMascota varchar(25) NOT NULL,
    tipoMascota varchar(25) NOT NULL,
    fechaCreacionMascota timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (documentoClienteFK) REFERENCES Cliente(documentoCliente)
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
    idMascotaFK int,
    idVacFK int,
    fechaVacunacion timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (idMascotaFK) REFERENCES Mascota(idMascota),
    FOREIGN KEY (idVacFK) REFERENCES Vacuna(idVac)
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
    documentoClienteFK varchar(50),
    fechaVenta timestamp default CURRENT_TIMESTAMP,
    total double NOT NULL,
    FOREIGN KEY (documentoClienteFK) REFERENCES Cliente(documentoCliente)
);

CREATE TABLE DetalleVenta(
	idDetalleVenta int PRIMARY KEY AUTO_INCREMENT,
    idVentaFK int,
    idProdFK int,
    cantidad int NOT NULL,
    subtotal int NOT NULL,
    FOREIGN KEY (idProdFK) REFERENCES Producto(idProd),
    FOREIGN KEY (idVentaFK) REFERENCES Venta(idVenta)
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

## Funciones
/*1. Incluir en la tabla vacuna el campo para la fecha de vigencia
de la vacuna Crear una función para saber si la vacuna esta
vigente o esta vencida*/

alter table vacuna
add column fechaVigencia date;

update Vacuna set fechaVigencia = '2026-05-10' where idVac = 1;
update Vacuna set fechaVigencia = '2024-03-15' where idVac = 2;
update Vacuna set fechaVigencia = '2025-12-01' where idVac = 3;
update Vacuna set fechaVigencia = '2023-08-20' where idVac = 4;
update Vacuna set fechaVigencia = '2027-01-01' where idVac = 5;

DELIMITER $$
create function RevisarVigencia(fechaVigencia date)
returns varchar(20)
deterministic
begin
	declare vigencia varchar(20);
    if fechaVigencia < curdate() then
		set vigencia = 'EXPIRADA';
	else
		set vigencia = 'VIGENTE';
	end if;
    return vigencia;
end $$
DELIMITER ;

select
    idVac,
    nombreVac,
    enfermedad,
    fechaVigencia,
    RevisarVigencia(fechaVigencia) as vigencia
from Vacuna;

/*2. Crear funcion para mostrar el nombre de la mascota,
la raza y el nombre del propietario*/

DELIMITER $$
create function InfoMascota(id int)
returns varchar(255)
deterministic
begin
	declare nombreMascT varchar(50);
    declare razaT varchar(25);
    declare documentoClienteT varchar(50);
    declare nombreCompletoCliente varchar(200);
    declare resultado varchar(1023);
    
    select nombreMascota, raza, documentoClienteFK
		into nombreMascT, razaT, documentoClienteT
		from mascota
		where idMascota = id;
    
    select concat(
		nombreCliente1, ' ',
		ifnull(nombreCliente2, ''), ' ',
		apellidoCliente1, ' ',
		apellidoCliente2)
		into nombreCompletoCliente
		from cliente
		where documentoCliente = documentoClienteT;
	
    set resultado = concat('Nombre mascota: ', nombreMascT, '. Raza: ', razaT, '. Propietario: ', nombreCompletoCliente);
    return resultado;
end $$
DELIMITER ;

select InfoMascota(1);
select InfoMascota(5);

/*3. Trigger que impide que se elimine un cliente si tiene una mascota registrada*/

DELIMITER $$
create trigger validarEliminarCliente
before delete
on Cliente
for each row
begin
	declare numeroDeMascotas int default 0;
    
    select count(*)
		into numeroDeMascotas
		from mascota
		where documentoClienteFK = old.documentoCliente;
    
    if numeroDeMascotas>0 then
		signal sqlstate '45000'
        set message_text = 'Error: el cliente tiene mascotas registradas';
	end if;
end $$
DELIMITER ;

delete from Cliente where documentoCliente = '1098435672';

/*4. Trigger que cuando se elimine un cliente lo guarde en una tabla que se llame clientesEliminados*/

CREATE TABLE ClienteEliminado(
    documentoCliente varchar(50) NOT NULL PRIMARY KEY,
    direccion varchar(50) NOT NULL,
    nombreCliente1 varchar(50) NOT NULL,
    nombreCliente2 varchar(50),
    apellidoCliente1 varchar(50) NOT NULL,
    apellidoCliente2 varchar(50) NOT NULL,
    idUsuarioFK int,
    fechaCreacionCliente timestamp default CURRENT_TIMESTAMP,
    fechaEliminacionCliente timestamp default CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuarioFK) REFERENCES Usuario(idUsuario)
);

DELIMITER $$
create trigger registrarClientesEliminados
after delete
on Cliente
for each row
begin
	insert into ClienteEliminado values(
		old.documentoCliente,
        old.direccion,
        old.nombreCliente1,
        old.nombreCliente2,
        old.apellidoCliente1,
        old.apellidoCliente2,
        old.idUsuarioFK,
        old.fechaCreacionCliente,
        now());
end $$
DELIMITER ;

insert into cliente values
('9999999999', 'Calle Falsa 123', 'Pedro', 'Alfonso', 'Ramírez', 'Torres', 1, null);

delete from cliente where documentoCliente = '9999999999';
select * from clienteEliminado;

/*5. En la tabla cliente van a agregar un campo que se llame fecha de actualizacion y crear un trigger cada vez que se actualice un cliente se actualice automaticamente 
ese campo de fecha */

alter table cliente
add column fechaActualizacion timestamp default current_timestamp;

DELIMITER $$
create trigger actualizacionDatosCliente
before update
on Cliente
for each row
begin
	set new.fechaActualizacion = now();
end $$

update cliente
set direccion = 'Transversal 18C #20-84'
where documentoCliente = '1145835075';

select * from cliente;
