USE music_festival; 

-- Create the procedure to export the report
DELIMITER //
DROP PROCEDURE IF EXISTS Requeriment_8 //

CREATE PROCEDURE Requeriment_8()
BEGIN
    -- Export the report to the @@datadir directory
    SELECT 'festival_name', 'festival_edition', 'festivalgoer_count' -- Column names
    UNION
    SELECT purchase.festival_name, purchase.festival_edition, COUNT(purchase.id_festivalgoer) AS festivalgoer_count
    INTO OUTFILE 'Requeriment_8.csv'
    FIELDS TERMINATED BY ';'
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    FROM ticket
    LEFT JOIN purchase ON ticket.id_ticket = purchase.id_ticket
    GROUP BY purchase.festival_name, purchase.festival_edition
    ORDER BY festivalgoer_count DESC;
END //

DELIMITER ;


CALL Requeriment_8();