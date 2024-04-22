CREATE DATABASE sprint4;
USE sprint4;

CREATE TABLE companies(
	company_id VARCHAR(255) PRIMARY KEY,
    company_name VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    country VARCHAR(255),
    website VARCHAR(255)
);


/*---------------------------

CREATE TABLE transactions(
	id VARCHAR(255) PRIMARY KEY,
    card_id VARCHAR(255),
    business_id VARCHAR(255),
    timestamp VARCHAR(255),
    amount VARCHAR(255),
    declined VARCHAR(255),
    product_ids VARCHAR(255),
    user_id VARCHAR(255),
    lat VARCHAR(255),
    longitude VARCHAR(255)
    FOREIGN KEY fk_(user_id) REFERENCES users (id);
);

CREATE TABLE transactions(
	id VARCHAR(255),
    card_id VARCHAR(255),
    business_id VARCHAR(255),
    timestamp VARCHAR(255),
    amount VARCHAR(255),
    declined VARCHAR(255),
    product_ids VARCHAR(255),
    user_id VARCHAR(255),
    lat VARCHAR(255),
    longitude VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY fk_(user_id) REFERENCES users (id);
);*/

/*
#Codigo para insertar datos en unta tabla creada

INSERT INTO nombre_tabla(nombre_de_los_campos_separados_por_comas) VALUES('STR',INT) 
*/

SHOW CREATE TABLE companies;
DROP TABLE companies;
SELECT * FROM companies;


CREATE TABLE credit_cards(
	id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    iban VARCHAR(255),
    pan VARCHAR(255),
    pin VARCHAR(255),
    cvv VARCHAR(255),
    track1 VARCHAR(255),
    track2 VARCHAR(255),
    expiring_date VARCHAR(255)
);

CREATE TABLE products(
	id VARCHAR(255) PRIMARY KEY,
    product_name VARCHAR(255),
    price VARCHAR(255),
    colour VARCHAR(255),
    weight VARCHAR(255),
    warehouse_id VARCHAR(255)
);

CREATE TABLE transactions(
	id VARCHAR(255) PRIMARY KEY,
    card_id VARCHAR(255),
    business_id VARCHAR(255),
    timestamp VARCHAR(255),
    amount VARCHAR(255),
    declined VARCHAR(255),
    product_ids VARCHAR(255),
    user_id VARCHAR(255),
    lat VARCHAR(255),
    longitude VARCHAR(255)
);

CREATE TABLE users(
	id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    surname VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    birth_date VARCHAR(255),
    country VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(255),
    address VARCHAR(255)
    
);


#Cuento cuantas tablas hay para saber si he agreagado el número correcto de datasets = 6.

SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'sprint4';

#MODIFICO EL TIPO DE DATOS, DEBE COINCIDIR EL TIPO DE DATOS DE LAS LLAVES FORANEAS Y LAS LLAVES PRIMARIAS. 

#MODIFICACIÓN TIPO DE DATOS TABLA DE HECHOS [Transactions]

ALTER TABLE transactions
MODIFY id VARCHAR(255);

ALTER TABLE transactions
MODIFY card_id VARCHAR(15);


ALTER TABLE transactions
MODIFY business_id VARCHAR(10);

ALTER TABLE transactions
MODIFY timestamp TIMESTAMP;

ALTER TABLE transactions
MODIFY amount DECIMAL(5,2);

ALTER TABLE transactions
MODIFY declined BOOL;

ALTER TABLE transactions
MODIFY product_ids VARCHAR(255);

ALTER TABLE transactions
MODIFY user_id INT;

ALTER TABLE transactions
MODIFY lat FLOAT;

ALTER TABLE transactions
MODIFY longitude FLOAT;

DESCRIBE transactions;

#MODIFICACIÓN TIPO DE DATOS DIMENSIÓN [companies]

ALTER TABLE companies
MODIFY company_id VARCHAR(10);

ALTER TABLE companies
MODIFY company_name VARCHAR(255);

ALTER TABLE companies
MODIFY phone VARCHAR(20);

ALTER TABLE companies
MODIFY email VARCHAR(100);

ALTER TABLE companies
MODIFY country VARCHAR(50);

ALTER TABLE companies
MODIFY website VARCHAR(100);

DESCRIBE companies;

# MODIFICACIÓN TIPO DE DATOS DIMENSIÓN [credit_cards]

ALTER TABLE credit_cards
MODIFY id VARCHAR(15);

ALTER TABLE credit_cards
MODIFY user_id INT;

ALTER TABLE credit_cards
MODIFY iban VARCHAR(100);

ALTER TABLE credit_cards
MODIFY pan VARCHAR(50);

ALTER TABLE credit_cards
MODIFY pin INT;

ALTER TABLE credit_cards
MODIFY cvv INT;

