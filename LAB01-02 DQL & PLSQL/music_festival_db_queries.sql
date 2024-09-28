USE music_festival;

/*
A la query 1 ens sortia un nombre d'esquirols decimal: 175139.5. Ho hem aproximat al nombre de dalt
amb ceil() perquè no podem fer servir mig esquirol. 
*/
DROP VIEW IF EXISTS query_1;
CREATE VIEW query_1 AS
SELECT CEIL(COUNT(id_festivalgoer) * 200 / 400) AS required_squirrels
FROM festivalgoer
WHERE glass=false;
-- Total: 1 rows

SELECT * FROM query_1;


DROP VIEW IF EXISTS query_2;
CREATE VIEW query_2 AS
SELECT P.nationality, COUNT(DISTINCT id_festivalgoer) AS total_attendants
FROM festivalgoer AS F
INNER JOIN person AS P ON F.id_festivalgoer=P.id_person
GROUP BY P.nationality 
ORDER BY P.nationality;
-- Total: 243 rows

SELECT * FROM query_2;


DROP VIEW IF EXISTS query_3;
CREATE VIEW query_3 AS
SELECT DISTINCT *
FROM festivalgoer AS F
INNER JOIN person AS P ON P.id_person = F.id_festivalgoer
WHERE F.spicy_tolerant=false AND F.health_status="dizzy" 
ORDER BY P.id_person ASC;
-- Total: 87725 rows

SELECT * FROM query_3;


DROP VIEW IF EXISTS query_4;
CREATE VIEW query_4 AS
SELECT DISTINCT *
FROM person AS P 
INNER JOIN festivalgoer AS F ON P.id_person = F.id_festivalgoer
WHERE F.id_festivalgoer NOT IN (SELECT id_festivalgoer FROM purchase)
	  AND F.id_festivalgoer IN (SELECT id_festivalgoer FROM attend)  
ORDER BY P.id_person;
-- Total: 10423 rows			
	
SELECT * FROM query_4;


DROP VIEW IF EXISTS query_5;
CREATE VIEW query_5 AS
SELECT *
FROM band AS b1
WHERE b1.name_band IN ( SELECT b2.name_band
						FROM band AS b2
						GROUP BY b2.name_band
						HAVING count(*)>1);
-- Total: 69 rows

SELECT * FROM query_5;


DROP VIEW IF EXISTS query_6;
CREATE VIEW query_6 AS
SELECT DISTINCT F.id_festivalgoer, F.vegeterian, F.gluten_free, F.spicy_tolerant, F.alcohol_free, F.health_status, F.glass, B.festival_name, B.festival_edition, B.id_stage
FROM festivalgoer AS F
NATURAL JOIN buy AS B
WHERE (F.gluten_free = true AND F.alcohol_free = true AND F.health_status = "wasted")
ORDER BY id_festivalgoer;
-- Total: 1008 rows

SELECT * FROM query_6;


DROP VIEW IF EXISTS query_7;
CREATE VIEW query_7 AS
SELECT CM.id_manager, CM.is_freelance, P.name_person, P.surname, P.nationality, P.birth_date, S.hire_date, S.contract_expiration_date, S.years_of_experience, M.name_festival, SM.platform_name, SM.followers
FROM community_manager AS CM
INNER JOIN manage AS M ON M.id_manager = CM.id_manager
INNER JOIN social_media_account AS SM ON M.account_name = SM.account_name AND M.platform_name = SM.platform_name
INNER JOIN person AS P ON P.id_person = CM.id_manager
INNER JOIN staff AS S ON S.id_staff = CM.id_manager
WHERE CM.is_freelance = TRUE 
	  AND M.name_festival = "Creamfields"
      AND SM.followers BETWEEN 500000 AND 700000
ORDER BY CM.id_manager ASC;
-- Total: 6 rows

SELECT * FROM query_7;


DROP VIEW IF EXISTS query_8;
CREATE VIEW query_8 AS
SELECT BM.id_beerman, P.name_person, P.surname, P.nationality, P.birth_date, count(*)*0.33 AS litres_sold
FROM beerman AS BM
INNER JOIN buy AS B ON B.id_beerman = BM.id_beerman
INNER JOIN person AS P ON BM.id_beerman = P.id_person
WHERE B.festival_name="Primavera Sound"
GROUP BY BM.id_beerman
ORDER BY litres_sold DESC;
-- Total: 2000 rows

