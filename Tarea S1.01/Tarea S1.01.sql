# Nivel I

/*Exercici 2: Realitza la següent consulta: Has d'obtenir el nom, email i país 
de cada companyia, ordena les dades en funció del nom de les companyies.*/

		# -------------------Solución:

SELECT company_name, email, country
FROM company
ORDER BY company_name;

/*Exercici 3: Des de la secció de màrqueting et sol·liciten que els 
passis un llistat dels països que estan fent compres.*/

		# -------------------Solución:

SELECT country
FROM company
INNER JOIN transaction
ON transaction.company_id = company.id
WHERE amount > 0 AND declined = 0
GROUP BY country;

/*Exercici 4: Des de màrqueting també volen saber des de quants països es realitzen 
les compres*/

		# -------------------Solución:

SELECT COUNT(DISTINCT country) No_Paises_Compran
FROM company
INNER JOIN transaction
ON transaction.company_id = company.id
WHERE amount > 0 AND declined = 0;

/*Exercici 5: El teu cap identifica un error amb la companyia que té aneu 'b-2354'. 
Per tant, et sol·licita que li indiquis el país i nom de companyia d'aquest aneu.*/

		# -------------------Solución:

SELECT country, company_name
FROM company
WHERE id = 'b-2354';

/*Exercici 6: A més, el teu cap et sol·licita que indiquis quina és la companyia 
amb major despesa mitjana?*/

		# -------------------Solución:

SELECT company_name, ROUND(AVG(amount), 2) Gasto_medio
FROM company
INNER JOIN transaction
ON transaction.company_id = company.id
GROUP BY company_name
ORDER BY Gasto_medio DESC
LIMIT 1;

# Nivell 2

/*Exercici 1: El teu cap està redactant un informe de tancament 
de l'any i et sol·licita que li enviïs informació rellevant per 
al document. Per a això et sol·licita verificar si en la base 
de dades existeixen companyies amb identificadors (aneu) duplicats.*/

		# -------------------Solución:

SELECT COUNT(*) Cantidad_total_repetidos
FROM (
	SELECT id, COUNT(*) Cantidad_repetidos
    FROM company
    GROUP BY id
    HAVING COUNT(*) > 1) Tabla_repetidos;

/*Ejercicio 2: En quin dia es van realitzar les cinc vendes més costoses? 
Mostra la data de la transacció i la sumatòria de la quantitat de diners.*/

		# -------------------Solución:

SELECT DATE(timestamp) Fecha, SUM(amount) Cantidad_Total
FROM transaction
WHERE declined = 0
GROUP BY Fecha
ORDER BY Cantidad_Total DESC
LIMIT 5;




		# -------------------Otros aprendizajes:

SELECT DAYOFMONTH(timestamp) dia, SUM(amount) suma
FROM transaction
GROUP BY dia
ORDER BY suma DESC
LIMIT 5;

SELECT DAYOFYEAR(timestamp) dia, SUM(amount) suma
FROM transaction
GROUP BY dia
ORDER BY suma DESC
LIMIT 5; 

SELECT CONCAT(DAY(timestamp), ' / ', MONTH(timestamp), ' / ', YEAR(timestamp)) dia, SUM(amount) ventas
FROM transaction
WHERE declined = 0
GROUP BY dia
ORDER BY ventas DESC
LIMIT 5;

SELECT 
	YEAR(TIMESTAMP) year,
    MONTH(TIMESTAMP) month,
    DAY(TIMESTAMP) day,
	HOUR(TIMESTAMP) hour,
    SECOND(TIMESTAMP) second
FROM transaction;

/*Ejercicio 3: Exercici 3 En quin dia es van realitzar les cinc vendes de menor 
valor? Mostra la data de la transacció i la sumatòria de la quantitat de diners.*/

		# -------------------Solución:

SELECT DATE(timestamp) fecha, SUM(amount) cantidad
FROM transaction
WHERE declined = 0
GROUP BY fecha
ORDER BY cantidad ASC
LIMIT 5;

