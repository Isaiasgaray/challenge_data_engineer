-- 1°
-- Considerando únicamente la plataforma de Netflix,
-- ¿qué actor aparece más veces?

SELECT a.actor_name, COUNT(*) AS apariciones
FROM content_actor ca 
INNER JOIN "content" c ON ca.content_id  = c.content_id
INNER JOIN platform p  ON p.platform_id  = c.platform_id
INNER JOIN actor a     ON ca.actor_id    = a.actor_id 
WHERE p.platform = 'Netflix' AND a.actor_name != 'Unknown'
GROUP BY a.actor_name
ORDER BY apariciones DESC
LIMIT 2

-- Resultado:
-- Unknown     825 apariciones
-- Anupam Kher 43 apariciones

-- 2°
-- Top 10 de actores participantes considerando ambas 
-- plataformas en el año actual. Se aprecia flexibilidad.

CREATE OR REPLACE FUNCTION top_10_actores_anio(anio integer)
RETURNS TABLE (
	actor_name  VARCHAR,
	platform    VARCHAR,
	apariciones BIGINT
)
AS $$
BEGIN
	RETURN query
		SELECT a.actor_name, p.platform, COUNT(*) AS apariciones
		FROM content_actor ca 
		INNER JOIN "content" c ON ca.content_id  = c.content_id
		INNER JOIN platform p  ON p.platform_id  = c.platform_id
		INNER JOIN actor a     ON ca.actor_id    = a.actor_id 
		WHERE p.platform IN ('Netflix', 'Disney Plus')
			  AND EXTRACT('Year' FROM c.date_added) = anio
			  AND a.actor_name != 'Unknown'
		GROUP BY a.actor_name, p.platform 
		ORDER BY apariciones DESC
		LIMIT 10;
END; $$
LANGUAGE plpgsql

SELECT * FROM top_10_actores_anio(2023)
SELECT * FROM top_10_actores_anio(2019)

-- Resultados 2019:
-- Jim Cummings	  		Disney Plus	29
-- Walt Disney	        Disney Plus	14
-- Jeff Bennett	        Disney Plus	13
-- Morgan Freeman       Netflix		11
-- Bob Peterson	        Disney Plus	11
-- Tim Allen            Disney Plus	11
-- Larry the Cable Guy 	Disney Plus	11
-- Samuel L. Jackson	Netflix		11
-- Takahiro Sakurai		Netflix		11
-- Amitabh Bachchan		Netflix		10

-- 3°
-- Crear un Stored Proceadure que tome como parámetro un año y
-- devuelva una tabla con las 5 películas con mayor duración en minutos.

CREATE OR REPLACE FUNCTION top_5_peliculas_anio(anio integer)
RETURNS TABLE (
	title       VARCHAR,
	duration    VARCHAR
)
AS $$
BEGIN
	RETURN query
		SELECT c.title, c.duration 
		FROM "content" c 
		WHERE c.type_id = 1 AND c.release_year = anio
		ORDER BY 
			CAST(REPLACE(c.duration, ' min', '') AS INTEGER) DESC
		LIMIT 5;
END; $$
LANGUAGE plpgsql

SELECT * FROM top_5_peliculas_anio(2020) 
SELECT * FROM top_5_peliculas_anio(2018)

-- Resultados 2020:
-- Unbreakable Kimmy Schmidt: Kimmy vs. the Reverend  190 min
-- Dory's Reef Cam									  182 min
-- Arendelle Castle Yule Log						  180 min
-- Andhaghaaram										  171 min
-- Andhakaaram										  171 min

