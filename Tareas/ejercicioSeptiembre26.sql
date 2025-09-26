create database rrhhTechcorp;

use rrhhTechcorp;

create table empleado(
	idEmpleado int primary key auto_increment,
    documentoIdentidad varchar(50) unique not null,
    nombreEmpleado1 varchar(50) not null,
    nombreEmpleado2 varchar(50),
    apellidoEmpleado1 varchar(50) not null,
    apellidoEmpleado2 varchar(50) not null,
    cargo varchar(50) not null,
    nombreDepartamento varchar(50) not null,
    salario float not null,
    fechaVinculacion date not null,
    edad int not null
);

insert into empleado values
(NULL, '1002345678', 'Juan', 'Carlos', 'Pérez', 'Sánchez', 'Desarrollador', 'IT', 4500000, '2015-06-12', 30),
(NULL, '1003456789', 'María', NULL, 'Gómez', 'López', 'Ingeniera de Sistemas', 'IT', 5200000, '2018-03-01', 28),
(NULL, '1004567890', 'Andrés', 'Felipe', 'Ramírez', 'Torres', 'Administrador de Redes', 'IT', 4800000, '2016-11-20', 35),
(NULL, '1005678901', 'Laura', NULL, 'Martínez', 'García', 'Analista QA', 'IT', 4300000, '2019-07-15', 27),
(NULL, '1006789012', 'Carlos', 'Eduardo', 'Ruiz', 'Vega', 'DBA', 'IT', 3900000, '2012-02-10', 40),
(NULL, '1007890123', 'Patricia', NULL, 'Rosas', 'Molina', 'Soporte Técnico', 'IT', 3800000, '2020-09-05', 26),
(NULL, '1012345678', 'Diego', 'Andrés', 'Castillo', 'Paredes', 'Ingeniero de Seguridad', 'IT', 4200000, '2011-05-18', 42),
(NULL, '1013456789', 'Valentina', 'Isabel', 'Ortiz', 'Hernández', 'Project Manager', 'IT', 8500000, '2010-10-01', 38),
(NULL, '1014567890', 'Jorge', NULL, 'Vargas', 'Salazar', 'Analista de Datos', 'IT', 3500000, '2017-01-25', 32),
(NULL, '1015678901', 'Sofía', 'Camila', 'Navarro', 'Cruz', 'Ingeniera DevOps', 'IT', 3000000, '2014-08-30', 33),
(NULL, '1016789012', 'Ricardo', NULL, 'Medina', 'Suárez', 'Ejecutivo de Ventas', 'Ventas', 2900000, '2019-04-12', 29),
(NULL, '1017890123', 'Ana', 'Lucía', 'Pineda', 'Ramos', 'Gerente de Ventas', 'Ventas', 3500000, '2009-12-03', 45),
(NULL, '1022345678', 'Fernando', NULL, 'Blanco', 'Castro', 'Account Manager', 'Ventas', 3700000, '2013-06-21', 36),
(NULL, '1023456789', 'Mónica', 'Elena', 'Ruano', 'Delgado', 'Comercial', 'Ventas', 3100000, '2018-11-11', 31),
(NULL, '1024567890', 'Pablo', NULL, 'Herrera', 'Núñez', 'Representante de Ventas', 'Ventas', 3100000, '2021-02-02', 25),
(NULL, '1025678901', 'Camila', 'Mar', 'Soto', 'Benítez', 'Especialista en Pruebas', 'IT', 2500000, '2016-09-14', 29),
(NULL, '1026789012', 'Andrés', NULL, 'Mejía', 'Quintero', 'Arquitecto de Software', 'IT', 3800000, '2008-01-07', 50),
(NULL, '1027890123', 'Isabela', 'Noelia', 'Cervantes', 'Flores', 'Líder de Soporte', 'IT', 3200000, '2012-04-19', 37),
(NULL, '1032345678', 'Gustavo', NULL, 'León', 'Paz', 'Ejecutivo Comercial', 'Ventas', 3000000, '2017-10-23', 34),
(NULL, '1033456789', 'Marcela', 'Adriana', 'Márquez', 'Del Río', 'Head of HR', 'Recursos Humanos', 12000000, '2007-03-29', 47);

# 1. Lista de empleados
select nombreEmpleado1, nombreEmpleado2, apellidoEmpleado1, apellidoEmpleado2, edad, salario from empleado;

# 2. Lista de empleados con sueldo superior a 4MM
select nombreEmpleado1, nombreEmpleado2, apellidoEmpleado1, apellidoEmpleado2, edad, salario from empleado
where salario>=4000000;

# 3. Empleados en Ventas
select nombreEmpleado1, nombreEmpleado2, apellidoEmpleado1, apellidoEmpleado2, edad, salario, nombreDepartamento from empleado
where nombreDepartamento = 'Ventas';

# 4. Lista de empleados con edades entre 30 y 40 años
select nombreEmpleado1, nombreEmpleado2, apellidoEmpleado1, apellidoEmpleado2, edad, salario from empleado
where edad>=30 and edad<=40;

# 5. Lista de empleados contratados después de 2020
select nombreEmpleado1, nombreEmpleado2, apellidoEmpleado1, apellidoEmpleado2, edad, salario, fechaVinculacion from empleado
where year(fechaVinculacion)>2020;

# 6. Empleados por departamento
select nombreDepartamento, count(*) as 'empleadosDepartamento'
from empleado
group by nombreDepartamento;

# 7. Salario promedio
select avg(salario) from empleado;

# 8. Nombres cuyos nombres comienzan con 'A' o 'C'
select nombreEmpleado1, nombreEmpleado2, apellidoEmpleado1, apellidoEmpleado2, edad, salario from empleado
where nombreEmpleado1 like 'A%' or nombreEmpleado1 like 'C%';
