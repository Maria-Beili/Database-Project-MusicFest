USE music_festival; 

#tables to safe data
DROP TABLE IF EXISTS band_bck;
CREATE TABLE band_bck AS SELECT * FROM band WHERE 1=0;
INSERT INTO band_bck
	SELECT * FROM band;

DROP TABLE IF EXISTS song_bck;
CREATE TABLE song_bck AS SELECT * FROM song WHERE 1=0;
INSERT INTO song_bck
	SELECT * FROM song;
    
    
#creation of procedure
DELIMITER //
DROP PROCEDURE IF EXISTS req04_music_festival //

CREATE PROCEDURE req04_music_festival()
BEGIN
    DECLARE type_of_music_less_bands VARCHAR(20);

    #Find the type of music with the least number of bands
    SELECT type_of_music
    INTO type_of_music_less_bands
    FROM (
        SELECT type_of_music, COUNT(*) AS band_count
        FROM band
        GROUP BY type_of_music
        ORDER BY band_count ASC
        LIMIT 1 #to get only the less

    ) AS less_band;

    #Update bands with no songs to the music type with fewer bands
    UPDATE band
    SET type_of_music = type_of_music_less_bands
    WHERE type_of_music IS NOT NULL
    AND NOT EXISTS (
		SELECT 1
        FROM song
        WHERE song.type_of_music = band.type_of_music
    );

END//

DELIMITER ; 

#Example of calling the procedure
CALL req04_music_festival();

SELECT * FROM band; 
SELECT * FROM band_bck; 