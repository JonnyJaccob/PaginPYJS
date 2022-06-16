-- pagina https://parzibyte.me/blog/2019/06/14/conexion-sql-server-python-pyodbc-crud/#Instalacion_de_PyODBC  ;


create database pruebas_parzibyte;
use pruebas_parzibyte;


CREATE TABLE peliculas(
	id bigint identity(1,1) primary key,	
	titulo VARCHAR(255) NOT NULL,
	año SMALLINT NOT NULL
);