USE [master]
GO
/****** Object:  Database [webu]    Script Date: 16/06/2022 10:03:40 p. m. ******/
CREATE DATABASE [webu]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'webu', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\webu.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'webu_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\webu_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [webu] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [webu].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [webu] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [webu] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [webu] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [webu] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [webu] SET ARITHABORT OFF 
GO
ALTER DATABASE [webu] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [webu] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [webu] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [webu] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [webu] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [webu] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [webu] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [webu] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [webu] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [webu] SET  ENABLE_BROKER 
GO
ALTER DATABASE [webu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [webu] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [webu] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [webu] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [webu] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [webu] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [webu] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [webu] SET RECOVERY FULL 
GO
ALTER DATABASE [webu] SET  MULTI_USER 
GO
ALTER DATABASE [webu] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [webu] SET DB_CHAINING OFF 
GO
ALTER DATABASE [webu] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [webu] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [webu] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [webu] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'webu', N'ON'
GO
ALTER DATABASE [webu] SET QUERY_STORE = OFF
GO
USE [webu]
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 16/06/2022 10:03:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumno](
	[ID_Alumno] [varchar](8) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Apellido_Paterno] [varchar](12) NOT NULL,
	[Apellido_Materno] [varchar](12) NULL,
	[GeneroMasc] [bit] NOT NULL,
	[Fecha_Nacimiento] [date] NOT NULL,
	[Fecha_Ingreso] [date] NULL,
	[Semestre] [smallint] NOT NULL,
	[Carrera] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Alumno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clase]    Script Date: 16/06/2022 10:03:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clase](
	[ID_Maestro] [smallint] NOT NULL,
	[ID_Alumno] [varchar](8) NOT NULL,
	[ID_Materia] [smallint] NOT NULL,
	[Semestre] [smallint] NOT NULL,
	[Salon] [varchar](5) NOT NULL,
	[Fecha_Creacion] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cuenta]    Script Date: 16/06/2022 10:03:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cuenta](
	[ID_Alumno] [varchar](8) NULL,
	[Correo] [varchar](50) NULL,
	[Contraseña] [varchar](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maestro]    Script Date: 16/06/2022 10:03:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maestro](
	[ID_Maestro] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](25) NOT NULL,
	[Apellido] [varchar](25) NOT NULL,
	[Fecha_Nacimiento] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Maestro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 16/06/2022 10:03:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materia](
	[ID_Materia] [smallint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Materia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UltimaID]    Script Date: 16/06/2022 10:03:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UltimaID](
	[ID] [varchar](3) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alumno] ADD  DEFAULT ((1)) FOR [GeneroMasc]
GO
ALTER TABLE [dbo].[Alumno] ADD  DEFAULT (getdate()) FOR [Fecha_Ingreso]
GO
ALTER TABLE [dbo].[Alumno] ADD  DEFAULT ((1)) FOR [Semestre]
GO
ALTER TABLE [dbo].[Alumno] ADD  DEFAULT ('Mecanica') FOR [Carrera]
GO
ALTER TABLE [dbo].[Clase]  WITH CHECK ADD  CONSTRAINT [FK_Clase_Alumno] FOREIGN KEY([ID_Alumno])
REFERENCES [dbo].[Alumno] ([ID_Alumno])
GO
ALTER TABLE [dbo].[Clase] CHECK CONSTRAINT [FK_Clase_Alumno]
GO
ALTER TABLE [dbo].[Clase]  WITH CHECK ADD  CONSTRAINT [FK_Clase_Maestro] FOREIGN KEY([ID_Maestro])
REFERENCES [dbo].[Maestro] ([ID_Maestro])
GO
ALTER TABLE [dbo].[Clase] CHECK CONSTRAINT [FK_Clase_Maestro]
GO
ALTER TABLE [dbo].[Clase]  WITH CHECK ADD  CONSTRAINT [FK_Clase_Materia] FOREIGN KEY([ID_Materia])
REFERENCES [dbo].[Materia] ([ID_Materia])
GO
ALTER TABLE [dbo].[Clase] CHECK CONSTRAINT [FK_Clase_Materia]
GO
ALTER TABLE [dbo].[Cuenta]  WITH CHECK ADD  CONSTRAINT [FK_Cuenta_Alumno] FOREIGN KEY([ID_Alumno])
REFERENCES [dbo].[Alumno] ([ID_Alumno])
GO
ALTER TABLE [dbo].[Cuenta] CHECK CONSTRAINT [FK_Cuenta_Alumno]
GO
/****** Object:  StoredProcedure [dbo].[CambiarUltimaID]    Script Date: 16/06/2022 10:03:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CambiarUltimaID] @NuevaID varchar(3)
AS
Begin
	delete from UltimaID;
	insert into UltimaID values (@NuevaID)
END
GO
/****** Object:  StoredProcedure [dbo].[DarAltaAlumno]    Script Date: 16/06/2022 10:03:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DarAltaAlumno] @Nombre varchar(30), @ApellidoP varchar(12), @ApellidoM varchar(12), @Genero bit, @FechaNac Date, @FechaIng Date, @Carrera varchar(30)
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
GO
/****** Object:  StoredProcedure [dbo].[PNumeroId]    Script Date: 16/06/2022 10:03:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PNumeroId]
WITH EXECUTE AS CALLER
AS
   SET NOCOUNT ON;
   select Substring(ID_Alumno,5,3) from Alumno order by ID_Alumno desc;
GO
USE [master]
GO
ALTER DATABASE [webu] SET  READ_WRITE 
GO
