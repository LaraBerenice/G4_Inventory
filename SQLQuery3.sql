-- cambia al contexto de la base de datos Lara
USE Lara;

-- Crea un inicio de sesi�n para el usuario 'lara' con una contrase�a
CREATE LOGIN lara WITH PASSWORD = '230723' -- �rate de poner una contrase�a v�lida

-- Crea un usuario en la base de datos 'Lara' asociado al inicio de sesi�n 'lara'
CREATE USER lara FOR LOGIN lara;

-- Asigna el rol de db_owner al usuario 'lara' para otorgar todos los permisos
ALTER ROLE db_owner ADD MEMBER lara;
