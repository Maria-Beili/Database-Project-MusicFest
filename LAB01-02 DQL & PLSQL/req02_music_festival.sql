USE music_festival; 

/*
Hem posat que l'event comenci el primer dia de desembre a les 8 del matí (ja ha passat).
Això s'anirà repetint cada més a les 8.00h.
No té END perquè posa l'enunciat que no acaba. 
*/
CREATE EVENT IF NOT EXISTS req02_music_festival
ON SCHEDULE EVERY 1 MONTH
STARTS "2023-12-01 8:00:00"
DO CALL req01_music_festival();