ALTER TABLE credit_cards
MODIFY track1 VARCHAR(255);

ALTER TABLE credit_cards
MODIFY track2 VARCHAR(255);

ALTER TABLE credit_cards
MODIFY expiring_date VARCHAR(50);

DESCRIBE credit_cards;	

# MODIFICACIÓN TIPO DE DATOS DIMENSIÓN [products]

ALTER TABLE products
MODIFY id INT;

ALTER TABLE products
MODIFY product_name VARCHAR(255);

ALTER TABLE products
MODIFY price VARCHAR(25);

ALTER TABLE products
MODIFY colour VARCHAR(50);

ALTER TABLE products
MODIFY weight DECIMAL(5,1);

ALTER TABLE products
MODIFY warehouse_id VARCHAR(25);

DESCRIBE products;


# MODIFICACIÓN TIPO DE DATOS DIMENSIÓN [users]

ALTER TABLE users
MODIFY id INT;

ALTER TABLE users
MODIFY name VARCHAR(50);

ALTER TABLE users
MODIFY surname VARCHAR(100);

ALTER TABLE users
MODIFY phone VARCHAR(50);

ALTER TABLE users
MODIFY email VARCHAR(100);

ALTER TABLE users
MODIFY birth_date VARCHAR(25);

ALTER TABLE users
MODIFY country VARCHAR(50);

ALTER TABLE users
MODIFY city VARCHAR(50);

ALTER TABLE users
MODIFY postal_code VARCHAR(25);

ALTER TABLE users
MODIFY address VARCHAR(255);

DESCRIBE users;


# Creo un Entitie Relationship Diagram EER Diagram con el Reverse Engineer para visualizar la relaciones.

/*El analisis del EER Diagram permite definir visualmente el [modelo de datos indicado(***),
que en este caso corresponde a un modelo en estrella, por su particularidad de tener una sola
tabla de hechos y varias dimensiones. A primera vista se puede decir, respecto a la dimension (users_'country'),
que se puede unir las tres tablas en una sola, si es necesario, agrupando a canada, estados unidos y reino unido.
Por otra parte, conviene advertir que si se unen estan tablas, la granulidad de los datos no es la misma, debido a que 
no se precisan datos de si esta estrella, hará parte de una galaxia y la granulidad de las entidades que 
representan a objetos del mundo real; en este caso una variable compleja como es el 'pais', 
sea necesaria para conocer con mayor profundidad detalles que permitan afinar la estrategia empresarial.*/

/*El término "EER Diagram" significa "Enhanced Entity-Relationship Diagram" en inglés, 
y se traduce como "Diagrama de Entidad-Relación Extendido/Mejorado" en español. Un diagrama EER 
es una representación gráfica de las entidades y las relaciones entre ellas en una base 
de datos, utilizando los conceptos de la modelización de datos de entidad-relación.

El modelo de entidad-relación (ER) es una técnica utilizada para modelar los datos en 
sistemas de bases de datos. Define entidades como objetos en el mundo real y las 
relaciones entre estas entidades. El modelo EER extiende el modelo ER básico al 
incluir conceptos adicionales como la generalización/especialización, la herencia 
y las relaciones de atributo.

En un diagrama EER, las entidades se representan como rectángulos y las relaciones 
entre ellas como líneas que conectan los rectángulos. Además, el modelo EER puede 
incluir otras notaciones gráficas para representar conceptos como la herencia, las 
restricciones de cardinalidad, los atributos, etc.

En el contexto de SQL, un diagrama EER se utiliza como una herramienta de 
diseño para visualizar la estructura de la base de datos y las relaciones entre 
las entidades, lo que ayuda a los desarrolladores y diseñadores a comprender y diseñar el esquema de la base de datos antes de implementarlo.*/

SHOW TABLES FROM sprint4;


/*Una vez establecida la estrella, continuo con la cardinalidad y con la modificación del tipo de dato (ALTER) que inicialmente se estableció como VARCHAR(255).
 
				Ordinalidad/Cardinalidad				Ordinalidad/Cardinalidad					Fact_Table(FT)		Dimension_Table(DT)		FT/DT
				MIN:MAX									MIN:MAX						relación 		PK 					PK						FK		
transactions   	1:1			companies  		0:N			transactions				1:N				id					company_id				business_id
transactions	1:1			credit_cards  	0:N			transactions				1:N				id					id						card_id		
transactions	1:N			products  		0:N			transactions				N:N				id					id						N/A							
transactions	1:1			users  			0:N			transactions				1:N				id					id						user_id							
*/


