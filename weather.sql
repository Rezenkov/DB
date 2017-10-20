USE master

GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'Rezenkov'
)
ALTER DATABASE [Rezenkov] set single_user with rollback immediate
GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'Rezenkov'
)
DROP DATABASE [Rezenkov]
GO

CREATE DATABASE [Rezenkov]
GO

USE [Rezenkov]
GO


IF EXISTS(
  SELECT *
    FROM sys.schemas
   WHERE name = N'lab1'
) 
 DROP SCHEMA lab1
GO


CREATE SCHEMA lab1 
GO

IF OBJECT_ID('[Rezenkov].lab1.tableOfMetering', 'U') IS NOT NULL
  DROP TABLE  [Rezenkov].lab1.tableOfMetering
GO


IF OBJECT_ID('[Rezenkov].lab1.station', 'U') IS NOT NULL
  DROP TABLE  [Rezenkov].lab1.station
GO

CREATE TABLE [Rezenkov].lab1.station
(
	ID_station tinyint NOT NULL, 
	Name nvarchar(40) NULL, 
	Location nvarchar(40) NULL,
    CONSTRAINT PK_station PRIMARY KEY (ID_station),
)
GO

IF OBJECT_ID('[Rezenkov].lab1.metering', 'U') IS NOT NULL
  DROP TABLE  [Rezenkov].lab1.metering
GO

CREATE TABLE [Rezenkov].lab1.metering
(
	ID_metering tinyint  NOT NULL, 
	Name nvarchar(40) NULL, 
	units nvarchar(20) null, 
	CONSTRAINT PK_metering PRIMARY KEY (ID_metering),
)
GO

CREATE TABLE [Rezenkov].lab1.tableOfMetering
(
	ID_station tinyint NOT NULL,
	ID_metering tinyint NOT NULL,
	Dateofmetering date NULL,
	_value int null,
	CONSTRAINT FK_station FOREIGN KEY(ID_station)
	REFERENCES [Rezenkov].lab1.station(ID_station),
	CONSTRAINT FK_metering FOREIGN KEY(ID_metering)
	REFERENCES [Rezenkov].lab1.metering(ID_metering),

)
GO

insert into [Rezenkov].lab1.metering
(ID_metering, Name, units)
values
(1, N'Температура', N'С*'),
(2, N'Давление',N'мм.рт.столба'),
(3,N'Скорость ветра',N'м\с')
GO

select * from [Rezenkov].lab1.metering
GO

INSERT INTO [Rezenkov].lab1.station
VALUES
(1,N'КРГН-1', N'Курган')
,(2, N'КРГН-2', N'Курган')
GO

SELECT * FROM [Rezenkov].lab1.station
GO

INSERT INTO [Rezenkov].lab1.tableOfMetering
VALUES
(1,1,'20170901',10)
,(1,2,'20170901',777)
,(1,3,'20170901', 2)
GO

SELECT * FROM [Rezenkov].lab1.tableOfMetering
WHERE(ID_metering = 1)