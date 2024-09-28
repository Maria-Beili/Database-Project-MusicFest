USE music_festival; 

#tables to safe data
DROP TABLE IF EXISTS bartender_bck;
CREATE TABLE bartender_bck AS SELECT * FROM bartender WHERE 1=0;
INSERT INTO  bartender_bck
	SELECT * FROM bartender;

DROP TABLE IF EXISTS security_bck;
CREATE TABLE security_bck AS SELECT * FROM security_personal WHERE 1=0;
INSERT INTO security_bck
	SELECT * FROM security_personal;

DROP TABLE IF EXISTS bar_bck;
CREATE TABLE bar_bck AS SELECT * FROM bar WHERE 1=0;
INSERT INTO  bar_bck
	SELECT * FROM bar;

DROP TABLE IF EXISTS stage_bck;
CREATE TABLE stage_bck AS SELECT * FROM stage WHERE 1=0;
INSERT INTO stage_bck
	SELECT * FROM stage;
    
DELIMITER //
DROP PROCEDURE IF EXISTS req03_music_festival //

CREATE PROCEDURE req03_music_festival(IN new_staff_id INT, IN staff_type varchar(20))
BEGIN
	#first we find which bars have less bartenders assigned and security member
	DECLARE bars_less_bartenders VARCHAR(20);
	DECLARE stage_less_security VARCHAR(20);
	
    IF staff_type = 'bartender' THEN
		SELECT id_bar
		INTO  bars_less_bartenders
        FROM bar
		order by(SELECT COUNT(*) FROM bartender WHERE works = bar.id_bar)
        LIMIT 1; #to get only the one with less bartenders
        
         #Assign new bartender to one of the bars with less assigned bartenders
         UPDATE bartender 
         SET works = bars_less_bartenders
         WHERE id_bartender = new_staff_id;

	#do the same for security personal
	ELSEIF staff_type  = 'security_personal' THEN
		SELECT id_stage
		INTO stage_less_security
        FROM stage
		ORDER BY (SELECT COUNT(*) FROM security_personal WHERE patrols_stage = stage.id_stage)
		LIMIT 1;
        
         UPDATE security_personal
         SET patrols_stage = stage_less_security
         WHERE id_security = new_staff_id;

	END IF;
    
END//

DELIMITER ; 

#One trigger for bartender and one for security before they are inserted automatically.
DROP TRIGGER IF EXISTS req03_insert_bartender;
DELIMITER //
CREATE TRIGGER req03_insert_bartender 
BEFORE INSERT ON bartender
FOR EACH ROW
BEGIN
    IF NEW.works IS NULL THEN
        CALL req03_music_festival(NEW.id_bartender, 'bartender');
    END IF;
END //
DELIMITER ;


DROP TRIGGER IF EXISTS req03_insert_security;
DELIMITER //
CREATE TRIGGER req03_insert_security 
BEFORE INSERT ON security_personal
FOR EACH ROW
BEGIN
		IF NEW.patrols_stage IS NULL THEN
			CALL req03_music_festival(NEW.id_security, 'security');
		END IF;
END //
DELIMITER ;

CALL req03_music_festival(995000, 'bartender');


INSERT INTO bartender
	VALUES (995000, 1, 1, 88);

SELECT * FROM bartender;
SELECT * FROM bartender_bck;

SELECT * FROM bar;

INSERT INTO security_personal
	VALUES (994003, TRUE, TRUE, 'Tomorrowland', 2019, 1);

SELECT * FROM security_personal;
SELECT * FROM security_bck;


SELECT * FROM stage;
