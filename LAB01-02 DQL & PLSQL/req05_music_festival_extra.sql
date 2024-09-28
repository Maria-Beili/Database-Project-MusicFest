USE music_festival; 

#EXTRA: Create table to store currency exchanges
/*
Per a guardar els canvis de monedes, hem creat una nova taula: "currency_exchanges". Aquesta taula 
té com a PK els dos països entre els quals estem guardant el canvi monetari i el ratio entre ells. 
Hem omplert la taula amb els valors de l'enunciat per a poder utilitzar-la al procedure. 
Un cop omplerta, cada cop que es vulgui canviar el ratio simplement s'ha de modificar la taula. 
*/

DROP TABLE IF EXISTS currency_exchanges;
CREATE TABLE currency_exchanges(
    country1 VARCHAR(3),
    country2 VARCHAR(3),
    exchange_ratio FLOAT(8),
    CONSTRAINT pk_exchange primary key (country1,country2)       
);

INSERT INTO currency_exchanges(country1, country2, exchange_ratio)
VALUES  ("USD", "EUR", 0.93),
		("USD", "GBP", 0.82),
        ("USD", "JPY", 151.51);
        
SELECT * FROM currency_exchanges; 

#tornem a crear procedure que utilitzi la taula
DELIMITER //
DROP PROCEDURE IF EXISTS req05_music_festival_extra //

CREATE PROCEDURE req05_music_festival_extra(IN identifier INT)
BEGIN
	
    #variables per guardar els ratios
    DECLARE exchange_eur FLOAT(8);
    DECLARE exchange_gbp FLOAT(8);
    DECLARE exchange_jpy FLOAT(8);
    
    #omplim les variables
    SET exchange_eur = (SELECT exchange_ratio FROM currency_exchanges 
						WHERE country1="USD" AND country2="EUR");
    
    SET exchange_gbp = (SELECT exchange_ratio FROM currency_exchanges 
						WHERE country1="USD" AND country2="GBP");
                        
	SET exchange_jpy = (SELECT exchange_ratio FROM currency_exchanges 
						WHERE country1="USD" AND country2="JPY");
    
    
    #fem el mateix procediment que abans
    IF identifier < 0 THEN
		SELECT "Warning: Not a valid product ID";
	END IF; 
        
    IF identifier = 0 THEN 
		#canviem els ratios per les variables
		UPDATE bring
        SET UnitPriceEUR = UnitPriceUSD*exchange_eur,
			UnitPriceGBP = UnitPriceUSD*exchange_gbp,
            UnitPriceJPY = UnitPriceUSD*exchange_jpy
		WHERE UnitPriceUSD IS NOT NULL;
        
        UPDATE offers
        SET UnitPriceEUR = UnitPriceUSD*exchange_eur,
			UnitPriceGBP = UnitPriceUSD*exchange_gbp,
            UnitPriceJPY = UnitPriceUSD*exchange_jpy
		WHERE UnitPriceUSD IS NOT NULL;
    END IF;
    
    IF identifier > 0 THEN
        #aquí també canviem exchange per la variable
        IF (SELECT count(*) FROM bring WHERE id_product = identifier)>0 THEN 
			UPDATE bring
			SET UnitPriceEUR = UnitPriceUSD*exchange_eur,
				UnitPriceGBP = UnitPriceUSD*exchange_gbp,
				UnitPriceJPY = UnitPriceUSD*exchange_jpy
			WHERE id_product = identifier AND UnitPriceUSD IS NOT NULL;
		ELSE
			SELECT "Warning: product doesn't exist in this table";
		END IF;
        
        IF (SELECT count(*) FROM offers WHERE id_product = identifier)>0 THEN 
			UPDATE offers
			SET UnitPriceEUR = UnitPriceUSD*exchange_eur,
				UnitPriceGBP = UnitPriceUSD*exchange_gbp,
				UnitPriceJPY = UnitPriceUSD*exchange_jpy
			WHERE id_product = identifier AND UnitPriceUSD IS NOT NULL;
		ELSE
			SELECT "Warning: product doesn't exist in this table";
		END IF;
    END IF;

END //

DELIMITER ; 

#call of procedure with id_product = 52 --> un diferent per mirar que funciona
CALL req05_music_festival_extra(52);

#comprovation --> first check if all have been updated correctly
SELECT * FROM bring
WHERE id_product = 52; 
SELECT * FROM offers
WHERE id_product = 52;

#then check if all others are null
SELECT * FROM bring;
SELECT * FROM offers;
