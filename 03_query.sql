--Consultar todos los productos que contengan la etiqueta 'tecnología'.
SELECT nombre FROM productos WHERE etiqueta @> ARRAY['tecnología']; 

--Usar una CTE recursiva para listar todos los subordinados de un jefe específico.
WITH RECURSIVE jerarquia_empleados AS (
    SELECT id, nombre, jefe_id FROM empleados WHERE jefe_id = 1
    UNION ALL
    SELECT e.id, e.nombre, e.jefe_id
    FROM empleados e
    INNER JOIN jerarquia_empleados j ON e.jefe_id = j.id
)
--SELECT * FROM jerarquia_empleados;
  
--Consultar todas las ciudades alcanzables desde una ciudad inicial.
WITH RECURSIVE recorrido AS (
    SELECT 
        ciudad,
        conexiones,
        ARRAY[ciudad] AS visitadas
    FROM ciudades
    WHERE ciudad = 'A' 

    UNION ALL
    SELECT 
        c.ciudad,
        c.conexiones,
        r.visitadas || c.ciudad
    FROM ciudades c
    JOIN recorrido r 
        ON c.ciudad = ANY(r.conexiones)
    WHERE NOT (c.ciudad = ANY(r.visitadas))
)

--SELECT ciudad FROM recorrido;
