
---------- este codigo es para configurar el acceso de todos a la base de datos-------------------

-- Cambiar al contexto de la base de datos master
USE [master];

-- Crear la base de datos
CREATE DATABASE [brindis_real];  -- Cambia XXX por el nombre de tu base de datos

-- Cambiar al contexto de la base de datos reci�n creada
USE [brindis_real];
----------------------------------------------------------------------------------

-- Crear el inicio de sesi�n para el administrador (t�)
CREATE LOGIN [LARA] WITH PASSWORD = '2307';  -- Cambia por una contrase�a segura

-- Crear usuario en la base de datos para el administrador
CREATE USER [LARA] FOR LOGIN [LARA];
EXEC sp_addrolemember 'db_owner', 'LARA';  -- Asignar permisos de administrador

---------------------------------------------------------------------------------------------------------
-- Crear inicios de sesi�n para los otros usuarios (cambia los nombres y contrase�as seg�n corresponda)
CREATE LOGIN [ORIANA] WITH PASSWORD = '2307';  -- Cambia usuario1 y su contrase�a
CREATE LOGIN [CECILIA] WITH PASSWORD = '2307';  -- Cambia usuario2 y su contrase�a
CREATE LOGIN [JUAQUIN] WITH PASSWORD = '2307';  -- Cambia usuario3 y su contrase�a

-- Cambiar al contexto de tu base de datos
USE [XXX];

-- Crear usuarios en la base de datos para los compa�eros
CREATE USER [ORIANA] FOR LOGIN [ORIANA];
CREATE USER [CECILIA] FOR LOGIN [CECILIA];
CREATE USER [JUAQUIN] FOR LOGIN [JUAQUIN];

-- Asignar permisos de administrador a todos los usuarios
EXEC sp_addrolemember 'db_owner', 'ORIANA';  
EXEC sp_addrolemember 'db_owner', 'CECILIA';  
EXEC sp_addrolemember 'db_owner', 'JUAQUIN';