/*Existe una relación de N:M entre transactions y products, debido a que una transacción esta compuesta por varios productos y un producto puede estar
en varias transacciones, en estos casos se hace uso de una tabla intermedia o puente para romper la relación de N:M, esto se logra creando una tabla 
que contenga la PK de cada una de las dos tablas garantizando la identidad referencial y convirtiendo el modelo en estrella en un modelo
 en copo de nieve o Snowflake

Una vez creada la tabla puente se establecen las FK en dicha tabla con referencia a la clave primaria de las tablas que presentan la realcion N:M*/

/*(***) Los tres tipos de modelos de datos más comunes en el diseño de bases de datos son:

Modelo de Datos en Estrella (Star Schema): En este modelo, los datos están organizados 
en una estructura central de hechos rodeada por varias tablas dimensionales. La tabla de 
hechos contiene las métricas o medidas de interés, mientras que las tablas dimensionales 
contienen atributos descriptivos que proporcionan contexto a las medidas. Esta estructura 
se asemeja a una estrella, con la tabla de hechos en el centro y las tablas 
dimensionales alrededor de ella.

Modelo de Datos Copo de Nieve (Snowflake Schema): Similar al modelo de estrella, 
el modelo de copo de nieve también tiene una tabla de hechos central y tablas dimensionales. 
Sin embargo, en el modelo de copo de nieve, las tablas dimensionales se normalizan aún más, 
dividiéndose en subdimensiones. Esto puede resultar en una estructura más compleja pero también 
puede ofrecer ventajas en términos de eficiencia de almacenamiento y mantenimiento.

Modelo de Datos Galaxia (Galaxy Schema): Aunque menos común que los anteriores, el modelo 
de datos galaxia surge cuando hay múltiples tablas de hechos que comparten las mismas dimensiones. 
En este modelo, hay varias tablas de hechos que se conectan a las mismas tablas dimensionales, 
formando una estructura similar a una galaxia con múltiples sistemas estelares.

Estos modelos de datos son importantes herramientas en el diseño de bases de datos para 
representar y organizar la información de manera eficiente y comprensible.*/

#Creación de tabla puente, o intermedia para eliminar relación N:M


CREATE TABLE transaction_product(
	id_transaction VARCHAR(100),
    id_product INT,
    FOREIGN KEY(id_transaction) REFERENCES transactions(id),	  -- FK tabla puente y tabla hechos
    FOREIGN KEY(id_product) REFERENCES products(id)				-- FK tabla puente y tabla dimensión products												
);


/*Establezco la relaciones de clave foranea en la tabla de hechos (transactions)
las cuales presentan una cardinalidad de 1:N. Con esta acción garantizo
la integridad referencial entre las tablas.*/

ALTER TABLE transactions
	ADD FOREIGN KEY fk_credit_cards(card_id)
    REFERENCES credit_cards(id);
    
ALTER TABLE transactions
	ADD FOREIGN KEY fk_companies(business_id)
    REFERENCES companies(company_id);

ALTER TABLE transactions
	ADD FOREIGN KEY fk_users(user_id)
    REFERENCES users(id);

SHOW CREATE TABlE transactions;


/* determino en donde se encuentra configurado por defecto el almacenaje de los archivos que puedo
cargar como bases de datos y lo modifico para que admita cualquier ubicación"*/

SELECT @@secure_file_priv;


/*Antes de cargar los data sets con codigo no con el import wizard, debo modificar la configuración
del MYSQL, esto lo logro ingresando a la carpeta oculta (ver/mostrar carpetas ocultas) en el disco C 
donde se encuentran alojada la configuración del MYSQL, "C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" 
puedo consultar esta ruta con [SELECT @@secure_file_priv;]. El objetivo es modificar el archivo 'my.ini'
es un bloc de notas, debo buscar con ctrl+b la palabra 'secure', esto me lleva al codigo que indica 
de donde pueden provenir las bases de datos por defecto secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads",
coloco un '#' antes de esta sentencia para que quede como un comentario y en la linea siguiente 
copio el siguiente codigo que me permitirá extraer datos de cualquier ubicación
secure-file-priv="" .Desde 'Servicios' detengo a MYSQL y posteriormente guardo este archivo 
en el escritorio, una vez guardado lo corto y lo pego en "C:\ProgramData\MySQL\MySQL Server 8.0\my.ini"
lo que me permitirá remplazar el archivo que hemos modificado previmente. Reestablezco el servicio 
de MYSQL para poder ejecutar el codigo para cargar los datos. NOTA: tener en cuenta que dependiendo del 
siste Windows, Linux o macOS se puede trabajar para la ruta de un archivo, con el caracter de separación
'\' o '/', en este sentido se debe intentar con estas versiones de ruta:

ejemplo:

'\' : "D:\DIEGO\Desktop\BOOTCAMP\ESPECIALIDAD ANALISIS DE DATOS\MySQL\Sprint 4\Bases S4\companies.csv"

o
'/': "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/companies.csv"

dependerá del sistema operativo como se mencionó anteriormente*/


