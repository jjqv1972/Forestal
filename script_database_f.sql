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

CREATE TABLE ARFFS (
	CODIGO int PRIMARY KEY,
	FUENTE nvarchar(100) null,
	DOCREG nvarchar(100) null,
	FECREG datetime2 null,
	OBSERV nvarchar(255) null,
	ZONUTM int,
	ORIGEN int,
	NOMBAU nvarchar(255),
	NOMRES nvarchar(255),
	DIREPC nvarchar(255),
	TELEFO nvarchar(50),
	NOMDIS nchar(6),
	NOMPRO nchar(4),
	NOMDEP nchar(2),
	DOCLEG nvarchar(100)
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
	CONTRA nvarchar(50) PRIMARY KEY not null,
	FECONT datetime2 null,
	NOMTIT nvarchar(255),
	NOMREL nvarchar(255) null,
	NUMRUC nvarchar(11) null,
	TIPDOC int,
	NRODOC nvarchar(10),
	CONCUR int null,
	SUPSIG float,
	SUPAPR float,
	PROCOT int,
	PERIME float,
	NOMDIS nchar(6),
	NOMPRO nchar(4),
	NOMDEP nchar(2),
	AUTFOR int,
	FECINI datetime2 null,
	FECTER datetime2 null,
	DOCLEG nvarchar(100) null,
	FECLEG datetime2 null
);
GO

CREATE TABLE Cesiones (
	id int identity(1,1),
	FUENTE nvarchar(100) null,
	DOCREG nvarchar(100) null,
	FECREG datetime2 null,
	OBSERV nvarchar(255) null,
	ZONUTM int,
	ORIGEN int,
	TIPCEU bigint,
	CONTRA nvarchar(50) PRIMARY KEY not null,
	NOMTIT nvarchar(255),
	NOMREL nvarchar(255) null,
	NUMRUC nvarchar(11) null,
	TIPDOC int,
	NRODOC nvarchar(10),
	SUPSIG float,
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
);
GO

CREATE TABLE Permisos (
	id int identity(1,1),
	FUENTE nvarchar(100) null,
	DOCREG nvarchar(100) null,
	FECREG datetime2 null,
	OBSERV nvarchar(255) null,
	ZONUTM int,
	ORIGEN int,
	TIPPER bigint,
	NUMPER nvarchar(50) PRIMARY KEY not null,
	NOMTIT nvarchar(255),
	NOMREL nvarchar(255) null,
	NUMRUC nvarchar(11) null,
	TIPDOC int,
	NRODOC nvarchar(10),
	SUPSIG float,
	SUPAPR float,
	NOMDIS nchar(6),
	NOMPRO nchar(4),
	NOMDEP nchar(2),
	AUTFOR int,
	FECINI datetime2 null,
	FECTER datetime2 null,
	DOCLEG nvarchar(100) null,
	FECLEG datetime2 null,
	ASIGNA int,
	NOMCCN nvarchar(255) null,
	NIVAPR int
);
GO

CREATE TABLE BosqueLocales (
	id int identity(1,1),
	FUENTE nvarchar(100) null,
	DOCREG nvarchar(100) null,
	FECREG datetime2 null,
	OBSERV nvarchar(255) null,
	ZONUTM int,
	ORIGEN int,
	CODIGO nvarchar(50) PRIMARY KEY,
	NOMBOS nvarchar(100) null,
	TIPBLO bigint,
	NOMTIT nvarchar(255),
	NOMREL nvarchar(255) null,
	NUMRUC nvarchar(11) null,
	TIPDOC int,
	NRODOC nvarchar(10),
	SUPSIG float,
	SUPAPR float,
	CUENCA nvarchar(100) null,
	SECTOR nvarchar(100) null,
	NOMDIS nchar(6),
	NOMPRO nchar(4),
	NOMDEP nchar(2),
	AUTFOR int,
	FECINI datetime2 null,
	FECTER datetime2 null,
	DOCLEG nvarchar(100) null,
	FECLEG datetime2 null,
	NIVAPR int
);
GO

CREATE TABLE Autorizaciones (
	id int identity(1,1),
	FUENTE nvarchar(100) null,
	DOCREG nvarchar(100) null,
	FECREG datetime2 null,
	OBSERV nvarchar(255) null,
	ZONUTM int,
	ORIGEN int,
	TIPANB bigint,
	NUMAUT nvarchar(50) PRIMARY KEY,
	NOMTIT nvarchar(255),
	NOMREL nvarchar(255) null,
	NUMRUC nvarchar(11) null,
	TIPDOC int,
	NRODOC nvarchar(10),
	SUPSIG float,
	SUPAPR float,
	SECTOR nvarchar(100) null,
	NOMDIS nchar(6),
	NOMPRO nchar(4),
	NOMDEP nchar(2),
	AUTFOR int,
	FECINI datetime2 null,
	FECTER datetime2 null,
	DOCLEG nvarchar(100) null,
	FECLEG datetime2 null,
	ASIGNA int,
	NOMCCN nvarchar(255)
);
GO

ALTER TABLE Concesiones
ADD CONSTRAINT FK_Tipo_Concesiones FOREIGN KEY (TIPCON) REFERENCES TipoConcesiones(CODIGO);

ALTER TABLE Cesiones
ADD CONSTRAINT FK_Tipo_Cesiones FOREIGN KEY (TIPCEU) REFERENCES TipoCesiones(CODIGO);

