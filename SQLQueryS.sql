
CREATE DATABASE "XXX"

-- Posicionamiento en la BD ---------

USE XXX

---------- este codigo es para configurar el acceso de todos a la base de datos-------------------

-- Cambiar al contexto de la base de datos master
USE [master];

-- Crear la base de datos
CREATE DATABASE [XXX];  -- Cambia XXX por el nombre de tu base de datos

-- Cambiar al contexto de la base de datos recién creada
USE [XXX];

-- Crear el inicio de sesión para el administrador (tú)
CREATE LOGIN [LARA] WITH PASSWORD = 'TuContraseñaSegura';  -- Cambia por una contraseña segura

-- Crear usuario en la base de datos para el administrador
CREATE USER [LARA] FOR LOGIN [LARA];
EXEC sp_addrolemember 'db_owner', 'LARA';  -- Asignar permisos de administrador

-- Crear inicios de sesión para los otros usuarios (cambia los nombres y contraseñas según corresponda)
CREATE LOGIN [usuario1] WITH PASSWORD = 'ContraseñaSegura1';  -- Cambia usuario1 y su contraseña
CREATE LOGIN [usuario2] WITH PASSWORD = 'ContraseñaSegura2';  -- Cambia usuario2 y su contraseña
CREATE LOGIN [usuario3] WITH PASSWORD = 'ContraseñaSegura3';  -- Cambia usuario3 y su contraseña

-- Cambiar al contexto de tu base de datos
USE [XXX];

-- Crear usuarios en la base de datos para los compañeros
CREATE USER [usuario1] FOR LOGIN [usuario1];
CREATE USER [usuario2] FOR LOGIN [usuario2];
CREATE USER [usuario3] FOR LOGIN [usuario3];

-- Asignar permisos de administrador a todos los usuarios
EXEC sp_addrolemember 'db_owner', 'usuario1';  
EXEC sp_addrolemember 'db_owner', 'usuario2';  
EXEC sp_addrolemember 'db_owner', 'usuario3';