# Cargo los dataset de los archivos correspondientes.

# ----------------------------------  Carga dataset (companies)

LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/companies.csv"
INTO TABLE companies
FIELDS TERMINATED BY ','
#ENCLOSED BY "'" -- no utilizo esta sentencia, porque la base no lo demanda, la puedo eliminar en este caso
LINES TERMINATED BY'\n' -- \n significa que el salto de una fila define el fin de una serie de datos a la siguiente fila o serie de datos.
IGNORE 1 LINES;

SELECT * FROM companies;


# ------------------------------------Carga dataset (credit_cards)

/*debido a que al copiar la ruta, el caracter de división utilizado es '\' y MYSQL trabaja con 
'/' hago el cambio de esto:
 "D:\DIEGO\Desktop\BOOTCAMP\ESPECIALIDAD ANALISIS DE DATOS\MySQL\Sprint 4\Bases S4\credit_cards.csv"
 de esto: 
 "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/credit_cards.csv"
 */


LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/credit_cards.csv"
INTO TABLE credit_cards
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM credit_cards;

#NOTA: La expiring_date no está en el formato YYYY/MM/DD .Por ahora cargo los datos con VARCHAR, no con DATE.


# -------------------------------------Carga dataset (products)

/* Cambio / por \ asi:
LOAD DATA
INFILE "D:\DIEGO\Desktop\BOOTCAMP\ESPECIALIDAD ANALISIS DE DATOS\MySQL\Sprint 4\Bases S4\products.csv"
INTO TABLE products
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

*/


LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/products.csv"
INTO TABLE products
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM 

/*NOTA: El precio de los productos contiene el simbolo $ por tal motivo no importo la data como un FLOAT con dos
decimales sino como un VARCHAR inicialmente.*/

SHOW CREATE TABLE products;
SELECT * FROM products;




# ------------------------------------------Carga dataset (users)

/* En este caso contamos con los usuarios de tres paises diferentes, Canada, Reino Unido y Estados Unidos
unifico estos tres paises en la tabla users. */


-- Data Set Users Canada : (users_ca)


/* Modifico el tipo de dato de DATE a VARCHAR al campo birth_date debido a que no cumple el formato YYYY-MM-DD, las fechas 
las presenta asi "Mar 20, 2000", se tiene en cuenta para posteriormente estandarizar los formatos de fecha 
que recurrentemente presentan formatos diferetes en las tablas suministradas*/

/*Cambio los slash inclinados a la izquierda por los inclinados a la derecha para que mysql lea la ruta*/

LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/users_ca.csv"
INTO TABLE users
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

/* '\r\n\' \r\n Es una secuencia de escape que representa un salto de línea 
en muchos sistemas informáticos. 

Aquí está su significado y utilidad:

Carácter de retorno (\r): Este carácter, conocido como "carriage return" en inglés, 
es un control de caracteres que mueve el cursor de escritura al principio 
de la línea actual. En algunos sistemas antiguos, como los sistemas basados en 
máquinas de escribir, mover el cursor al principio de la línea permitía escribir 
sobre el texto existente en esa línea.

Carácter de nueva línea (\n): Este carácter, conocido como "line feed" en inglés, 
es otro control de caracteres que mueve el cursor de escritura a la siguiente 
línea en un documento de texto.

\r\n como secuencia de fin de línea: En muchos sistemas operativos modernos, como Windows, 
la combinación \r\n se utiliza como la secuencia de caracteres estándar para representar 
un salto de línea en archivos de texto. Esto significa que al final de cada línea 
en un archivo de texto en Windows, se espera encontrar estos dos caracteres 
para indicar el fin de la línea.

La utilidad de \r\n radica en que proporciona una convención estándar para 
representar saltos de línea en archivos de texto en sistemas Windows. Esto es importante 
para asegurar la portabilidad de archivos entre diferentes plataformas y para garantizar que los 
archivos de texto se muestren correctamente en editores de texto y otros programas.*/


SELECT * FROM users; -- Reviso si cargaron los datos correctamente, comparo el contaje de excel
						-- con el numero de rows que arroja el action output del mysql, para saber
						-- si estan cargando todos de los datos de una forma visual


-- Data Set Users UK : (users_uk)

/*Debido a que la ruta de carga del archivo es la misma para canada, que para uk y usa
porque estan en la misma carpeta, basta con cambiar el final de 
 (users_contry name)
 "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/users_ca.csv"
 por la sigla del pais. ca, uk, usa*/
 
LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/users_uk.csv"
INTO TABLE users
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * FROM users;  -- Reviso si cargaron los datos correctamente


-- Data Set Users USA : (users_usa)

LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/users_usa.csv"
INTO TABLE users
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * FROM users; -- Reviso si cargaron los datos correctamente



