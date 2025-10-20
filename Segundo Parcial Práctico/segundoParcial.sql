create database segundoParcial;
use segundoParcial;

CREATE TABLE Departamento (
	id_departamento INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);
CREATE TABLE Empleado (
	id_empleado INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
	cargo VARCHAR(50),
	salario DECIMAL(10,2) CHECK (salario > 0),
	id_departamento INT,
	fecha_ingreso DATE,
	FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Proyecto (
	id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
	fecha_inicio DATE,
	presupuesto DECIMAL(12,2),
	id_departamento INT,
	FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Asignacion (
	id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
	id_empleado INT,
	id_proyecto INT,
	horas_trabajadas INT CHECK (horas_trabajadas >= 0),
	FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
	FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);

/* INSERCIONES DE DATOS */
insert into departamento (nombre, presupuesto) values
('Ventas', 200000000),
('IT', 500000000),
('Marketing', 100000000);

insert into empleado (nombre, cargo, salario, id_departamento, fecha_ingreso) values
('Juan Pablo Rojas Lozano', 'Jefe de Ventas', 8800000, 1, '2015-04-23'),
('Sofia Cuello Castro', 'Jefe de Marketing', 3020000, 3, '2016-02-14'),
('Anieth Almenarez Almeira', 'Jefe de IT', 12000000, 2, '2013-07-27'),
('Veronica Verdecia Ustariz', 'Vendedor', 2200000, 1, '2022-07-12'),
('Wilson Andres Ochoa Manjarres', 'Desarrollador', 3500000, 2, '2021-09-03');

insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
('Base de datos Heladeria Tuti Fruti', '2025-05-01', 20000000, 2),
('Desarrollo Carcel el Buen Pastor', '2025-02-01', 30000000, 2),
('Optimizacion Sales Strategy', '2025-07-16', 10000000, 1); 

insert into asignacion (id_empleado, id_proyecto, horas_trabajadas) values
(3, 1, 72),
(5, 1, 144),
(3, 2, 160),
(5, 2, 300),
(4, 3, 48);

# Visualizacion de las tablas
select * from departamento;
select * from empleado;
select * from proyecto;
select * from asignacion;

/*
Reto 11 – Control de fechas
Ningún proyecto puede tener fecha de inicio anterior al 2020.
• Trigger: BEFORE INSERT en Proyecto.
• Procedimiento: ActualizarFechasInvalidas()
• Función: ProyectosInvalidos()
• Transacción: revertir inserciones con fechas no válidas
*/

# Procedimiento: ActualizarFechasInvalidas()
delimiter $$
create procedure ActualizarFechasInvalidas()
begin
    update proyecto set fecha_inicio = '2020-01-01'
		where year(fecha_inicio) < 2020 and id_proyecto > 0;
	/*	Coloco la restriccion id_proyecto > 0 porque de lo contrario,
		modo seguro impide el update si no reviso la llave primario.
        Funciona ya que id_proyecto es auto_increment y siempre sera
        mayor que 1. La otra opcion es deshabilitar modo seguro. */
end $$
delimiter ;

# Pruebas Procedimiento
start transaction;
    insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
	('Este proyecto se inserto con fecha 2019, debera actualizarse', '2019-01-01', 50000000, 2);
	call ActualizarFechasInvalidas();
	select * from proyecto;
rollback;

# Función: ProyectosInvalidos()
delimiter $$
create function ProyectosInvalidos()
returns int
deterministic
begin
	declare cantidadProyectosInvalidos int;
    select count(*) into cantidadProyectosInvalidos from proyecto
		where year(fecha_inicio) < 2020 and id_proyecto > 0;
    
    return cantidadProyectosInvalidos;
end $$
delimiter ;

# Pruebas Función
start transaction;
	select ProyectosInvalidos() as cantidadProyectosInvalidos;
    insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
	('Insertar este proyecto deberia aumentar cantidad de proyectos invalidos en 1', '2019-01-01', 50000000, 2);
    select ProyectosInvalidos() as cantidadProyectosInvalidos;
rollback;

# Transacción: revertir inserciones con fechas no válidas.
delimiter $$
create procedure RevisarUltimaInsercionValida()
begin
    declare i_fecha_inicio date;
    
    select fecha_inicio into i_fecha_inicio from proyecto
		where id_proyecto = (select max(id_proyecto) from proyecto);
    if year(i_fecha_inicio) < 2020 then
        rollback;
    end if;
end $$
delimiter ;

# Pruebas Transacción

start transaction;
insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
('Yo debo ser insertado', '2024-03-01', 25000000, 2);
call RevisarUltimaInsercionValida();
select * from proyecto;
rollback; # Coloco el rollback para limpiarlo para la proxima insercion

start transaction;
insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
('Yo no debo ser insertado', '2014-03-01', 25000000, 2);
call RevisarUltimaInsercionValida();
select * from proyecto;

# Trigger: BEFORE INSERT en Proyecto.
delimiter $$
create trigger verificarFechaInsertarProyecto
before insert on proyecto
for each row
begin
    if year(new.fecha_inicio) < 2020 then
        signal sqlstate '45000'
        set message_text = 'No se puede insertar un proyecto iniciado antes del 2020.';
    end if;
end $$
delimiter ;

# Pruebas Trigger
start transaction;
	insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
	('Este proyecto no debe ser insertado', '2019-01-01', 50000000, 2);
rollback;
start transaction;
	insert into proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
	('Este proyecto si debe ser insertado', '2021-01-01', 50000000, 2);
	select * from proyecto;
rollback;