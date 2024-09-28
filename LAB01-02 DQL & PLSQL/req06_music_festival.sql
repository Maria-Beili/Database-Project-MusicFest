USE music_festival; 
SET GLOBAL event_scheduler = ON;

/*
Per a aquest trigger s'havia de cridar el procediment 5 dintre la funció, però com estem fent un update
fora del trigger, no deixa fer-lo dins. 
No hem sigut capaces de solucionar l'error, de manera que hem posat els preus directament (fem el mateix
que hauria fet el procediment)
*/

#create trigger
DELIMITER \\

DROP TRIGGER IF EXISTS req06_music_festival_1\\
DROP TRIGGER IF EXISTS req06_music_festival_2\\

#trigger for table bring
CREATE TRIGGER req06_music_festival_1 
BEFORE UPDATE ON bring
FOR EACH ROW 
BEGIN
	
    DECLARE priceUSD FLOAT(8);
    DECLARE priceEUR FLOAT(8);
    DECLARE priceGBP FLOAT(8);
    DECLARE priceJPY FLOAT(8);
    
    SET priceUSD = NEW.UnitPriceUSD;
    SET priceEUR = NEW.UnitPriceEUR;
    SET priceGBP = NEW.UnitPriceGBP;
    SET priceJPY = NEW.UnitPriceJPY;
    
    #check if it matches exchange ratios --> if it doesn't call procedure
    IF priceEUR IS NULL OR 
       priceGBP IS NULL OR 
       priceJPY IS NULL OR
	   priceEUR <> priceUSD*0.93 OR
       priceGBP <> priceUSD*0.82 OR
       priceJPY <> priceUSD*151.51
    THEN 
		SET NEW.UnitPriceJPY = priceUSD*151.51;
		SET NEW.UnitPriceGBP = priceUSD*0.82;
        SET NEW.UnitPriceEUR = priceUSD*0.93;
        #CALL req05_music_festival(NEW.id_product, @warning);
	END IF;

END \\

#trigger for table offers
CREATE TRIGGER req06_music_festival_2
BEFORE UPDATE ON offers
FOR EACH ROW 
BEGIN
	
    DECLARE priceUSD FLOAT(8);
    DECLARE priceEUR FLOAT(8);
    DECLARE priceGBP FLOAT(8);
    DECLARE priceJPY FLOAT(8);
    
    SET priceUSD = NEW.UnitPriceUSD;
    SET priceEUR = NEW.UnitPriceEUR;
    SET priceGBP = NEW.UnitPriceGBP;
    SET priceJPY = NEW.UnitPriceJPY;
    
    #check if it matches exchange ratios --> if it doesn't call procedure
    IF priceEUR IS NULL OR 
       priceGBP IS NULL OR 
       priceJPY IS NULL OR
	   priceEUR <> priceUSD*0.93 OR
       priceGBP <> priceUSD*0.82 OR
       priceJPY <> priceUSD*151.51
    THEN 
		SET NEW.UnitPriceJPY = priceUSD*151.51;
		SET NEW.UnitPriceGBP = priceUSD*0.82;
        SET NEW.UnitPriceEUR = priceUSD*0.93;
        #CALL req05_music_festival(NEW.id_product, @warning);
	END IF;
    
    
END \\

DELIMITER ; 


SELECT * FROM offers
WHERE id_product = 36;

UPDATE offers
SET UnitPriceUSD = 50
WHERE id_product = 36;

SELECT * FROM offers
WHERE id_product = 36;