# -------------------------------------Carga dataset (transactions)


/* Fue necesario abrir el archivo en el bloc de notas, (formato txt) para poder ver como estaban delimitados los datos
en este caso, se evidencia que aunque aparantemente esta divido por columnas, realmente los datos estan dividos por 
punto y coma, esta es la ventaja de ver los datos como txt.*/

LOAD DATA
INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/transactions.csv"
INTO TABLE transactions
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n' -- debido a que la data esta en columnas no en filas cambio FIELDS TERMINATED BY por COLUMNS TERMINATED BY
IGNORE 1 LINES;

SELECT * FROM transactions;


# -------------------------------------Carga dataset (transaction_product): Tabla Puente

/* Previamente se creó la tabla (transaction_product) con el objetivo de 
poder relacionar la tabla de hechos transactions y la dimensión products, 
y romper la relación de muchos a muchos existente entre estas dos entidades,
sin embargo a la hora de cargar los datos, en la base de datos proporcionada 
como csv, en la tabla transactions se puede observar que los valores de la 
columna products_ids de la tabla transactions presentan diferentes id de 
productos separados por comas dentro de un mismo campo, el objetivo para poder 
llevar estos datos a la tabla puente consiste en presentar el id de transacción 
con un producto no con multiples. Esto permitirá generará en la tabla puente, 
registros de una misma transacción con diferentes productos, 
para poder lograrlo se requerire realizar las siguentes acciones:

1) Crear una tabla temporal que almecene los datos en su forma pura, es decir
con varios productos en una misma transacción.

TABLA TEMPORAL:
Se trata de una tabla que se utiliza para almacenar datos 
temporalmente, y que se borra automáticamente al cerrar la sesión en MySQL. 
Las tablas temporales son útiles para almacenar información 
de manera temporal, como resultados de una consulta compleja.

Las tablas temporales son una herramienta muy útil en el mundo 
de la gestión de base de datos. Sin embargo, es importante recordar 
que los datos almacenados en una tabla temporal se borran automáticamente 
al cerrar la sesión en MySQL. Es fundamental utilizar esta funcionalidad 
con precaución y siempre tener una copia de seguridad de los datos importantes.

Las tablas temporales son herramientas útiles para aquellos que 
necesitan manejar grandes cantidades de información y almacenarla 
de manera efectiva durante un período corto de tiempo. Gracias a 
ellas, podrás ordenar tus datos de manera fácil y rápida, lo que hará 
más sencillo su posterior tratamiento.

Ejemplo de creación de un tabla temporal:

CREATE TEMPORARY TABLE temp_empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT
);

2) Insertar el dataset en la tabla temporal
 desde la tabla de hechos transactions
 
Una forma alternativa de cargarar la data consiste en utilizar el LOAD DATA INFILE
Asi:

LOAD DATA INFILE "D:/DIEGO/Desktop/BOOTCAMP/ESPECIALIDAD ANALISIS DE DATOS/MySQL/Sprint 4/Bases S4/transactions.csv"
INTO TABLE temp_T_P_VARCHAR
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(temp_transaction, @dummy, @dummy, @dummy, @dummy, @dummy, temp_product, @dummy, @dummy, @dummy);

Es importante tener en cuenta en este sentencia, el uso del @dummy:

El uso de @dummy en esta sentencia de carga de datos LOAD DATA INFILE 
en MySQL es una convención para manejar columnas en el archivo CSV 
que no se van a cargar en la tabla de destino.

En este contexto, @dummy es simplemente un nombre de variable de usuario. 
Se usa como marcador de posición para indicar que se está ignorando 
el valor en esa posición del archivo CSV.

Por ejemplo, en la parte (temp_transaction, @dummy, @dummy, @dummy, 
@dummy, @dummy, temp_product, @dummy, @dummy, @dummy), indica que hay 
ocho columnas en el archivo CSV que no se están cargando en la tabla 
temp_T_P_VARCHAR, ya que están representadas por @dummy. 
Estas columnas adicionales en el CSV se están "saltando" 
durante el proceso de carga de datos.

Esta técnica es útil cuando el archivo CSV tiene más columnas 
de las que se necesitan o cuando la estructura del archivo no coincide 
completamente con la estructura de la tabla de destino, permitiendo que 
solo las columnas relevantes se carguen en la tabla mientras se omiten las demás. 

3) Insertar el dataset en la tabla puente desde la tabla 
temporal, realizando la división de productos.

4) Eliminar la tabla temporal, aunque al cerrar mysq se elimina automaticamente*/

    
/* PASO 1) Creo una tabla temporal con tipo de dato VARCHAR debido a que una cadena de numeros
separados por comas se lee como un string.*/

CREATE TEMPORARY TABLE temp_T_P(
		temp_transaction VARCHAR(255),
        temp_product VARCHAR(255)
);

