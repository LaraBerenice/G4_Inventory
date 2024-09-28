-- ambia al contexto de la base de datos Lara
USE Lara;

-- Crea un inicio de sesión para el usuario 'lara' con una contraseña
CREATE LOGIN lara WITH PASSWORD = '230723' -- úrate de poner una contraseña válida

-- Crea un usuario en la base de datos 'Lara' asociado al inicio de sesión 'lara'
CREATE USER lara FOR LOGIN lara;

-- Asigna el rol de db_owner al usuario 'lara' para otorgar todos los permisos
ALTER ROLE db_owner ADD MEMBER lara;
