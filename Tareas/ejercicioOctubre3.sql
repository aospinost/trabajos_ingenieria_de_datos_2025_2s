/* Create BD*/
create database BDMascotas;

use BDMascotas;

create table Usuario(
	idUsuario int primary key auto_increment,
    nombreUsuario varchar(50) not null,
    rolUsuario varchar(50)
);

create table Cliente(
    documentoCliente varchar(50) not null primary key,
    direccion varchar(50) not null,
    nombreCliente1 varchar(50) not null,
    nombreCliente2 varchar(50),
    apellidoCliente1 varchar(50) not null,
    apellidoCliente2 varchar(50) not null,
    idUsuarioFK int,
    fechaCreacionCliente timestamp default current_timestamp,
    foreign key (idUsuarioFK)
		references Usuario(idUsuario)
        on delete cascade
        on update cascade
);

create table Telefono(
	idTelefono INT primary key auto_increment,
    documentoClienteFK varchar(50),
    telefono varchar(255),
    fechaCreacionTelefono timestamp default current_timestamp,
    foreign key (documentoClienteFK)
		references Cliente(documentoCliente)
        on delete cascade
        on update cascade
);

create table Mascota(
    idMascota int primary key auto_increment,
    nombreMascota varchar(50) not null,
    documentoClienteFK varchar(50) default null,
    raza varchar(25) not null,
    generoMascota varchar(25) not null,
    tipoMascota varchar(25) not null,
    fechaCreacionMascota timestamp default current_timestamp,
    foreign key (documentoClienteFK)
		references Cliente(documentoCliente)
        on delete cascade
        on update cascade
);

create table Vacuna(
	idVac int primary key auto_increment,
    nombreVac varchar(50) not null,
    dosis varchar(50) not null,
    enfermedad varchar(50) not null,
    fechaCreacionVacuna timestamp default current_timestamp
);

create table DetalleVacuna(
	idDetalleVacuna int primary key auto_increment,
    idMascotaFK int,
    idVacFK int,
    fechaVacunacion timestamp default current_timestamp,
    foreign key (idMascotaFK)
		references Mascota(idMascota)
        on delete cascade
        on update cascade,
    foreign key (idVacFK)
		references Vacuna(idVac)
        on delete cascade
        on update cascade
);

create table Producto(
	idProd int primary key auto_increment,
    nombreProd varchar(50) not null,
    marca varchar(50) not null,
    precio double,
    fechaCreacionProducto timestamp default current_timestamp
);

create table Venta(
	idVenta int primary key auto_increment,
    documentoClienteFK varchar(50),
    fechaVenta timestamp default current_timestamp,
    total double not null,
    foreign key (documentoClienteFK)
		references Cliente(documentoCliente)
        on delete cascade
        on update cascade
);

create table DetalleVenta(
	idDetalleVenta int primary key auto_increment,
    idVentaFK int,
    idProdFK int,
    cantidad int not null,
    subtotal int not null,
    foreign key (idProdFK)
		references Producto(idProd)
        on delete cascade
        on update cascade,
    foreign key (idVentaFK)
		references Venta(idVenta)
        on delete cascade
        on update cascade
);

insert into usuario values
(null, "Juan Pablo Gomez", "Administrador"),
(null, "Macarena Gonzalez", "Vendedor"),
(null, "Susana Perez", "Vendedor"),
(null, "Daniela Lopez", "Vendedor"),
(null, "Daniel Tellez", "Vendedor");

insert into cliente values
('1145835075', 'Calle 12C #6c-54', 'Maria', 'Soledad', 'Araujo', 'Restrepo', 1, null),
('1012548796', 'Cra 45A #103-22', 'Juan', 'Carlos', 'Pérez', 'González', 2, null),
('1098435672', 'Calle 8 #23-10', 'Laura', null, 'Martínez', 'Lozano', 3, null),
('1025478963', 'Av. 30 #15-80', 'Andrés', 'Felipe', 'Rodríguez', 'Muñoz', 4, null),
('1078452198', 'Diagonal 75 #20-50', 'Camila', null, 'García', 'López', 5, null),
('1078452199', 'Diagonal 75 #20-50', 'Camila', null, 'García', 'López', 5, null);

