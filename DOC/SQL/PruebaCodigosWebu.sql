create database webu;
use webu;

drop table Alumno;
create table Alumno(
	ID_Alumno varchar(8) Primary key,
	Nombre varchar(30) not null,
	Apellido_Paterno varchar(12) not null,
	Apellido_Materno varchar(12),
	GeneroMasc bit default 1 not null,
	Fecha_Nacimiento Date not null,
	Fecha_Ingreso Date default getdate()
);

Alter table Alumno
add Semestre smallint default 1 not null;

alter table alumno
add Carrera varchar(30) default 'Mecanica'

select * from Alumno;

update alumno set Carrera = 'Mecanica' where ID_Alumno = '22GG002';
update alumno set Carrera = 'Electrica' where ID_Alumno = '22JD001';

select * from Alumno
order by Substring(ID_Alumno,5,3), Substring(ID_Alumno,1,2);

-- Eror de conflicto con el order by
create procedure DarAltaAlumno @Nombre varchar(30), @ApellidoP varchar(12), @ApellidoM varchar(12), @Genero bit, @FechaNac Date, @FechaIng Date
AS
BEGIN
DECLARE @ID varchar(8)
DECLARE @UltimoNumero smallint
SET @UltimoNumero = (select Substring(ID_Alumno,5,3) from Alumno order by ID_Alumno desc)
	IF @UltimoNumero is not null
		BEGIN
			Set @ID = (select CONCAT(Right(Cast(Year(@FechaIng) As Char(4)),2),SUBSTRING(@Nombre,1,1),SUBSTRING(@ApellidoP,1,1),@UltimoNumero+1) AS ID)
		END
	Else
		BEGIN
			Set @ID = (select CONCAT(Right(Cast(Year(@FechaIng) As Char(4)),2),SUBSTRING(@Nombre,1,1),SUBSTRING(@ApellidoP,1,1),'001') AS ID)
		END
	Insert into Alumno (ID_Alumno, Nombre,Apellido_Paterno,Apellido_Materno, GeneroMasc, Fecha_Nacimiento) 
	values (@ID,@Nombre, @ApellidoP, @ApellidoM, @Genero, @FechaNac, @FechaIng);
END

insert into Alumno values ('22JD001','Joe','Doe',null,1,'2001-01-01','2022-06-12');
select * from Alumno;
select CONCAT(Right(Cast(Year(Fecha_Ingreso) As Char(4)),2),SUBSTRING(Nombre,1,1),SUBSTRING(Apellido_Paterno,1,1)) AS ID from Alumno;
select Substring(ID_Alumno,5,3) as Ultimo_Numero from Alumno order by ID_Alumno desc;

--No funciono
create function NumeroUltimo (@int smallint)
returns table
AS return
select Substring(ID_Alumno,5,3) from Alumno order by ID_Alumno desc;

drop procedure PNumeroId;
CREATE PROCEDURE PNumeroId
WITH EXECUTE AS CALLER
AS
   SET NOCOUNT ON;
   select Substring(ID_Alumno,5,3) from Alumno order by ID_Alumno desc;

exec PNumeroId;
-- Sigue sin funcionar:/
drop procedure DarAltaAlumno;
create procedure DarAltaAlumno @Nombre varchar(30), @ApellidoP varchar(12), @ApellidoM varchar(12), @Genero bit, @FechaNac Date, @FechaIng Date
WITH EXECUTE AS CALLER
AS
SET NOCOUNT ON;
BEGIN
DECLARE @ID varchar(8)
DECLARE @UltimoNumero smallint
SET @UltimoNumero = (select Substring(ID_Alumno,5,3) from Alumno order by ID_Alumno desc)
	IF @UltimoNumero is not null
		BEGIN
			Set @ID = (select CONCAT(Right(Cast(Year(@FechaIng) As Char(4)),2),SUBSTRING(@Nombre,1,1),SUBSTRING(@ApellidoP,1,1),@UltimoNumero+1) AS ID)
		END
	Else
		BEGIN
			Set @ID = (select CONCAT(Right(Cast(Year(@FechaIng) As Char(4)),2),SUBSTRING(@Nombre,1,1),SUBSTRING(@ApellidoP,1,1),'001') AS ID)
		END
	Insert into Alumno (ID_Alumno, Nombre,Apellido_Paterno,Apellido_Materno, GeneroMasc, Fecha_Nacimiento) 
	values (@ID,@Nombre, @ApellidoP, @ApellidoM, @Genero, @FechaNac, @FechaIng);
