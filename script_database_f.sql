--CREATE DATABASE Forestal;
--GO

USE Forestal;
GO

-- Tablas independientes - Tipos de TH
CREATE TABLE TipoConcesiones (
	CODIGO BIGINT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoCesiones (
	CODIGO BIGINT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoBosqueLocal (
	CODIGO BIGINT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoAutorizaciones (
	CODIGO BIGINT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoPermisos (
	CODIGO BIGINT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE Concesiones (
	id int identity(1,1),
	FUENTE nvarchar(100) null,
	DOCREG nvarchar(100) null,
	FECREG datetime2 null,
	OBSERV nvarchar(255) null,
	ZONUTM int,
	ORIGEN int,
	TIPCON bigint,
	CONTRA nvarchar(300) PRIMARY KEY not null,
	FECONT datetime2 null,
	NOMTIT nvarchar(255),
	NOMREL nvarchar(255) null,
	NUMRUC nvarchar(11) null,
	TIPDOC int,
	NRODOC nvarchar(10),
	CONCUR int null,
	SUPSIG float,
	PROCOT int,
	SUPAPR float,
	PERIME float,
	NOMDIS nchar(6),
	NOMPRO nchar(4),
	NOMDEP nchar(2),
	AUTFOR int,
	FECINI datetime2 null,
	FECTER datetime2 null,
	DOCLEG nvarchar(100) null,
	FECLEG datetime2 null
)