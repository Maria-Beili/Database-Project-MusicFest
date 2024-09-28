USE music_festival;

##LOADES OF DATA
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/person_v1.csv" -- Place your data files into @@datadir path
INTO TABLE person -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line 

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/social_accounts_v1.csv'
INTO TABLE temp_social_media_account
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/vendor_v1.csv'
INTO TABLE vendor
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/ticket_v1.csv'
INTO TABLE temp_ticket
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/festival_stage_v1.csv'
INTO TABLE temp_stage
COLUMNS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/festivalgoer_v1.csv" -- Place your data files into @@datadir path
INTO TABLE festivalgoer -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/band_v1.csv" -- Place your data files into @@datadir path
INTO TABLE band -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/artist_v1.csv" -- Place your data files into @@datadir path
INTO TABLE artist -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first lineç

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/band_collab_v1.csv" -- Place your data files into @@datadir path
INTO TABLE band_collaboration -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/bar_products_v1.csv" -- Place your data files into @@datadir path
INTO TABLE temp_bar_product -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/staff_v1.csv" -- Placeyourdatafilesinto@@datadirpath
INTO TABLE temp_staff -- Destinationtable
COLUMNS TERMINATED BY ";" -- Thespecialcharacterusedtoseparatecols
OPTIONALLY ENCLOSED BY '"' -- IncaseofVARCHARenclosedbetween“”
LINES TERMINATED BY '\n' -- Howtherowsareseparated
IGNORE 1 LINES;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/show_song_v1.csv" -- Place your data files into @@datadir path
INTO TABLE temp_show_song -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/provides_v1.csv" -- Place your data files into @@datadir path
INTO TABLE temp_provides -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

SELECT * From temp_show_song;
##TABLES
#person Table
SELECT * FROM person;

#vendor Table
SELECT * FROM vendor;

#ticket Table
INSERT INTO ticket(id_ticket, type_ticket, barcode, start_date, end_date)
SELECT DISTINCT id_ticket, ticket_type, barcode, start_date, end_date 
FROM temp_ticket WHERE id_ticket IS NOT NULL;

SELECT * FROM ticket;

#music_festival Table
INSERT INTO music_festival(name_festival, edition_number, start_date, end_date, host_city, short_description)
SELECT DISTINCT festival_name, festival_edition, start_time, end_time, city, festival_description
FROM temp_stage;

SELECT * FROM music_festival;

#social_media_platform Table
INSERT INTO social_media_platform (platform_name, impact_index)
SELECT DISTINCT platform_name, impact_index
FROM temp_social_media_account WHERE platform_name IS NOT NULL;

SELECT * FROM social_media_platform;

#social_media_account Table
INSERT INTO social_media_account (platform_name, account_name, followers, creation_date)
SELECT DISTINCT platform_name, account_name, followers, creation_date
FROM temp_social_media_account WHERE (platform_name IS NOT NULL AND account_name IS NOT NULL);

SELECT * FROM social_media_account;

#festivalgoer table
SELECT * FROM festivalgoer;

#band table
SELECT * FROM band;

#artist table
SELECT * FROM artist;

#bar Table
INSERT INTO bar(id_bar, name_bar, is_foodtruck, is_indoor)
SELECT DISTINCT id_bar, name_bar, is_foodtruck, is_indoor
FROM temp_bar_product WHERE id_bar IS NOT NULL;

SELECT * FROM bar;

#product Table
INSERT INTO product(id_product, name_product, product_description)
SELECT DISTINCT id_product, name_food, description_food 
FROM temp_bar_product WHERE id_product IS NOT NULL;

SELECT * FROM product;

#food table
INSERT INTO food(id_food, is_veggie, is_gluten, is_spicy)
SELECT DISTINCT id_food, is_veggie, is_gluten, is_spicy
FROM temp_bar_product WHERE id_food IS NOT NULL;

SELECT * FROM food;

#beverages table
INSERT INTO beverage(id_beverage, is_alcohol, is_ice, is_hot)
SELECT DISTINCT id_beverage, is_alcohol, is_hot, is_served_with_ice
FROM temp_bar_product WHERE id_beverage IS NOT NULL;

SELECT * FROM beverage;

#staff Table
INSERT INTO staff(id_staff, hire_date, contract_expiration_date, years_of_experience)
SELECT DISTINCT id_staff, hire_date, contract_expiration_date, years_experience
FROM temp_staff;

SELECT * FROM staff;

#beerman Table
INSERT INTO beerman(id_beerman, beer_tank_capacity)
SELECT DISTINCT id_beerman, tank_capacity
FROM temp_staff WHERE id_beerman IS NOT NULL;

SELECT * FROM beerman;