END

drop table UltimaID;
create table UltimaID(ID varchar(3));
insert into UltimaID values ('001');
select * from UltimaID;

create procedure CambiarUltimaID @NuevaID varchar(3)
AS
Begin
	delete from UltimaID;
	insert into UltimaID values (@NuevaID)
END

create procedure DarAltaAlumno @Nombre varchar(30), @ApellidoP varchar(12), @ApellidoM varchar(12), @Genero bit, @FechaNac Date, @FechaIng Date, @Carrera varchar(30)
AS
BEGIN
DECLARE @ID varchar(8)
Declare @Codigo varchar(3)
Set @Codigo = (select ID from UltimaID)
DECLARE @UltimoNumero smallint
SET @UltimoNumero = (CAST(@Codigo as smallint))

	IF @UltimoNumero is not null
		BEGIN
			IF Len(@UltimoNumero) = 3
				Begin
					set @Codigo =  @UltimoNumero+1
				End
			Else if Len(@UltimoNumero) = 2
				Begin
					set @Codigo =  Concat('0',@UltimoNumero+1)
				End
			Else
				Begin
					set @Codigo =  Concat('00',@UltimoNumero+1)
				End
			Set @ID = (select CONCAT(Right(Cast(Year(@FechaIng) As Char(4)),2),SUBSTRING(@Nombre,1,1),SUBSTRING(@ApellidoP,1,1),@Codigo) AS ID)
			exec CambiarUltimaID @Codigo
		END
	Else
		BEGIN
			Set @ID = (select CONCAT(Right(Cast(Year(@FechaIng) As Char(4)),2),SUBSTRING(@Nombre,1,1),SUBSTRING(@ApellidoP,1,1),'001') AS ID)
			exec CambiarUltimaID '001'
		END
	Insert into Alumno (ID_Alumno, Nombre, Apellido_Paterno, Apellido_Materno, GeneroMasc, Fecha_Nacimiento, Fecha_Ingreso, Carrera) 
	values (@ID, @Nombre, @ApellidoP, @ApellidoM, @Genero, @FechaNac, @FechaIng, @Carrera);
END;

--Prueba de insercion
Begin Transaction
	select * from Alumno;
	Select * from UltimaID;
	exec DarAltaAlumno Gael, Garza, Mendez,1,'2000-01-01','2022-06-12'
	select * from Alumno;
	Select * from UltimaID;
rollback transaction

Begin Transaction
	select * from Alumno;
	Select * from UltimaID;
	select * from Cuenta;
	exec DarAltaAlumno Luis, Maldonado, Muñoz, 1, '2000-01-01','2022-06-13','Mecanica'
	select * from Alumno;
	Select * from UltimaID;
	select * from Cuenta;
rollback transaction

exec DarAltaAlumno Gael, Garza, Mendez,1,'2000-01-01','2022-06-12'

--Prueba de funcionamiento
Begin transaction
	Declare @Codigo1 varchar(3)
	Set @Codigo1 = (select ID from UltimaID)
	DECLARE @UltimoNumero1 smallint
	SET @UltimoNumero1 = (CAST(@Codigo1 as smallint))
	select @Codigo1 as codigo, @UltimoNumero1 as UltimoNum
	IF Len(@UltimoNumero1) = 3
				Begin
					set @Codigo1 =  @UltimoNumero1+1
				End
			Else if Len(@UltimoNumero1) = 2
				Begin
					set @Codigo1 =  Concat('0',@UltimoNumero1+1)
				End
			Else
				Begin
					set @Codigo1 =  Concat('00',@UltimoNumero1+1)
				End
	select @Codigo1 as codigocamb
rollback transaction

select * from Alumno order by ID_Alumno DESC;