SELECT * FROM temp_T_P; -- Observo que se ha creado adecuadamente, tener encuenta que 
									-- las tablas temporales no se pueden ver en el navigator schemas.
                             
                             
 /*PASO 2: Inserto el dataset para cada fila creada en la tabla temporal
 desde la tabla de hechos transactions, como se emecionó una alternativa
 es con LOAD DATA INFILE*/
 

INSERT INTO temp_T_P(temp_transaction, temp_product)
SELECT id, product_ids
FROM transactions;

/*PASO 3: Insertar el dataset en la tabla puente desde la tabla 
temporal, realizando la división de productos
*/

INSERT INTO transaction_product(id_transaction, id_product)
SELECT 	temp_transaction,
		SUBSTRING_INDEX(SUBSTRING_INDEX(temp_product, ',', numbers.n), ',', -1) AS product_id
FROM temp_T_P
JOIN 	(SELECT 1 AS n
		UNION ALL SELECT 2
        UNION ALL SELECT 3
        UNION ALL SELECT 4) AS numbers -- Esta SELECT genera un tabla de derivada que sirve para 
										-- organizar los registros en una sola columna de 1 a 4 porque
                                        -- cada transacción tiene maximo 4 productos. 
ON CHAR_LENGTH(temp_product) - CHAR_LENGTH(REPLACE(temp_product, ',', '')) >= n -1; -- Resto la longitud de la cadena
-- temp_product y la longitud de la misma cadena sin comas, y genero una condición que debe ser mayor o igual a 
-- n-1 para poder indicar cual es el numero maximo de elementos que tiene una cadena. 

/*SUBSTRING_INDEX() en MySQL Workbench es útil para dividir una 
cadena en subcadenas basadas en un delimitador específico y devolver una parte 
específica de esas subcadenas.

SELECT SUBSTRING_INDEX(CADENA, DELIMITADOR, CONTEO)
SELECT SUBSTRING_INDEX('Juan,María,Pedro', ',', 1);

La función SUBSTRING en MySQL se utiliza para extraer una parte de una cadena de texto. 
Tiene varias formas de uso, pero la forma más común es la siguiente:

SUBSTRING(cadena, inicio [, longitud])

cadena: La cadena de texto de la que deseas extraer una parte.

inicio: La posición de inicio desde la cual comenzar a extraer 
caracteres. La primera posición es 1.

longitud (opcional): La cantidad de caracteres que deseas extraer. 
Si no se proporciona, SUBSTRING extraerá todos los caracteres desde 
la posición de inicio hasta el final de la cadena.
Aquí hay algunos ejemplos para ilustrar cómo funciona SUBSTRING:

SELECT SUBSTRING('Hello World', 7); -- Devuelve 'World'
SELECT SUBSTRING('Hello World', 7, 5); -- Devuelve 'World'
En el primer ejemplo, SUBSTRING('Hello World', 7) extrae todos los caracteres 
de la cadena comenzando desde la posición 7, por lo que devuelve 'World'. 
En el segundo ejemplo, SUBSTRING('Hello World', 7, 5) extrae 5 caracteres 
comenzando desde la posición 7, por lo que también devuelve 'World'.

Es importante tener en cuenta que las posiciones en SUBSTRING 
comienzan desde 1, no desde 0 como en algunos 
otros lenguajes de programación.
*/

/*CHAR_LENGTH():

Se utiliza para devolver la longitud de una cadena de texto en términos de 
caracteres, no de bytes. Detalles de esta función y sus atributos:

Cadena: La cadena de texto de la cual deseas obtener la longitud en caracteres.
Esta función es útil cuando necesitas determinar la longitud real de una cadena 
de texto que puede contener caracteres multibyte, como UTF-8, donde un 
solo carácter puede ocupar más de un byte.

Ejemplo de uso:

SELECT CHAR_LENGTH('Hola, mundo!');
Esto devolverá 11, ya que la cadena 'Hola, mundo!' contiene 11 caracteres.

Es importante tener en cuenta que CHAR_LENGTH() 
cuenta los caracteres, no los bytes. Si necesitas contar los bytes en lugar de los caracteres,
puedes usar la función LENGTH() en lugar de CHAR_LENGTH(). La diferencia radica en cómo manejan 
los caracteres multibyte. CHAR_LENGTH() los cuenta como un solo carácter, 
mientras que LENGTH() cuenta los bytes.*/