SELECT * FROM query_8; 


/*
Query 9.1 --> Pregunta normal: Songs by Rosalia
Query 9.2 --> EXTRA: Total seconds among all songs in 9.1
*/
DROP VIEW IF EXISTS query_9_1;
CREATE VIEW query_9_1 AS
SELECT P.festival_name, P.festival_edition, P.stage_number, CO.song_title, CO.song_ordinality
FROM compose_of AS CO
INNER JOIN play AS P ON P.id_show = CO.id_show
WHERE P.name_band = "Rosalia"
ORDER BY CO.id_show;
-- Total: 129 rows

SELECT * FROM query_9_1;


DROP VIEW IF EXISTS query_9_2;
CREATE VIEW query_9_2 AS
SELECT P.name_band, sum(S.duration) AS total_seconds
FROM compose_of AS CO
INNER JOIN play AS P ON P.id_show = CO.id_show
INNER JOIN song AS S ON S.title = CO.song_title AND CO.song_version = S.song_version AND S.written_by = CO.author_name
WHERE name_band = "Rosalia"
GROUP BY P.name_band;
-- Total: 1 rows

SELECT * FROM query_9_2;


DROP VIEW IF EXISTS query_10;
CREATE VIEW query_10 AS
SELECT EP.id_provider, EP.name_provider, EP.address, EP.phone, EP.email, EP.country
FROM external_provider AS EP
INNER JOIN bring AS B ON EP.id_provider = B.id_provider
INNER JOIN food AS F ON B.id_product = F.id_food		
INNER JOIN consume AS C ON F.id_food = C.id_product
INNER JOIN buy ON C.id_festivalgoer = buy.id_festivalgoer
WHERE F.is_veggie = TRUE AND buy.festival_name = 'Tomorrowland'
GROUP BY EP.id_provider
ORDER BY EP.id_provider ASC;
-- Total: 42 rows

SELECT * FROM query_10;


DROP VIEW IF EXISTS query_11;
CREATE VIEW query_11 AS
SELECT DISTINCT CO.id_show, sum(S.duration) AS "total_duration"
FROM compose_of AS CO
INNER JOIN song AS S 
ON (CO.song_title = S.title AND CO.song_version = S.song_version AND CO.author_name = S.written_by)
GROUP BY CO.id_show
ORDER BY sum(S.duration) DESC;
-- Total: 1620 rows

SELECT * FROM query_11;


/*
Respecte la query 12: 
Podem veure que algun percentage és més alt que el 100%.
Creiem que això té sentit perquè estem considerant que TOTS els festivalgoers que van al festival aniran 
a l'escenari a la vegada. Això és molt poc improbable, gairebé impossible. 
Creiem que és molt possible que un escenari tingui una capacitat més petita que el nombre de persones
que van al festival. 

Hem fet una comprovació d'un dels escenaris que té més d'un 100% i, efectivament, hi ha més persones que
hi van que la capacitat d'un dels escenaris. 
*/
DROP VIEW IF EXISTS query_12;
CREATE VIEW query_12 AS
SELECT S.festival_name, S.festival_edition, S.id_stage, 100*count(DISTINCT P.id_festivalgoer)/S.capacity AS percentage
FROM stage AS S
INNER JOIN purchase AS P ON P.festival_name = S.festival_name AND P.festival_edition = S.festival_edition
GROUP BY S.festival_name, S.festival_edition, S.id_stage;
-- Total: 186 rows

SELECT * FROM query_12;

/*La query 13 retorna 0 rows perquè no hi ha cap festivalgoer que hagi anat a les 10 edicions de
Primavera Sound*/
DROP VIEW IF EXISTS query_13;
CREATE VIEW query_13 AS
SELECT P.name_person, P.surname
FROM festivalgoer AS F
INNER JOIN person AS P ON P.id_person = F.id_festivalgoer
WHERE (SELECT count(T.id_ticket) AS num_of_primavera_editions
	   FROM purchase AS T
	   WHERE T.festival_name="Primavera Sound" AND T.id_festivalgoer = F.id_festivalgoer
       GROUP BY id_festivalgoer
	   HAVING num_of_primavera_editions = 10) IS NOT NULL;
