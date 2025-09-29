create database rrhhTechcorp;

use rrhhTechcorp;

create table departamento(
	idDepartamento 		int primary key auto_increment,
    nombreDepartamento 	varchar(50) not null unique
);

create table empleado(
	idEmpleado 			int primary key auto_increment,
    documentoIdentidad 	varchar(50) unique not null,
    nombreEmpleado1 	varchar(50) not null,
    nombreEmpleado2 	varchar(50),
    apellidoEmpleado1 	varchar(50) not null,
    apellidoEmpleado2 	varchar(50) not null,
    cargo 				varchar(50) not null,
    idDepartamentoFK	int,
    salario 			float not null,
    fechaVinculacion 	date not null,
    fechaNacimiento 	date not null,
    fechaActual 		timestamp default current_timestamp,
    foreign key (idDepartamentoFK) references departamento(idDepartamento)
);

insert into departamento values
(NULL, 'IT'),
(NULL, 'Ventas'),
(NULL, 'Recursos Humanos'),
(NULL, 'Marketing'),
(NULL, 'Seguridad');

insert into empleado values
(NULL, '1002345678', 'Juan', 'Carlos', 'Pérez', 'Sánchez', 'Desarrollador', 1, 4500000, '2015-06-12', '1994-06-12', NULL),
(NULL, '1003456789', 'María', NULL, 'Gómez', 'López', 'Ingeniera de Sistemas', 1, 5200000, '2018-03-01', '1997-03-01', NULL),
(NULL, '1004567890', 'Andrés', 'Felipe', 'Ramírez', 'Torres', 'Administrador de Redes', 1, 4800000, '2016-11-20', '1985-11-20', NULL),
(NULL, '1005678901', 'Laura', NULL, 'Martínez', 'García', 'Analista de Calidad', 1, 4300000, '2019-07-15', '1993-07-15', NULL),
(NULL, '1006789012', 'Carlos', 'Eduardo', 'Ruiz', 'Vega', 'Administrador de Bases de Datos', 1, 3900000, '2012-02-10', '1981-02-10', NULL),
(NULL, '1007890123', 'Patricia', NULL, 'Rosas', 'Molina', 'Técnico de Soporte', 1, 3800000, '2020-09-05', '1994-09-05', NULL),
(NULL, '1013456789', 'Valentina', 'Isabel', 'Ortiz', 'Hernández', 'Líder de Proyecto', 1, 8500000, '2010-10-01', '1987-10-01', NULL),
(NULL, '1014567890', 'Jorge', NULL, 'Vargas', 'Salazar', 'Analista de Datos', 1, 3500000, '2017-01-25', '1988-01-25', NULL),
(NULL, '1015678901', 'Sofía', 'Camila', 'Navarro', 'Cruz', 'Ingeniera DevOps', 1, 3000000, '2014-08-30', '1992-08-30', NULL),
(NULL, '1025678901', 'Camila', 'Mar', 'Soto', 'Benítez', 'Especialista en Pruebas', 1, 2500000, '2016-09-14', '1996-09-14', NULL),
(NULL, '1026789012', 'Andrés', NULL, 'Mejía', 'Quintero', 'Arquitecto de Software', 1, 3800000, '2008-01-07', '1975-01-07', NULL),
(NULL, '1027890123', 'Isabela', 'Noelia', 'Cervantes', 'Flores', 'Jefe de Soporte', 1, 3200000, '2012-04-19', '1988-04-19', NULL),
(NULL, '1016789012', 'Ricardo', NULL, 'Medina', 'Suárez', 'Ejecutivo de Ventas', 2, 2900000, '2019-04-12', '1996-04-12', NULL),
(NULL, '1017890123', 'Ana', 'Lucía', 'Pineda', 'Ramos', 'Gerente de Ventas', 2, 3500000, '2009-12-03', '1979-12-03', NULL),
(NULL, '1022345678', 'Fernando', NULL, 'Blanco', 'Castro', 'Ejecutivo de Cuenta', 2, 3700000, '2013-06-21', '1984-06-21', NULL),
(NULL, '1023456789', 'Mónica', 'Elena', 'Ruano', 'Delgado', 'Asesora Comercial', 2, 3100000, '2018-11-11', '1994-11-11', NULL),
(NULL, '1024567890', 'Pablo', NULL, 'Herrera', 'Núñez', 'Representante de Ventas', 2, 3100000, '2021-02-02', '1996-02-02', NULL),
(NULL, '1032345678', 'Gustavo', NULL, 'León', 'Paz', 'Ejecutivo Comercial', 2, 3000000, '2017-10-23', '1991-10-23', NULL),
(NULL, '1033456789', 'Marcela', 'Adriana', 'Márquez', 'Del Río', 'Directora de Recursos Humanos', 3, 12000000, '2007-03-29', '1978-03-29', NULL),
(NULL, '1012345678', 'Diego', 'Andrés', 'Castillo', 'Paredes', 'Vigilante', 5, 1600000, '2011-05-18', '1979-05-18', NULL),
(NULL, '1034567890', 'Pedro', NULL, 'González', 'Jiménez', 'Especialista en Marketing', 4, 1600000, '2022-07-01', '1995-07-01', NULL),
(NULL, '1035678901', 'Lina', 'María', 'Ramírez', 'Díaz', 'Gestora de Redes Sociales', 4, 1550000, '2023-02-15', '1994-02-15', NULL);