create table Maestro(
	ID_Maestro smallint IDENTITY(1,1) PRIMARY KEY,
	Nombre varchar(25) not null,
	Apellido varchar(25) not null,
	Fecha_Nacimiento Date not null
);
select * from Maestro;
insert into Maestro values (1,'Rogelio','Ramirez','1979-01-01');
insert into Maestro values (2,'Laura','Montez','1975-01-01');
insert into Maestro values (3,'Pedro','Segui','1975-01-01');
insert into Maestro values (4,'Rafael','De la rosa','1974-01-01');
insert into Maestro values (5,'Maria','Checa','1973-01-01');

create Table Materia(
	ID_Materia smallint IDENTITY(1,1) PRIMARY KEY,
	Nombre varchar(20) not null
);
select * from Materia;
insert into Materia values ('Matematicas'),
					('Etica')
					,('Electrica'),
					('Mecanica');

drop table clase;
create table Clase(
	ID_Maestro smallint not null,
	ID_Alumno varchar(8) not null,
	ID_Materia smallint not null,
	Semestre smallint not null,
	Salon varchar(5) not null,
	Fecha_Creacion DateTime not null,
	CONSTRAINT FK_Clase_Maestro FOREIGN KEY (ID_Maestro)
    REFERENCES Maestro(ID_Maestro),
	CONSTRAINT FK_Clase_Alumno FOREIGN KEY (ID_Alumno)
    REFERENCES Alumno(ID_Alumno),
	CONSTRAINT FK_Clase_Materia FOREIGN KEY (ID_Materia)
    REFERENCES Materia(ID_Materia)
);
select * from Clase;

select * from Maestro;
select * from Alumno;
select * from Materia;
insert into Clase (ID_Maestro, ID_Alumno, ID_Materia, Semestre, Salon, Fecha_Creacion)
values (1,'22GG002',1,1,'H1',getdate());

insert into Clase (ID_Maestro, ID_Alumno, ID_Materia, Semestre, Salon, Fecha_Creacion)
values  (1,'22GG002',1,1,'H1',getdate()), --Mate prof1
		(1,'22LM003',1,1,'H1',getdate()), --Mate prof1
		(2,'22JD001',1,1,'H2',GETDATE()), --Mate prof2
		(5,'22GG002',2,1,'H1',GETDATE()), --Etica prof1
		(5,'22LM003',2,1,'H1',GETDATE()), --Etica prof1
		(3,'22GG002',2,1,'H2',GETDATE()), --Etica Prof2
		(1,'22GG002',3,1,'A1',getdate()), --Elec 
		(1,'22LM003',3,1,'A1',getdate()), --Elec 
		(4,'22GG002',4,1,'H2',GETDATE()); --Mec 

select * from Clase
order by ID_Alumno;

create table Cuenta(
	ID_Alumno varchar(8),
	Correo varchar(50),
	Contraseña varchar(30) not null,
	CONSTRAINT FK_Cuenta_Alumno FOREIGN KEY (ID_Alumno)
    REFERENCES Alumno(ID_Alumno)
);

drop trigger Cuenta_Alumno;
create trigger Cuenta_Alumno
ON Alumno
After insert
As
	Begin
		
		insert into Cuenta (ID_Alumno,correo,Contraseña) 
		values ((select ID_Alumno from Alumno where ID_Alumno LIKE '%'+(select * from UltimaID) and ID_Alumno LIKE ((Substring (Cast(Year(getdate()) As Char(4)),3,2))+'%')),
		concat('ut',(select ID_Alumno from Alumno where ID_Alumno LIKE '%'+(select * from UltimaID) and ID_Alumno LIKE ((Substring (Cast(Year(getdate()) As Char(4)),3,2))+'%')),'@nlaredo.mx'),
		(select ID_Alumno from Alumno where ID_Alumno LIKE '%'+(select * from UltimaID) and ID_Alumno LIKE ((Substring (Cast(Year(getdate()) As Char(4)),3,2))+'%'))
		);
	end;

select Right(Cast(Year(getdate()) As Char(4)),2);
select Substring (Cast(Year(getdate()) As Char(4)),3,2);

