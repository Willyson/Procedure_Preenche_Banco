/*
	PROCEDURE PARA PREENCHER QUALQUER BASE DE DADOS 

	RESTRIÇÕES:
	1- NAO DEVE TER IDENTITY
	2- COLUNAS DO TIPO CHAR SERÃO TODAS PREENCHIDAS E APENAS COM LETRAS
*/


/*==== SELECIONAR TABELAS DO USUARIO ==== */

USE DB_IMOVEIS

DECLARE 
	@BASE VARCHAR(50) = 'DB_IMOVEIS',
	@SQL  VARCHAR(100) = ''


/*
	TABELAS FILHAS
*/
SELECT 
	DISTINCT OBJECT_NAME(f.parent_object_id) AS table_name      
	INTO #TMP_TABLES_FILHAS
FROM sys.foreign_keys AS f  
INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id

/*
	TABELAS PAI
*/

SELECT 
	NAME, 
	object_id
	INTO #TMP_TABLES_PAI
FROM sys.all_objects T 
WHERE TYPE = 'U' AND schema_id = 1 AND NAME NOT IN (SELECT TABLE_NAME FROM #TMP_TABLES_FILHAS) 


SELECT P.name,
TYPE_NAME(user_type_id) AS TIPO_DADO,
C.NAME,
C.max_length
FROM SYS.all_columns C 
INNER JOIN #TMP_TABLES_PAI P ON (C.object_id = P.object_id)





DROP TABLE #TMP_TABLES_FILHAS
DROP TABLE #TMP_TABLES_PAI