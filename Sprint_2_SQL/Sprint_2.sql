# Nivel 1
# Ejercicio 1

SELECT 
	id, 
    (SELECT company_name FROM company WHERE company_id = id) AS company, 
	credit_card_id, DATE(timestamp), amount, declined, 
	(SELECT country FROM company WHERE company_id = id) AS country
FROM transaction
WHERE company_id IN (	
	SELECT id
	FROM company 
	WHERE country = 'Germany');

# Ejercicio 2

/*Marketing está preparando algunos informes de cierres de gestión,
te piden que les pases un listado de las empresas que
han realizado transacciones por una suma superior a la media de todas las transacciones*/

SELECT 
	id, 
    company_name, 
    phone, 
    email, 
    country, 
    website, 
    (SELECT ROUND(AVG(amount),2) FROM transaction WHERE company.id = transaction.company_id) AS avg_amount
FROM 
    company
WHERE 
    (SELECT ROUND(AVG(amount),2) FROM transaction) <
    (SELECT ROUND(AVG(amount),2) FROM transaction WHERE company.id = transaction.company_id)
ORDER BY 
    avg_amount DESC;
    

/*Ejercicio 3
    
El departamento de contabilidad perdió la información de las transacciones
realizadas por una empresa, pero no recuerdan su nombre, sólo recuerdan que
su nombre iniciaba con la letra c. ¿Cómo puedes ayudarles? Coméntelo acompañándolo
de la información de las transacciones.*/

SELECT 
	company_name, 
    country, 
    'Approved' AS transaction_status,
	(SELECT DATE(timestamp) FROM transaction WHERE company.id = transaction.company_id AND declined = 0) AS transaction_date,
    (SELECT ROUND(amount, 2) FROM transaction WHERE company.id = transaction.company_id AND declined = 0) AS amount
FROM company
WHERE 	company_name IN (
		SELECT company_name
		FROM company
		WHERE company_name LIKE 'C%')

UNION ALL

SELECT 
	company_name, 
    country, 
    'Declined' AS transaction_status,
	(SELECT DATE(timestamp) FROM transaction WHERE company.id = transaction.company_id AND declined = 1) AS transaction_date,
    (SELECT ROUND(amount, 2) FROM transaction WHERE company.id = transaction.company_id AND declined = 1) AS amount
FROM company
WHERE 	company_name IN (
		SELECT company_name
		FROM company
		WHERE company_name LIKE 'C%')
ORDER BY company_name;


/* Ejercicio 4

Eliminaron del sistema las empresas que no tienen transacciones registradas, entrega el listado de estas empresas.*/

SELECT id 
FROM company
WHERE NOT EXISTS	(SELECT company_id
					FROM transaction);
                    
                    
-- ____________________________________________________________________________                   
                    
# Nivel 2

/*Ejercicio 1

En tu empresa, se plantea un nuevo proyecto para lanzar algunas campañas
publicitarias para hacer competencia a la compañía Non Institute.
Para ello, te piden la lista de todas las transacciones realizadas
por empresas que están ubicadas en el mismo país que esta compañía.*/


SELECT 
	(SELECT company_name FROM company WHERE id = company_id) AS company_name,
	(SELECT country FROM company WHERE id = company_id) AS country,
	transaction.*
FROM transaction
WHERE company_id IN (SELECT id 
					FROM company
					WHERE country = (SELECT country
									FROM company
                                    WHERE company_name = 'Non Institute'));

/*Exercici 2
El departamento de contabilidad necesita que encuentres la empresa que ha realizado 
la transacción de mayor suma en la base de datos.*/

SELECT 	*,
		(SELECT MAX(amount) FROM transaction) AS monto_transaccion
FROM company
WHERE id = (SELECT company_id
			FROM transaction
			ORDER BY amount DESC
			LIMIT 1);
            
-- -----------------------------------------------------------------------------------------
               
# Nivel 3

/* Exercici 1
Se están estableciendo los objetivos de la empresa para el próximo trimestre, 
por lo que necesitan una base sólida para evaluar el rendimiento y medir el 
éxito en los diferentes mercados. Para ello, necesitan la lista de países 
cuyo promedio de transacciones sea superior al promedio general.*/

SELECT (SELECT country FROM company c WHERE c.id=t.company_id) AS country,
		ROUND(AVG(amount),2) AS avg_transactions
FROM transaction t
GROUP BY country
HAVING avg_transactions > (
								SELECT AVG(amount) 
								FROM transaction
                                )
ORDER BY avg_transactions DESC;

/* Necesitamos optimizar la asignación de recursos, y dependerá de la capacidad 
operativa requerida. Por lo tanto, te pedimos la información sobre la cantidad 
de transacciones que realizan las empresas. Sin embargo, el departamento de 
recursos humanos es exigente y desea un listado de las empresas 
donde especifiques si tienen más de 4 transacciones o menos.*/

SELECT 	(SELECT company_name FROM company c WHERE c.id=t.company_id) AS company_name,
		company_id,
		SUM(CASE WHEN declined=0 THEN 1 ELSE 0 END) AS approved_transactions,
		IFNULL(SUM(CASE WHEN declined=1 THEN 1 END),0) AS declined_transactions,
		COUNT(*) AS total_transactions, 
        CASE
			WHEN COUNT(*) < 4 THEN 'Menos de 4 transacciones'
            WHEN COUNT(*) = 4 THEN '4 transacciones'
            ELSE 'Más de 4 transacciones'
		END AS total
FROM transaction t
GROUP BY company_id
ORDER BY total_transactions DESC, company_id;