/*Exercici 4: Quina és la mitjana de despesa per país? Presenta els 
resultats ordenats de major a menor mitjà.*/

		# -------------------Solución:

SELECT country, ROUND(AVG(amount),2) average
FROM company
INNER JOIN transaction
ON transaction.company_id = company.id
WHERE declined = 0
GROUP BY country
ORDER BY average DESC;

		# -------------------Otros aprendizajes:
        
SELECT country, ROUND(AVG(amount), 2) average
FROM company
INNER JOIN transaction
ON transaction.company_id = company.id
WHERE declined = 1
GROUP BY country
ORDER BY average DESC;
        
/*Llama la atención que Canada tenga el promedio de transacciones 
declinadas más alto de los paises y a su vez presente la 
posición 5ta en el ranking de ventas no declinadas 
(cuando el valor booleano es 0). Este indicio genera la necesidad
de realizar un analisis más profundo para determinar relaciones 
adicionales que permitan optimizar o explicar el comportamiento 
del dato, si es el caso, monitorear, evaluar la necesidad de 
intervención, asignar un recurso financiero, contruir un objetivo 
SMART* y asignar tareas por sprints al equipo:
Algunos Stakeholders implicados en el compartamiento del indicador 
pueden ser los Departamentos de Marketing, Finanzas y Contabilidad, 
Servicio al Cliente, RRHH, IT Department, entre otros y 
por supuesto de la Dirección Estrategica de empresa.
    
Conclusiones
    
El valor booleano declined es fundamental para generar información de valor a la Dirección Estrategica,
areas funcionales de la empresa y divisiones de negocio.

Permite crear KPIs.
    
* Un objetivo SMART es: un enfoque para establecer objetivos, 
deben ser específicos, medibles, alcanzables, relevantes y 
con un tiempo determinado.
S - Specific M - Measurable A - Achievable R - Relevant T - Time-bound*/

# Nivel 3

/*Ejercicio 1: Presenta el nom, telèfon i país de les companyies, 
juntament amb la quantitat total gastada, d'aquelles que van realitzar 
transaccions amb una despesa compresa entre 100 i 200 euros. Ordena els 
resultats de major a menor quantitat gastada.*/

		# -------------------Solución:

SELECT
		company_name,
        phone,
        country,
        SUM(amount) total_amount
FROM company
INNER JOIN transaction
ON company.id = transaction.company_id
WHERE declined = 0
GROUP BY company_name, phone, country
HAVING total_amount BETWEEN 100 AND 200
ORDER BY total_amount DESC;

/*Ejercicio 2: Indica el nom de les companyies que van fer compres 
el 16 de març del 2022, 28 de febrer del 2022 i 13 de febrer del 2022.*/

		# -------------------Solución:
        
SELECT 
		DATE(timestamp) dia, 
        company_name
FROM company
INNER JOIN transaction
ON transaction.company_id = company.id
WHERE 	declined = 0 
		AND DATE(timestamp) IN ('2022-03-16', '2022-02-13', '2022-02-28')
GROUP BY DATE(timestamp), company_name
ORDER BY dia;

		# -------------------Otros aprendizajes:

/* Las cláusulas en SQL se evalúan en el siguiente orden lógico:

FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
	
Por este motivo no puedo utilizar el alias dia que puse en select
para filtrar por where, debido a que sql lee el codigo select al final
antes de order by y por lo tanto cuando va en where aun no exite
la variable creada con el alias en select, de esta forma
es necesario utilizar DATE(timestamp) para llamar la variable
y poder filtrarla con el WHERE. Sin embargo cuando llego a ORDER BY
si puedo utilizar el alias dia, debido a que previamente sql a creado
la variable en SELECT y esta disponible para su uso. */

/* Para poder escribir comentarios que sean de más de una linea
utilizo /*texto*/ 

