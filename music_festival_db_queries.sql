USE music_festival;

DROP VIEW IF EXISTS query_4;

CREATE VIEW query_4 AS
	SELECT *
    FROM person 
    INNER JOIN festivalgoer ON person.id_person = festivalgoer.id_festivalgoer
	WHERE festivalgoer.id_festivalgoer NOT IN (SELECT id_festivalgoer FROM attend);
				
	
-- Total: 500 rows
select * From query_4;

DROP VIEW IF EXISTS query_9;

CREATE VIEW query_9 AS
	SELECT stage.id_stage, stage.festival_name, stage.festival_edition, stage.name_stage, stage.capacity, compose_of.son_title, compose_of.song_ordinality
    FROM  stage
    INNER JOIN compose_of ON compose_of.id_show = play.id_show
    WHERE play.name_band = "Rosalia";



-- Total:
select * From query_9;

select * from stage;

DROP VIEW IF EXISTS query_10;
CREATE VIEW query_10 AS
	SELECT      external_provider.id_provider,  external_provider.name_provider,  external_provider.address,  external_provider.phone,  external_provider.email,  external_provider.country
    FROM   external_provider
	INNER JOIN
		bring ON external_provider.id_provider = bring.id_provider
	INNER JOIN
		product ON bring.id_product = product.id_product
	INNER JOIN
		food ON product.id_product = food.id_food		
	INNER JOIN
		consume ON product.id_product = product.id_product
	INNER JOIN
		buy ON consume.id_festivalgoer = buy.id_festivalgoer
	WHERE
		food.is_veggie = TRUE AND
		buy.festival_name = 'Tomorrowland'
	group by external_provider.id_provider
	ORDER BY
		external_provider.id_provider ASC;
	
-- Total:
select * From query_10;

DROP VIEW IF EXISTS query_14;
CREATE VIEW query_14 AS
SELECT staff_type, COUNT(*) AS count_of_unemployed
FROM (
	SELECT 'Beerman' AS staff_type
    FROM beerman
    WHERE  NOT EXISTS (SELECT id_beerman FROM buy WHERE buy.id_beerman = beerman.id_beerman)
 
	union all
    
	SELECT 'Bartender' AS staff_type
    FROM bartender
    WHERE NOT EXISTS (SELECT id_bartender FROM bar WHERE bar.id_bar = bartender.works)


    UNION ALL

    SELECT 'Security' AS staff_type
    FROM security_personal
    WHERE NOT EXISTS (SELECT id_security FROM stage WHERE stage.id_stage = security_personal.patrols_stage)

  UNION ALL

    SELECT 'Community Manager' AS staff_type
    FROM community_manager
   WHERE NOT EXISTS (SELECT id_manager FROM manage WHERE manage.id_manager = community_manager.id_manager)
    
    
) AS unemployed_staff
GROUP BY staff_type
ORDER BY count_of_unemployed DESC;

select * From query_14;

DROP VIEW IF EXISTS query_16;
CREATE VIEW query_16 AS
SELECT 
	festivalgoer.id_festivalgoer,  SUM(product.price) AS beer_spending #, SUM(purchase.price) AS ticket_spending, SUM(product.price) AS beer_spending, SUM(buy.price) AS bar_consumption_spending, SUM( purchase.price) + SUM(product.price) + SUM(buy.price) AS total
FROM 
    festivalgoer 
LEFT JOIN 
    buy ON festivalgoer.id_festivalgoer = buy.id_festivalgoer
LEFT JOIN 
    beerman ON buy.id_beerman = beerman.id_beerman
LEFT JOIN 
    product ON beerman.id_beerman = product.id_product
WHERE festivalgoer.id_festivalgoer = 27577
GROUP BY 
    festivalgoer.id_festivalgoer, festivalgoer.name_person;

select * From query_16;
select * From festivalgoer;