# 1. Lista de empleados
select 	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado;

# 2. Lista de empleados con sueldo superior a 4MM
select 	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado
        where salario>=4000000;

# 3. Empleados en Ventas
select 	e.nombreEmpleado1,
		e.nombreEmpleado2,
        e.apellidoEmpleado1,
        e.apellidoEmpleado2,
        year(e.fechaActual) - year(e.fechaNacimiento) as Edad,
        e.salario,
        d.nombreDepartamento
        from empleado as e
        inner join departamento d on e.idDepartamentoFK = d.idDepartamento
		where e.idDepartamentoFK in (
			select d.idDepartamento from departamento
				where d.nombreDepartamento = 'Ventas');

# 4. Lista de empleados con edades entre 30 y 40 años
select	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado
        where	year(fechaActual) - year(fechaNacimiento)>=30 and
				year(fechaActual) - year(fechaNacimiento)<=40;

# 5. Lista de empleados contratados después de 2020
select	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario,
        fechaVinculacion
        from empleado
		where year(fechaVinculacion)>2020;

# 6. Empleados por departamento
select	e.idDepartamentoFK,
		d.nombreDepartamento,
        count(*) as 'empleadosDepartamento'
		from empleado as e
        inner join departamento d on e.idDepartamentoFK = d.idDepartamento
		group by idDepartamentoFK;

# 7. Salario promedio
select	avg(salario) from empleado;

# 8. Nombres cuyos nombres comienzan con 'A' o 'C'
select	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado
		where nombreEmpleado1 like 'A%' or nombreEmpleado1 like 'C%';

# 9. Empleados que no pertenecen a IT
select	e.nombreEmpleado1,
		e.nombreEmpleado2,
        e.apellidoEmpleado1,
        e.apellidoEmpleado2,
        year(e.fechaActual) - year(e.fechaNacimiento) as Edad,
        e.salario,
        d.nombreDepartamento
        from empleado as e
        inner join departamento d on e.idDepartamentoFK = d.idDepartamento
		where e.idDepartamentoFK in (
			select d.idDepartamento from departamento
				where d.nombreDepartamento != 'IT');

# 10. Empleado con el salario mas alto
select	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado
        where salario in (select max(salario) from empleado);

/*
inner join (interseccion)
left join (izquierda - interseccion)
right join (derecha - interseccion)
full outer join (union) NO EXISTE EN MYSQL
*/

# 11. Empleados cuyo salario sea mayor al promedio
select	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado
        where salario >= (select avg(salario) from empleado);

# 12. Encuentre el nombre del empleado con el segundo salario mas alto
select	nombreEmpleado1,
		nombreEmpleado2,
        apellidoEmpleado1,
        apellidoEmpleado2,
        year(fechaActual) - year(fechaNacimiento) as edad,
        salario
        from empleado
        where salario in (select max(salario) from empleado
			where salario < (select max(salario) from empleado));

# 13. Utilizando left join, muestre los departamentos que no tienen empleados asignados
select	d.nombreDepartamento,
        count(*) as 'empleadosDepartamento'
		from departamento as d
        left join empleado e on d.idDepartamento = e.idDepartamentoFK
        group by idDepartamentoFK
        having count(e.idEmpleado) = 0;
        
# 14. Total empleados por departamento
select	e.idDepartamentoFK,
		d.nombreDepartamento,
        count(*) as 'empleadosDepartamento'
		from empleado as e
        inner join departamento d on e.idDepartamentoFK = d.idDepartamento
		group by idDepartamentoFK;
