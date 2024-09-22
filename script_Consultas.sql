-- Consultas

-- 1.- ¿Cuántos tipos de concesiones hay a nivel nacional?

select tc.DESCRIP "Tipo de Concesiones", COUNT(*) As "Cantidad"
from Concesiones c
join TipoConcesiones tc on c.TIPCON = tc.CODIGO
group by tc.DESCRIP

-- 2.- ¿Cuántos títulos habilitantes han sido emitidos por cada autoridad forestal?
SELECT a.NOMBAU "Autoridad Forestal", 
       th.TipoTitulo "Título habilitante", 
       COUNT(*) AS "Cantidad"
FROM (
    SELECT autfor, 'Autorizaciones' AS TipoTitulo
    FROM Autorizaciones
    UNION ALL
    SELECT autfor, 'Bosques Locales' AS TipoTitulo
    FROM BosqueLocales
    UNION ALL
    SELECT autfor, 'Cesiones' AS TipoTitulo
    FROM Cesiones
    UNION ALL
    SELECT autfor, 'Concesiones' AS TipoTitulo
    FROM Concesiones
    UNION ALL
    SELECT autfor, 'Permisos' AS TipoTitulo
    FROM Permisos) AS th
JOIN ARFFS AS a ON th.autfor = a.CODIGO
GROUP BY a.NOMBAU, th.TipoTitulo
ORDER BY a.NOMBAU, th.TipoTitulo;

-- 3.- Implementar una función Obtener información sobre los permisos que están por vencer en los próximos 6 meses, 
--     mostrando el nombre del titular y la fecha de término.

-- Función
ALTER FUNCTION ObtenerPermisosPorVencer()
RETURNS TABLE
AS
RETURN (
    SELECT NUMPER As "Código de Permiso", NOMTIT As "Titular de Permiso", FECTER As "Fecha de Término"
    FROM Permisos
    WHERE FECTER BETWEEN GETDATE() AND DATEADD(MONTH, 6, GETDATE())

);
--

-- Llamando a la función
SELECT * FROM ObtenerPermisosPorVencer();

-- 4.- Implementar una función que me devuelva el área SIG de cada tipo de concesión

-- Función
CREATE FUNCTION ObtenerTotalAreaSIGPorTipoConcesion()
RETURNS TABLE
AS
RETURN (
    SELECT tc.DESCRIP "Tipo de Concesión", SUM(c.SUPSIG) AS "Área SIG Total (ha)"
    FROM Concesiones AS c
    JOIN TipoConcesiones AS tc ON c.TIPCON = tc.CODIGO
    GROUP BY tc.DESCRIP
);

-- Llamando a la función
SELECT * FROM ObtenerTotalAreaSIGPorTipoConcesion();

-- 5.- Implementar un procedimiento almacenado que devuelva los titulares de cesiones por numero de cesiones y la suma de área aprobada

-- Procedimiento almacenado
CREATE PROCEDURE ObtenerTitularesCantidadAreaCesiones
AS
BEGIN
    SELECT 
        NOMTIT "Titulares", 
        COUNT(*) AS "Cantidad de Cesiones",
        SUM(SUPAPR) AS "Área Aprobada (ha)"
    FROM 
        Cesiones
    GROUP BY 
        NOMTIT;
END

-- Llamando al pa
EXEC ObtenerTitularesCantidadAreaCesiones;

-- 6.- Implementar un procedimiento almacendado que devuela el nivel de aprovechamiento por tipo de permiso y bosque local, su numero y área aprobada

-- Procedimiento almacenado
CREATE PROCEDURE ObtenerNivelAprovechamientoTipoPermisoAreaAprobada
AS
BEGIN
    SELECT 
        tn.DESCRIP AS "Nivel de Aprovechamiento",
		'Permiso' As "Tipo de Título Habilitante",
        tp.DESCRIP AS "Tipo",
        COUNT(*) AS "Cantidad" ,
        SUM(p.SUPAPR) AS "Total Área Aprobada (ha)"
    FROM 
        Permisos AS p
    JOIN 
        TipoPermisos AS tp ON p.TIPPER = tp.CODIGO
    JOIN 
        TipoNiv AS tn ON p.NIVAPR = tn.CODIGO
    GROUP BY 
        tn.DESCRIP, 
        tp.DESCRIP
    UNION ALL

    SELECT 
        tn.DESCRIP AS "Nivel de Aprovechamiento",
		'Bosque Local' As "Tipo de Título Habilitante",
        tbl.DESCRIP AS "Tipo",
        COUNT(*) AS "Cantidad" ,
        SUM(bl.SUPAPR) AS "Total Área Aprobada (ha)"
    FROM 
        BosqueLocales AS bl
    JOIN 
        TipoBosqueLocal AS tbl ON bl.TIPBLO = tbl.CODIGO
    JOIN 
        TipoNiv AS tn ON bl.NIVAPR = tn.CODIGO
    GROUP BY 
        tn.DESCRIP, 
        tbl.DESCRIP

	ORDER BY
		"Nivel de Aprovechamiento",
		"Tipo de Título Habilitante"
END

-- Llamando al pa
EXEC ObtenerNivelAprovechamientoTipoPermisoAreaAprobada;

-- 7.- Implementar una vista que devuelva el tipo de otorgamiento por tipo de concesion, cantidad y área SIG total

CREATE VIEW VistaTipoOtorgamientoTipoConcesion
AS
SELECT 
    tp.DESCRIP AS "Nivel de Otorgamiento",
	tc.DESCRIP AS "Tipo de Concesión",
    COUNT(c.CONTRA) AS "Cantidad",
    SUM(c.SUPSIG) AS "Total Área SIG (ha)"
FROM 
    Concesiones AS c
JOIN 
    TipoConcesiones AS tc ON c.TIPCON = tc.CODIGO
JOIN 
    TipoProcot AS tp ON c.PROCOT = tp.CODIGO
GROUP BY 
	tp.DESCRIP,
    tc.DESCRIP

-- Consultar la vista
SELECT * FROM VistaTipoOtorgamientoTipoConcesion
ORDER BY "Nivel de Otorgamiento","Tipo de Concesión";