/*La función REPLACE() en MySQL Workbench se utiliza para reemplazar todas las ocurrencias 
de una subcadena dentro de una cadena más grande con otra subcadena especificada. 
Aquí tienes los detalles de esta función y sus atributos:

Atributos de REPLACE():

cadena_original: La cadena en la que deseas realizar el reemplazo.
subcadena_a_reemplazar: La subcadena que deseas reemplazar.
nueva_subcadena: La subcadena que deseas usar para reemplazar la subcadena original.
La función REPLACE() busca todas las ocurrencias de subcadena_a_reemplazar 
dentro de cadena_original y las reemplaza con nueva_subcadena.

Ejemplo de uso:

SELECT REPLACE('Hola mundo, hola todos', 'hola', 'adiós');
Este comando devolverá 'Adiós mundo, adiós todos', ya que todas 
las ocurrencias de 'hola' en 'Hola mundo, hola todos' han sido reemplazadas por 'adiós'.

Es importante destacar que REPLACE() distingue entre mayúsculas y minúsculas. 
Si necesitas realizar un reemplazo sin tener en cuenta la distinción 
entre mayúsculas y minúsculas, puedes usar la función REPLACE() junto con 
las funciones LOWER() o UPPER() para convertir la cadena a minúsculas 
o mayúsculas antes de realizar el reemplazo.*/



SELECT * FROM transaction_product; -- Confirmo que he cargado correctamente los datos en la tabla puente



/*PASO 4) Eliminar la tabla temporal, aunque al cerrar mysq se elimina automaticamente*/

DROP TEMPORARY TABLE temp_T_P;



# NIVEL 1

/* Ejercicio 1

Realiza una subconsulta que muestre a todos los usuarios con más de 30 transacciones utilizando al menos 2 tablas.*/

# Usuarios con más de 30 transacciones no declinadas o aceptadas
SELECT 	users.id, 
		name,
        surname,
        city,
        country,
		COUNT(transactions.user_id) AS no_transactions
FROM users
JOIN transactions ON users.id = transactions.user_id 
GROUP BY 
		users.id, 
        users.name, 
        users.surname, 
        users.city, 
        users.country
HAVING no_transactions >= 30;

# Número de usuarios mayor a 30 transacciones aceptadas

SELECT COUNT(*) AS no_users_30
FROM (SELECT 	users.id, 
		name,
        surname,
        city,
        country,
		COUNT(transactions.user_id) AS no_transactions
FROM users
JOIN transactions ON users.id = transactions.user_id
#WHERE declined = 0
GROUP BY 
		users.id, 
        users.name, 
        users.surname, 
        users.city, 
        users.country
HAVING no_transactions >= 30) AS users_30;

#numero de usuarios con al menos una transaccion aceptada

SELECT COUNT(transactions.user_id) AS total_usuarios
FROM transactions;



# Ratio clientes con mas de 30 transaciones aceptadas del total de clientes
        
SELECT no_users_30 / total_usuarios AS ratio
FROM
    (SELECT COUNT(*) AS no_users_30
    FROM (SELECT 	users.id, 
					name,
					surname,
					city,
					country,
					COUNT(transactions.user_id) AS no_transactions
			FROM users
			JOIN transactions ON users.id = transactions.user_id
			#WHERE declined = 0
			GROUP BY 
					users.id, 
					users.name, 
					users.surname, 
					users.city, 
					users.country
			HAVING no_transactions >= 30) AS users_30) AS users_30_count, -- este resultado es igual a 3
            
		(SELECT COUNT(transactions.user_id) AS total_usuarios -- este resultado es igual a 500
		FROM transactions) AS total_usuarios_count;
        
        
/* Ejercio 2

Muestra la media de amount por IBAN de las tarjetas de crédito en la compañía Donec Ltd., utiliza por lo menos 2 tablas.*/

SELECT company_name, iban, ROUND(AVG(amount),2) AS media
FROM  credit_cards
JOIN transactions ON transactions.card_id = credit_cards.id
JOIN companies ON transactions.business_id = companies.company_id
WHERE company_name = 'Donec Ltd'
GROUP BY company_name, iban;

#NIVEL 2

/*Crea una nueva tabla que refleje el estado de las tarjetas de crédito basado en si las últimas
 tres transacciones fueron declinadas y genera la siguiente consulta:*/

# Paso 1: Creo la tabla que va acontener los datos requeridos.

CREATE TABLE credit_cards_status(
		card_id VARCHAR(15) PRIMARY KEY,
        status VARCHAR(15),
        FOREIGN KEY fk_credit_cards_status(card_id) REFERENCES credit_cards(id)
);

#Paso 2: Inserto en la tabla los datos

INSERT INTO credit_cards_status (card_id, status)
SELECT 
    card_id,
    CASE 
        WHEN SUM(declined) >= 3 THEN 'Inactiva'
        ELSE 'Activa'
    END AS status
FROM (
    SELECT 
        card_id, 
        declined,
        ROW_NUMBER() OVER (PARTITION BY card_id ORDER BY timestamp DESC) AS fr
    FROM 
        transactions
) AS last_transactions
WHERE 
    fr <= 3