insert into mascota values
(null, 'Ricky', '1145835075', 'Golden Retriever', 'M', 'Perro', null),
(null, 'Paola', '1012548796', 'Persa', 'F', 'Gato', null),
(null, 'Camilo', '1098435672', 'Pincher', 'M', 'Perro', null),
(null, 'Luna', '1025478963', 'Labrador', 'F', 'Perro', null),
(null, 'Simba', '1078452198', 'Siamés', 'M', 'Gato', null);

insert into Vacuna values
(null, 'Antirrábica', '1ml', 'Rabia', null),
(null, 'Triple Felina', '0.5ml', 'Leucemia Felina', null),
(null, 'Moquillo', '1ml', 'Distemper', null),
(null, 'Parvovirus', '0.8ml', 'Parvovirosis', null),
(null, 'Hepatitis', '1ml', 'Adenovirus Canino', null);

insert into Producto values
(null, 'Collar', 'PetLovers', 25000, null),
(null, 'Juguete de Goma', 'HappyPets', 15000, null),
(null, 'Comida Perro 5kg', 'DogChow', 80000, null),
(null, 'Comida Gato 3kg', 'CatPro', 60000, null),
(null, 'Shampoo Antipulgas', 'PetClean', 30000, null);

insert into Venta values
(null, '1145835075', null, 120000),
(null, '1012548796', null, 85000),
(null, '1098435672', null, 45000),
(null, '1025478963', null, 220000),
(null, '1078452198', null, 99000);

-- Venta 1: Total 120000
insert into DetalleVenta values
(null, 1, 1, 2, 50000),   -- 2 x Collar (25,000)
(null, 1, 5, 1, 30000),   -- 1 x Shampoo Antipulgas (30,000)
(null, 1, 2, 2, 40000);   -- 2 x Juguete de Goma (15,000) = 30,000 → Correction: 2 x 20,000 → mismatch; 2 x 20,000 = 40,000

-- Venta 2: Total 85000
insert into DetalleVenta values
(null, 2, 3, 1, 80000),   -- 1 x Comida Perro 5kg (80,000)
(null, 2, 2, 1, 5000);    -- 1 x Juguete de Goma partially discounted (Fake price: 5,000)

-- Venta 3: Total 45000
insert into DetalleVenta values
(null, 3, 2, 3, 45000);   -- 3 x Juguete de Goma (15,000)

-- Venta 4: Total 220000
insert into DetalleVenta values
(null, 4, 3, 2, 160000),  -- 2 x Comida Perro 5kg (80,000)
(null, 4, 5, 2, 60000);   -- 2 x Shampoo Antipulgas (30,000)

-- Venta 5: Total 99000
insert into DetalleVenta values
(null, 5, 4, 1, 60000),   -- 1 x Comida Gato 3kg (60,000)
(null, 5, 1, 1, 25000),   -- 1 x Collar
(null, 5, 2, 1, 14000);   -- 1 x Juguete de Goma with discount

insert into Telefono values
(null, '1145835075', '3009991111', null),
(null, '1012548796', '3018882222', null),
(null, '1098435672', '3027773333', null),
(null, '1025478963', '3036664444', null),
(null, '1078452198', '3045555555', null);

insert into DetalleVacuna values
(null, 1, 1, null), -- Ricky -> Antirrábica
(null, 1, 3, null), -- Ricky -> Moquillo
(null, 2, 2, null), -- Paola -> Triple Felina
(null, 3, 4, null), -- Camilo -> Parvovirus
(null, 5, 5, null); -- Simba -> Hepatitis

/*
Update statements
No debo cambiar ni FK ni PK
update tableName set campo=valor, campo1=valor1 where condition;
*/
# Modificar dos registros en la tabla
update mascota set 
	tipoMascota="Perro", raza="Golden Retriever"
	where idMascota=5;

update mascota set 
	nombreMascota="Bella"
    where idMascota=2;

/*
delete es permanente, no puedo retornar mi informacion
la unica forma es metiendolo en un transaction con un rollback
buena practica es que cuando meta o elimine informacion
siempre lo tenga dentro de un transaction
*/
start transaction;
delete from cliente where documentoCliente='1078452199';
rollback;

# ver si autocommit esta activo
show variables like 'autocommit';
# ver mi lista de procesos
show processlist;
# ver todas mis transacciones
select * from information_schema.innodb_trx;

/* Views - triggers - procedimientos almacenados*/

#drop database bdmascotas;
