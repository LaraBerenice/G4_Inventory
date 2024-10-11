
---------- este codigo es para configurar el acceso de todos a la base de datos-------------------

-- Cambiar al contexto de la base de datos master
USE [master];

-- Crear la base de datos
CREATE DATABASE [brindis_real];  -- Cambia XXX por el nombre de tu base de datos

-- Cambiar al contexto de la base de datos reci�n creada
USE [brindis_real];
----------------------------------------------------------------------------------
----------------------verificar logins------------------------------------
SELECT name
FROM sys.server_principals
WHERE type = 'S'; -- 'S' representa logins de SQL Server (no relacionados a Windows)
------------------------------------------------------------------------
USE [brindis_real];  -- Cambia 'XXX' por el nombre de tu base de datos --
SELECT name 
FROM sys.database_principals 
WHERE name IN ('ORIANA', 'CECILIA', 'JUAQUIN','LARA');
--------------------------------

-- Eliminar los usuarios del rol 'db_owner'
EXEC sp_droprolemember 'db_owner', 'LARA';  
EXEC sp_droprolemember 'db_owner', 'ORIANA';  
EXEC sp_droprolemember 'db_owner', 'CECILIA';  
EXEC sp_droprolemember 'db_owner', 'JUAQUIN';
---------------------------------------------
-- Eliminar los usuarios de la base de datos
USE [brindis_real];  -- Asegúrate de estar en la base de datos correcta
DROP USER [LARA];  
DROP USER [ORIANA];  
DROP USER [CECILIA];  
DROP USER [JUAQUIN];
--------------------------------------------------
-- Eliminar los logins del servidor
DROP LOGIN [LARA];  
DROP LOGIN [ORIANA];  
DROP LOGIN [CECILIA];  
DROP LOGIN [JUAQUIN];

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

