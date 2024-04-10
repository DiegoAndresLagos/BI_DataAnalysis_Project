# SPRINT 2
# NIVEL 1

USE transactions;

/*Exercici 1
Mostra totes les transaccions realitzades per empreses d'Alemanya.*/

SELECT transaction.id transaction_ID, company_name, credit_card_id, DATE(timestamp) date, amount, declined, country
FROM company
JOIN transaction
ON company.id = transaction.company_id
WHERE company_id IN (SELECT id
		FROM company 
		WHERE country = 'Germany');


SELECT id, (SELECT company_name FROM company WHERE transaction.company_id = company.id) AS company, 
		credit_card_id, DATE(timestamp), amount, declined, 
        (SELECT country FROM company WHERE transaction.company_id = company.id) AS country
FROM transaction
WHERE company_id IN (	
        SELECT id
		FROM company 
		WHERE country = 'Germany');



/*- Exercici 2
Màrqueting està preparant alguns informes de tancaments de gestió, 
et demanen que els passis un llistat de les empreses que 
han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.*/

SELECT company.id, company_name, phone, email, country, website, SUM(amount) average_amount
FROM company
JOIN transaction
ON company.id = transaction.company_id
GROUP BY company.id, company_name, phone, email, country, website
HAVING	SUM(amount) >
		(SELECT ROUND(AVG(amount),2)
		FROM transaction)
ORDER BY average_amount DESC;


/*Exercici 3
El departament de comptabilitat va perdre la informació de les transaccions 
realitzades per una empresa, però no recorden el seu nom, només recorden que 
el seu nom iniciava amb la lletra c. Com els pots ajudar? Comenta-ho acompanyant-ho 
de la informació de les transaccions.*/


SELECT company_name, country, DATE(timestamp), ROUND(amount, 1) amount, declined
FROM company
JOIN transaction
ON company.id = transaction.company_id
WHERE 	company_name IN (
		SELECT company_name
		FROM company
		WHERE company_name LIKE 'C%')
ORDER BY company_name;

/* Exercici 4
Van eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.*/


SELECT id 
FROM company
WHERE NOT EXISTS	(SELECT company_id
					FROM transaction);
                    
                    
# NIVEL 2

/* Exercici 1
En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes 
publicitàries per a fer competència a la companyia Non Institute. 
Per a això, et demanen la llista de totes les transaccions realitzades 
per empreses que estan situades en el mateix país que aquesta companyia.*/


SELECT company.id, company_name, phone, email, country, website, transaction.id, DATE(timestamp) date, amount, declined
FROM company
JOIN transaction
ON company.id = transaction.company_id
WHERE (country = (SELECT country
				FROM company
				WHERE company_name = 'Non Institute'));
                
/*Exercici 2
El departament de comptabilitat necessita que trobis l'empresa que ha 
realitzat la transacció de major suma en la base de dades.*/

SELECT company.id, company_name, phone, email, country, website, amount
FROM company
JOIN transaction
ON company.id = transaction.company_id
WHERE amount = (SELECT MAX(amount)
				FROM transaction);
                
                
# Nivel 3

/* Exercici 1
S'estan establint els objectius de l'empresa per al següent trimestre, 
per la qual cosa necessiten una base sòlida per a avaluar el rendiment 
i mesurar l'èxit en els diferents mercats. Per a això, necessiten el llistat 
dels països la mitjana de transaccions dels quals 
sigui superior a la mitjana general.*/



SELECT country, ROUND(AVG(amount),2) AVG_Country
FROM company
JOIN transaction
ON company.id = transaction.company_id
GROUP BY country
HAVING AVG_Country > (SELECT AVG(amount)
					FROM transaction)
ORDER BY AVG_Country DESC;

/*Exercici 2
Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa 
que es requereixi, per la qual cosa et demanen la informació sobre 

****la quantitat de transaccions que realitzen les empreses***

però el departament de recursos humans és exigent i vol un 

***llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys***.*/


SELECT company.id, company_name, COUNT(transaction.id) no_transactions, 
		CASE -- Crea una nueva columna y su valores dependerán de las condiciones [WHEN (condición) THEN (resultado)] utilizadas
			WHEN COUNT(transaction.id) > 4 THEN '> 4 transactions'
            WHEN COUNT(transaction.id) BETWEEN 0 AND 4 THEN '< = 4 transactions'
            ELSE 'Any transactions'
		END AS 'groups' -- Finaliza el CASE y asigna un nombre a dicha columna que en este caso es groups.
FROM transaction
JOIN company
ON company.id = transaction.company_id
GROUP BY company_id
ORDER BY no_transactions DESC;









                    
                    











                
                







        
        