ALTER TABLE BosqueLocales
ADD CONSTRAINT FK_Tipo_BosqueLocales FOREIGN KEY (TIPBLO) REFERENCES TipoBosqueLocal(CODIGO);

ALTER TABLE Autorizaciones
ADD CONSTRAINT FK_Tipo_Autorizaciones FOREIGN KEY (TIPANB) REFERENCES TipoAutorizaciones(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_Tipo_Permisos FOREIGN KEY (TIPPER) REFERENCES TipoPermisos(CODIGO);

ALTER TABLE Concesiones
ADD CONSTRAINT FK_ARFFS_Concesiones FOREIGN KEY (AUTFOR) REFERENCES ARFFS(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_ARFFS_Permisos FOREIGN KEY (AUTFOR) REFERENCES ARFFS(CODIGO);

ALTER TABLE Cesiones
ADD CONSTRAINT FK_ARFFS_Cesiones FOREIGN KEY (AUTFOR) REFERENCES ARFFS(CODIGO);

ALTER TABLE BosqueLocales
ADD CONSTRAINT FK_ARFFS_BosqueLocales FOREIGN KEY (AUTFOR) REFERENCES ARFFS(CODIGO);

ALTER TABLE Autorizaciones
ADD CONSTRAINT FK_ARFFS_Autorizaciones FOREIGN KEY (AUTFOR) REFERENCES ARFFS(CODIGO);

CREATE TABLE TipoAsigna (
	CODIGO INT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoDoc (
	CODIGO INT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoNiv (
	CODIGO INT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoOrigen (
	CODIGO INT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoProcot (
	CODIGO INT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

CREATE TABLE TipoUtm (
	CODIGO INT PRIMARY KEY,
	DESCRIP NVARCHAR(100) not null
);
GO

ALTER TABLE Concesiones
ADD CONSTRAINT FK_TipoUtm_Concesiones FOREIGN KEY (ZONUTM) REFERENCES TipoUtm(CODIGO);

ALTER TABLE Concesiones
ADD CONSTRAINT FK_TipoOri_Concesiones FOREIGN KEY (ORIGEN) REFERENCES TipoOrigen(CODIGO);

ALTER TABLE Concesiones
ADD CONSTRAINT FK_TipoDoc_Concesiones FOREIGN KEY (TIPDOC) REFERENCES TipoDoc(CODIGO);

ALTER TABLE Concesiones
ADD CONSTRAINT FK_TipoPro_Concesiones FOREIGN KEY (PROCOT) REFERENCES TipoProcot(CODIGO);

ALTER TABLE Autorizaciones
ADD CONSTRAINT FK_TipoUtm_Autorizaciones FOREIGN KEY (ZONUTM) REFERENCES TipoUtm(CODIGO);

ALTER TABLE Autorizaciones
ADD CONSTRAINT FK_TipoOri_Autorizaciones FOREIGN KEY (ORIGEN) REFERENCES TipoOrigen(CODIGO);

ALTER TABLE Autorizaciones
ADD CONSTRAINT FK_TipoDoc_Autorizaciones FOREIGN KEY (TIPDOC) REFERENCES TipoDoc(CODIGO);

ALTER TABLE Autorizaciones
ADD CONSTRAINT FK_TipoAsi_Autorizaciones FOREIGN KEY (ASIGNA) REFERENCES TipoAsigna(CODIGO);

ALTER TABLE BosqueLocales
ADD CONSTRAINT FK_TipoUtm_BosqueLocales FOREIGN KEY (ZONUTM) REFERENCES TipoUtm(CODIGO);

ALTER TABLE BosqueLocales
ADD CONSTRAINT FK_TipoOri_BosqueLocales FOREIGN KEY (ORIGEN) REFERENCES TipoOrigen(CODIGO);

ALTER TABLE BosqueLocales
ADD CONSTRAINT FK_TipoDoc_BosqueLocales FOREIGN KEY (TIPDOC) REFERENCES TipoDoc(CODIGO);

ALTER TABLE BosqueLocales
ADD CONSTRAINT FK_TipoNiv_BosqueLocales FOREIGN KEY (NIVAPR) REFERENCES TipoNiv(CODIGO);

ALTER TABLE Cesiones
ADD CONSTRAINT FK_TipoUtm_Cesiones FOREIGN KEY (ZONUTM) REFERENCES TipoUtm(CODIGO);

ALTER TABLE Cesiones
ADD CONSTRAINT FK_TipoOri_Cesiones FOREIGN KEY (ORIGEN) REFERENCES TipoOrigen(CODIGO);

ALTER TABLE Cesiones
ADD CONSTRAINT FK_TipoDoc_Cesiones FOREIGN KEY (TIPDOC) REFERENCES TipoDoc(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_TipoUtm_Permisos FOREIGN KEY (ZONUTM) REFERENCES TipoUtm(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_TipoOri_Permisos FOREIGN KEY (ORIGEN) REFERENCES TipoOrigen(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_TipoDoc_Permisos FOREIGN KEY (TIPDOC) REFERENCES TipoDoc(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_TipoAsi_Permisos FOREIGN KEY (ASIGNA) REFERENCES TipoAsigna(CODIGO);

ALTER TABLE Permisos
ADD CONSTRAINT FK_TipoNiv_Permisos FOREIGN KEY (NIVAPR) REFERENCES TipoNiv(CODIGO);