#bartender Table
INSERT INTO bartender(id_bartender, cock_tail_master_certificate, cock_meals, works)
SELECT DISTINCT id_bartender, is_cocktail_master, is_cooker, id_bar  
FROM temp_staff WHERE id_bartender IS NOT NULL;

SELECT * FROM bartender;

#stage Table
INSERT INTO stage(id_stage, festival_name, festival_edition, name_stage, capacity)
SELECT DISTINCT id_stage, festival_name, festival_edition, common_name, capacity
FROM temp_stage;

SELECT * FROM stage;

#security Table
INSERT INTO security_personal(id_security, wears_arm, knows_martial_arts, name_festival, edition_number, patrols_stage)
SELECT DISTINCT id_security, is_armed, knows_martial_arts, festival_name, festival_edition, id_stage
FROM temp_staff WHERE id_security IS NOT NULL;

SELECT * FROM security_personal;

#comunity manager Table
INSERT INTO community_manager(id_manager, is_freelance)
SELECT DISTINCT id_community_manager, is_freelance
FROM temp_staff WHERE id_community_manager IS NOT NULL;

SELECT * FROM community_manager;


#song Table
INSERT INTO song(title, song_version, written_by, release_date, type_of_music, album)
SELECT DISTINCT title, version, written_by, release_date, type_of_music, album
FROM temp_show_song;

SELECT * FROM song;

#show1 Table
INSERT INTO show1(id_show, start_date, end_date)
SELECT DISTINCT id_show, start_date, end_date
FROM temp_show_song WHERE id_show IS NOT NULL;

SELECT * FROM show1;

#external_provider Table
INSERT INTO external_provider(id_provider, name_provider, address, phone, email, country)
SELECT DISTINCT id_provider, provider_name, provider_address, provider_phone, provider_email, provider_base_country
FROM temp_provides WHERE id_provider IS NOT NULL;

SELECT * FROM external_provider;

##RELATIONS
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/festivalgoer_friends_v1.csv" -- Placeyourdatafilesinto@@datadirpath
INTO TABLE hangout -- Destinationtable
COLUMNS TERMINATED BY ";" -- Thespecialcharacterusedtoseparatecols
OPTIONALLY ENCLOSED BY '"' -- IncaseofVARCHARenclosedbetween“”
LINES TERMINATED BY '\n' -- Howtherowsareseparated
IGNORE 1 LINES;

#hang out friends table
SELECT * FROM hangout;

#purchase Table
INSERT INTO purchase (id_ticket, festival_name, festival_edition, id_vendor, price)
SELECT DISTINCT id_ticket, festival_name, festival_edition, id_vendor, price 
FROM temp_ticket;

SELECT * FROM purchase;

#band collaboration Table
SELECT * FROM band_collaboration;

# compose of Table
INSERT INTO compose_of(id_show, song_ordinality, song_title, song_version, author_name)
SELECT DISTINCT id_show, ordinality_show_song , title, version, written_by
FROM temp_show_song;

SELECT * FROM compose_of;

#play Table
INSERT INTO play(id_show, name_band, band_country, festival_name, festival_edition, stage_number)
SELECT DISTINCT id_show, name_band, band_country, festival_name, festival_edition, id_stage
FROM temp_show_song;

SELECT * FROM play;

#manage Table
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/community_manager_account_festival_v1.csv" -- Place your data files into @@datadir path
INTO TABLE manage -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

SELECT * FROM manage;

#consume table
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/festivalgoer_consumes_v1.csv" -- Place your data files into @@datadir path
INTO TABLE consume -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

SELECT * FROM consume;

#bring Table
INSERT INTO bring(id_provide, id_bar, id_product, id_provider, price, order_date, delivery_date, quantity)
SELECT DISTINCT id_provides, id_bar, id_product, id_provider, unit_price, order_date, delivery_date, quantity
FROM temp_provides;

SELECT * FROM bring;

#attend Table
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/festivalgoer_show_v1.csv" -- Place your data files into @@datadir path
INTO TABLE attend -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

SELECT * FROM attend;

#buy Table
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Data/music_festival_data_v1/beerman_sells_v1.csv" -- Place your data files into @@datadir path
INTO TABLE temp_beerman_sells -- Destination table
COLUMNS TERMINATED BY ';' -- The special character used to separate cols
OPTIONALLY ENCLOSED BY '"' -- In case of VARCHAR enclosed between “”
LINES TERMINATED BY '\n' -- How the rows are separated
IGNORE 1 LINES; -- To avoid the header on first line

INSERT INTO buy(id_beerman, id_festivalgoer, festival_name, festival_edition, id_stage)
SELECT DISTINCT id_beerman, id_festivalgoer, festival_name, festival_edition, id_stage
FROM temp_beerman_sells;

SELECT * FROM buy;

