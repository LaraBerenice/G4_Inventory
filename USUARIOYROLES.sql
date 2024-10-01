-------VER LOS USUARIOS------------
SELECT 
    dp.name AS Username, 
    dp.type_desc AS UserType,
    dp.create_date AS CreationDate,
    dp.modify_date AS ModificationDate
FROM 
    sys.database_principals AS dp
WHERE 
    dp.type IN ('S', 'U', 'G')  -- S: SQL user, U: Windows user, G: Windows group
ORDER BY 
    dp.name;
---------VER LOS ROLES DE LOS USUARIOS-------
SELECT 
    dp.name AS Username,
    dr.name AS Role 
FROM 
    sys.database_role_members AS drm
JOIN 
    sys.database_principals AS dp ON drm.member_principal_id = dp.principal_id
JOIN 
    sys.database_principals AS dr ON drm.role_principal_id = dr.principal_id
ORDER BY 
    dp.name;

	--- VER TODOS LOS INICIOS DE SECION EN EL SERVIDOR--
	SELECT 
    sl.name AS LoginName, 
    sl.type_desc AS LoginType,
    sl.create_date AS CreationDate,
    sl.modify_date AS ModificationDate
FROM 
    sys.server_principals AS sl
WHERE 
    sl.type IN ('S', 'U', 'G')  -- S: SQL user, U: Windows user, G: Windows group
ORDER BY 
    sl.name;


