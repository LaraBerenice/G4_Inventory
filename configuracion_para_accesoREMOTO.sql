
---------- este codigo es para configurar el acceso de todos a la base de datos-------------------

-- Cambiar al contexto de la base de datos master
USE [master];

-- Crear la base de datos
CREATE DATABASE [brindis_real];  -- Cambia XXX por el nombre de tu base de datos

-- Cambiar al contexto de la base de datos reci�n creada
USE [brindis_real];
----------------------------------------------------------------------------------
-- Verificar y eliminar logins si ya existen
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'LARA')
BEGIN
    DROP LOGIN [LARA];
END

IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'ORIANA')
BEGIN
    DROP LOGIN [ORIANA];
END

IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'CECILIA')
BEGIN
    DROP LOGIN [CECILIA];
END

IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'JUAQUIN')
BEGIN
    DROP LOGIN [JUAQUIN];
END

-- Verificar y eliminar usuarios si ya existen en la base de datos actual
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'LARA')
BEGIN
    DROP USER [LARA];
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'ORIANA')
BEGIN
    DROP USER [ORIANA];
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'CECILIA')
BEGIN
    DROP USER [CECILIA];
END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'JUAQUIN')
BEGIN
    DROP USER [JUAQUIN];
END

---------------------------------------------------------------------------------------------------------
-- Crear el inicio de sesión para el administrador (tú)
CREATE LOGIN [LARA] WITH PASSWORD = '2307';  -- Cambia por una contraseña segura

-- Crear usuario en la base de datos para el administrador
CREATE USER [LARA] FOR LOGIN [LARA];
EXEC sp_addrolemember 'db_owner', 'LARA';  -- Asignar permisos de administrador

---------------------------------------------------------------------------------------------------------
-- Crear inicios de sesión para los otros usuarios (cambia los nombres y contraseñas según corresponda)
CREATE LOGIN [ORIANA] WITH PASSWORD = '2307';  -- Cambia usuario1 y su contraseña
CREATE LOGIN [CECILIA] WITH PASSWORD = '2307';  -- Cambia usuario2 y su contraseña
CREATE LOGIN [JUAQUIN] WITH PASSWORD = '2307';  -- Cambia usuario3 y su contraseña

-- Crear usuarios en la base de datos para los compañeros
CREATE USER [ORIANA] FOR LOGIN [ORIANA];
CREATE USER [CECILIA] FOR LOGIN [CECILIA];
CREATE USER [JUAQUIN] FOR LOGIN [JUAQUIN];

-- Asignar permisos de administrador a todos los usuarios
EXEC sp_addrolemember 'db_owner', 'ORIANA';  
EXEC sp_addrolemember 'db_owner', 'CECILIA';  
EXEC sp_addrolemember 'db_owner', 'JUAQUIN';  