-- Total: 0 rows


SELECT * FROM query_13;

/*
A la query 14 - dir els staff que estan unemployed - no surt cap beerman perquè tots han vengut
alguna cosa. Hem comprovat que els DISTINCT id_beerman de buy és igual als id_beerman de beerman.
(N'hi ha 2000)
*/
DROP VIEW IF EXISTS query_14;
CREATE VIEW query_14 AS
SELECT staff_type, COUNT(*) AS count_of_unemployed
FROM (
	(SELECT 'Beerman' AS staff_type
     FROM beerman
     WHERE  NOT exists (SELECT id_beerman FROM buy WHERE buy.id_beerman = beerman.id_beerman))
	UNION ALL
	(SELECT 'Bartender' AS staff_type
     FROM bartender
     WHERE NOT EXISTS (SELECT id_bartender FROM bar WHERE bar.id_bar = bartender.works))
	UNION ALL
    (SELECT 'Security' AS staff_type
     FROM security_personal
     WHERE NOT EXISTS (SELECT id_security FROM stage WHERE stage.id_stage = security_personal.patrols_stage))
	UNION ALL
    (SELECT 'Community Manager' AS staff_type
     FROM community_manager
     WHERE NOT EXISTS (SELECT id_manager FROM manage WHERE manage.id_manager = community_manager.id_manager))
	) AS unemployed_staff
GROUP BY staff_type
ORDER BY count_of_unemployed DESC;
-- Total: 3 rows

SELECT * FROM query_14;


DROP VIEW IF EXISTS query_15;
CREATE VIEW query_15 AS
SELECT count(id_staff) AS 'number of workers' 
FROM staff
WHERE id_staff IN ((SELECT DISTINCT id_security FROM security_personal 
					WHERE name_festival="Primavera Sound")
                    UNION
				   (SELECT DISTINCT b.id_beerman FROM beerman
					NATURAL JOIN buy AS b
					WHERE b.festival_name="Primavera Sound")
                    UNION 
				   (SELECT DISTINCT M.id_manager FROM community_manager
					NATURAL JOIN manage AS M
					WHERE M.name_festival="Primavera Sound"));
-- Total: 1 rows

SELECT * FROM query_15;


/*
A la query 16 hem tingut molts problemes. Hem provat de fer-ho de moltes formes diferents perquè
les consumicions no depenen dels festivals i, aleshores, ens sortia la informació repetida d'una forma
o una altra. Al final ho hem tractat com diferents selects i els hem ajuntat tots en un.
Sabem que probablement no és la forma més eficaç, però és la que millor ens ha funcionat.

Hem comprovat els resultats fent altres queries i són correctes. 
*/
DROP VIEW IF EXISTS query_16;
CREATE VIEW query_16 AS
SELECT T.id_festivalgoer, T.festivals_attended, T.total_expenses_tickets, Co.consumptions, Co.total_expenses_consumptions, B.beers_bought, B.total_expenses_beer
FROM 
	(SELECT P.id_festivalgoer, COUNT(DISTINCT P.festival_name) AS festivals_attended, SUM(P.price) AS total_expenses_tickets
    FROM purchase AS P
    WHERE P.id_festivalgoer = 27916) AS T #tickets information
LEFT JOIN 
	(SELECT C.id_festivalgoer, COUNT(C.id_consume) AS consumptions, SUM(O.bar_unit_price) AS total_expenses_consumptions
    FROM consume AS C 
    INNER JOIN offers AS O ON O.id_product = C.id_product AND O.id_bar = C.id_bar
    WHERE C.id_festivalgoer = 27916) AS Co ON T.id_festivalgoer = Co.id_festivalgoer #consumptions information
LEFT JOIN 
	(SELECT BU.id_festivalgoer, COUNT(DISTINCT BU.id_beerman) AS beers_bought, COUNT(DISTINCT BU.id_beerman) * 3 AS total_expenses_beer
    FROM buy AS BU 
    WHERE BU.id_festivalgoer = 27916) AS B ON T.id_festivalgoer = B.id_festivalgoer; #beer information
-- Total: 1 rows

SELECT * FROM query_16;
