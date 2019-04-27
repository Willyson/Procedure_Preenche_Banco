/*
	PROCEDURE DE N�MERO ALEAT�RIO

	HOW TO USE 

DECLARE @NUM_SAIDA INT

EXECUTE NUMERO_ALEATORIO 1,10, @NUM = @NUM_SAIDA OUTPUT

SELECT @NUM_SAIDA

*/
USE DB_IMOVEIS
GO

IF EXISTS (SELECT 1 FROM SYS.ALL_OBJECTS WHERE TYPE = 'P' AND NAME = 'NUMERO_ALEATORIO')
BEGIN 
	DROP PROCEDURE NUMERO_ALEATORIO
END
GO

CREATE PROCEDURE NUMERO_ALEATORIO(@MIN INT, @MAX INT, @NUM INT OUTPUT)
	AS
	BEGIN

		IF (@MIN = @MAX) 
		BEGIN
			SET @NUM = @MIN
		END
		ELSE
		BEGIN
			SELECT @NUM = ROUND(((@MAX - @MIN) * RAND() + @MIN),0)	
		END
END
GO