DELIMITER //
create trigger Cuenta_Alumno
ON Alumno
After insert
As
Declare @NumControl
Set @NumControl = ((select ID_Alumno from Alumno where ID_Alumno LIKE '%'+(select * from UltimaID) and ID_Alumno LIKE ((Substring (Cast(Year(getdate()) As Char(4)),3,2))+'%'))
	Begin
		
		insert into Cuenta (ID_Alumno,Correo,Contraseña) 
		values (@NumControl,'ut'+@NumControl+'@nlaredo.mx',@NumControl);
	end
//

/*Mysql ejemplo
DELIMITER $$
CREATE TRIGGER Pc_Auditoria AFTER UPDATE ON pcTotal
FOR EACH ROW
BEGIN
    IF (SELECT LEFT(CURRENT_USER(), INSTR(CURRENT_USER(), '@') - 1) = 'root')THEN BEGIN
        select 'root';
    END; END IF;
END$$
DELIMITER ;
*/

select * from Alumno;
select * from Cuenta;
insert into Cuenta values ('22LM003','ut22LM003@nlaredo.mx','22LM003');

SELECT  
   CONNECTIONPROPERTY('net_transport') AS net_transport,
   CONNECTIONPROPERTY('protocol_type') AS protocol_type,
   CONNECTIONPROPERTY('auth_scheme') AS auth_scheme,
   CONNECTIONPROPERTY('local_net_address') AS local_net_address,
   CONNECTIONPROPERTY('local_tcp_port') AS local_tcp_port,
   CONNECTIONPROPERTY('client_net_address') AS client_net_address 

create Procedure sp_get_ip_address (@ip varchar(40) out)
as
begin
Declare @ipLine varchar(200)
Declare @pos int
set nocount on
          set @ip = NULL
          Create table #temp (ipLine varchar(200))
          Insert #temp exec master..xp_cmdshell 'ipconfig'
          select @ipLine = ipLine
          from #temp
          where upper (ipLine) like '%IP ADDRESS%'
          if (isnull (@ipLine,'***') != '***')
          begin 
                set @pos = CharIndex (':',@ipLine,1);
                set @ip = rtrim(ltrim(substring (@ipLine , 
               @pos + 1 ,
                len (@ipLine) - @pos)))
           end 
drop table #temp
set nocount off
end 
go

declare @ip varchar(40)
exec sp_get_ip_address @ip out
print @ip

SELECT @@SERVERNAME;

Select * from Alumno;

select * from cuenta;

select c.ID_Alumno, c.correo, c.Contraseña, a.Nombre, a.Apellido_Paterno, a.Apellido_Materno, a.Fecha_Nacimiento, a.Fecha_Ingreso, a.carrera, a.Semestre
from cuenta c join alumno a on (a.Id_Alumno = c.Id_Alumno)
where c.ID_Alumno = '22LM003' and c.Contraseña = '22LM003'

select c.ID_Alumno, c.correo, c.Contraseña, a.Nombre, a.Apellido_Paterno, a.Apellido_Materno, a.Fecha_Nacimiento, a.Fecha_Ingreso, a.carrera, a.Semestre
from cuenta c join alumno a on (a.Id_Alumno = c.Id_Alumno)
where c.Correo = 'ut22LM003@nlaredo.mx' and c.Contraseña = '22LM003'

select case 
when exists(select ID_Alumno from cuenta where ID_Alumno = '22LM003' and Contraseña = '22LM003')
then 'si'
else 'no'
end as Existe

select case when exists(select ID_Alumno from cuenta where ID_Alumno = '22LM003' and Contraseña = '22LM003') then 'si' else 'no' end as Existe

select case 
when exists(select ID_Alumno from cuenta where Correo = 'ut22LM003@nlaredo.mx' and Contraseña = '22LM003')
then 'si'
else 'no'
end as Existe

select case when exists(select ID_Alumno from cuenta where Correo = 'ut22LM003@nlaredo.mx' and Contraseña = '22LM003') then 'si' else 'no' end as Existe

begin transaction
	select * from Alumno;
	exec DarAltaAlumno Alan, Mal, M, 1, '2000-01-01', '2022-06-13', 'Mecanica'
	select * from Alumno;
rollback transaction

select * from Alumno;
select * from Clase;
select * from Cuenta;
select * from Maestro;
select * from Materia;
select * from UltimaID;

/*exec DarAltaAlumno*/
/*exec CambiarUltimaID*/

select TOP 1 ID_Alumno from Alumno
order by Substring(ID_Alumno,5,3) DESC;