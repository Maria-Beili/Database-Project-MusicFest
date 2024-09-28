USE music_festival; 

SET GLOBAL event_scheduler = ON;

#creation of event
CREATE EVENT IF NOT EXISTS req07_music_festival
ON SCHEDULE EVERY 1 DAY
STARTS "2023-11-15 8:00:00"
ENDS "2024-01-31 00:00:00"
DO CALL req05_music_festival(0);
