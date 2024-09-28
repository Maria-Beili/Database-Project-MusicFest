USE music_festival; 

#creation of procedure
DELIMITER //
DROP PROCEDURE IF EXISTS req01_music_festival //

CREATE PROCEDURE req01_music_festival()
BEGIN
	
    UPDATE staff
    SET years_of_experience = (YEAR(CURRENT_DATE()) - YEAR(hire_date))
    WHERE years_of_experience <> (YEAR(CURRENT_DATE()) - YEAR(hire_date))
		  OR years_of_experience IS NULL; 
    #if it's well calculated we don't need to recalculate

END //

DELIMITER ; 

#call of procedure
CALL req01_music_festival();

#comprovation
SELECT * FROM staff; 