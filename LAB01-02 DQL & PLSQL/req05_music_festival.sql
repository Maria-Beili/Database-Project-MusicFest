USE music_festival; 

#DDL actions 
#1. rename price to UnitPriceUSD
ALTER TABLE bring 
RENAME COLUMN price TO UnitPriceUSD;

ALTER TABLE offers
RENAME COLUMN bar_unit_price TO UnitPriceUSD;

#2. add fields
ALTER TABLE bring
ADD COLUMN (UnitPriceEUR FLOAT(12), 
			UnitPriceGBP FLOAT(12),
            UnitPriceJPY FLOAT(12));

ALTER TABLE offers
ADD COLUMN (UnitPriceEUR FLOAT(12), 
			UnitPriceGBP FLOAT(12),
            UnitPriceJPY FLOAT(12));


#creation of procedure
DELIMITER //
DROP PROCEDURE IF EXISTS req05_music_festival //

CREATE PROCEDURE req05_music_festival(IN identifier INT, OUT warning VARCHAR(200))
BEGIN
	SET warning ='';
    #first check if it's not a valid product
    IF identifier < 0 THEN
		SET warning = "Warning: Not a valid product ID";
	END IF; 
        
    #check whether identifier is 0 --> if it is then recalculate for all rows    
    IF identifier = 0 THEN 
		
		UPDATE bring
        SET UnitPriceEUR = UnitPriceUSD*0.93,
			UnitPriceGBP = UnitPriceUSD*0.82,
            UnitPriceJPY = UnitPriceUSD*151.51
		WHERE UnitPriceUSD IS NOT NULL;
        
        UPDATE offers
        SET UnitPriceEUR = UnitPriceUSD*0.93,
			UnitPriceGBP = UnitPriceUSD*0.82,
            UnitPriceJPY = UnitPriceUSD*151.51
		WHERE UnitPriceUSD IS NOT NULL;
    END IF;
    
    #finally check if identifier is a product
    IF identifier > 0 THEN
		
        #check if product exists in bring
        IF (SELECT count(*) FROM bring WHERE id_product = identifier)>0 THEN 
			UPDATE bring
			SET UnitPriceEUR = UnitPriceUSD*0.93,
				UnitPriceGBP = UnitPriceUSD*0.82,
				UnitPriceJPY = UnitPriceUSD*151.51
			WHERE id_product = identifier AND UnitPriceUSD IS NOT NULL;
		ELSE
			SET warning = "Warning: product doesn't exist in this table";
		END IF;
        
        #check if product exists in offers
        IF (SELECT count(*) FROM offers WHERE id_product = identifier)>0 THEN 
			UPDATE offers
			SET UnitPriceEUR = UnitPriceUSD*0.93,
				UnitPriceGBP = UnitPriceUSD*0.82,
				UnitPriceJPY = UnitPriceUSD*151.51
			WHERE id_product = identifier AND UnitPriceUSD IS NOT NULL;
		ELSE
			SET warning =  "Warning: product doesn't exist in this table";
		END IF;
    END IF;

END //

DELIMITER ; 

#call of procedure with id_product = 24
CALL req05_music_festival(24, @warning);
SELECT @warning;

#comprovation --> first check if all have been updated correctly
SELECT * FROM bring
WHERE id_product = 24; 
SELECT * FROM offers
WHERE id_product = 24;

#then check if all others are null
SELECT * FROM bring;
SELECT * FROM offers;

#check if warning works
CALL req05_music_festival(-1, @warning);
SELECT @warning;

#check if 0 works
CALL req05_music_festival(0, @warning);
SELECT * FROM bring;
SELECT * FROM offers;
SELECT @warning;