GROUP BY 
    card_id;

SELECT * FROM credit_cards_status; -- Confirmo que se haya realizado adecuadamente el cargue de los datos.

/*Ejercicio 1

¿Cuántas tarjetas están activas?*/

SELECT COUNT(card_id) AS tarjetas_activas
FROM credit_cards_status;


/*
# NIVEL 3
Crea una tabla con la que podamos unir los datos del nuevo archivo products.csv con la base de datos creada,
teniendo en cuenta que desde transaction tienes product_ids. Genera la siguiente consulta:

Ejercicio 1
Necesitamos conocer el número de veces que se ha vendido cada producto.*/

#Ejercicio 1. Necesitamos conocer el número de veces que se ha vendido cada producto. 

SELECT product_transaction.product_id as codi_producte, products.product_name as producte, count(product_transaction.product_id) as TT_Unitats
FROM product_transaction
JOIN products ON products.id = product_transaction.product_id
GROUP BY 1
ORDER BY 3 DESC;


#Ejercicio 1. Necesitamos conocer el número de veces que se ha vendido cada producto. 

SELECT product_name, COUNT(id_product) total_products
FROM products p
JOIN transaction_product t_p ON t_p.id_product = p.id
GROUP BY product_name
ORDER BY total_products DESC;



# ---------------------------------------Aprendizajes

# Cuenta el número de tablas que hay en una base de datos(schema) 

SELECT COUNT(*) AS total_tablas
FROM information_schema.tables
WHERE table_schema = 'nombre_de_la_base_de_datos';

# e.g.

SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'sprint4';


# Cambia el nombre de una tabla
ALTER TABLE nombre_tabla RENAME TO nuevo_nombre_tabla;
ALTER TABLE users_ca RENAME TO users;

# Agregar una FK
ALTER TABLE tabla_de_hechos
	ADD FOREIGN KEY fk_nombre(columna_definida_como_fk_de_tabla_hechos)
	REFERENCES tabla_dimension (columna_PK_de_tabla_dimension);

# Agregar una PK
ALTER TABLE nombre_tabla
ADD PRIMARY KEY (nombre_columna);

# Usar una base
USE sprint4;

# Muestra las caractisticas por columna de una tabla
SHOW COLUMNS FROM transaction_product;


# Cambia el nombre de una tabla
ALTER TABLE nombre_tabla RENAME TO nuevo_nombre_tabla;

#Para eliminar una clave foranea
ALTER TABLE nombre_tabla DROP FOREIGN KEY nombre_clave_foranea; 
-- el nombre de la clave foranea lo encuentro con [SHOW CREATE nombre de la tabla;], 
-- usualmente tiene una nomeclatura de este tipo: "nombre_tabla_ibfk_1", no es el nombre que uno establece.


#Para eliminar los datos de una tabla
DELETE FROM nombre_de_la_tabla;

#Elimina los datos de una tabla y libera el espacio que ocupó en el disco
TRUNCATE TABLE users;

#Para eliminar la tabla
DROP TABLE nombre_tabla;


#Permite determinar la configuración por defecto de donde almacenan los datset que pueden cargarse a SQL
SELECT @@secure_file_priv;

#Permite activar y desactivar las FK
SET FOREIGN_KEY_CHECKS = 0; -- Desactiva FK
SET FOREIGN_KEY_CHECKS = 1; -- Activa FK

#FUNCIÓN: FIND_IN_SET()

/*La función FIND_IN_SET() en MySQL busca una cadena dentro
de una lista de cadenas separadas por comas y devuelve la 
posición (índice) de la cadena si la encuentra, o 0 si no 
la encuentra. Aquí tienes los detalles de esta función 
y sus atributos:

Atributos de FIND_IN_SET():

cadena_buscada: La cadena que deseas buscar 
dentro de la lista.
lista: La lista de cadenas separadas por comas 
en la que deseas buscar la cadena.
La función FIND_IN_SET() busca la cadena cadena_buscada 
dentro de la lista lista y devuelve la posición de la cadena si se encuentra, o 0 si no se encuentra.

Ejemplo de uso:

SELECT FIND_IN_SET('manzana', 'manzana,naranja,pera,uva');
Este comando buscará 'manzana' dentro de la lista 'manzana,naranja,pera,uva'. 
Como 'manzana' está en la primera posición de la lista, la función devolverá 1.

Es importante tener en cuenta que FIND_IN_SET() 
distingue entre mayúsculas y minúsculas. Si necesitas 
realizar una búsqueda sin tener en cuenta la distinción 
entre mayúsculas y minúsculas, deberás asegurarte de que tanto 
la cadena buscada como la lista estén en el mismo formato 
de capitalización o convertirlas a un formato común 
antes de usar la función.
