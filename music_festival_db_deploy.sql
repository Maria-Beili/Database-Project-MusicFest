DROP SCHEMA IF EXISTS music_festival;
CREATE DATABASE IF NOT EXISTS music_festival
DEFAULT CHARACTER SET 'utf8mb4'
DEFAULT COLLATE 'utf8mb4_general_ci';
USE music_festival;


DROP TABLE IF EXISTS music_festival;
CREATE TABLE music_festival (
	name_festival VARCHAR(40),
    edition_number int(4),
    start_date date,
    end_date date,
    host_city VARCHAR(20),
    short_description VARCHAR(300),
    constraint pk_music_festival primary key (edition_number, name_Festival)
);

#if not we can't reference it - there is an error
CREATE INDEX idx_name_festival ON music_festival(name_festival);
CREATE INDEX idx_edition_number ON music_festival(edition_number);

DROP TABLE IF EXISTS person;
CREATE TABLE person(
	id_person  INT(7),
	name_person VARCHAR(100),
    surname VARCHAR(100),
    nationality VARCHAR(100),
    birth_date DATE,
    constraint pk_id_person primary key (id_person)
);

DROP TABLE IF EXISTS staff;
CREATE TABLE staff(
	id_staff INT(7),
    hire_date VARCHAR(20),
    contract_expiration_date VARCHAR(20),
    years_of_experience INT(2),
    constraint pk_id_staff primary key (id_staff),
    constraint fk_id_staff foreign key (id_staff) REFERENCES person(id_person)
);

DROP TABLE IF EXISTS festivalgoer;
CREATE TABLE festivalgoer(
	id_festivalgoer INT(7),
    vegeterian boolean,
    gluten_free boolean,
    spicy_tolerant boolean,
	alcohol_free boolean,
    health_status VARCHAR(10),
    glass boolean,
    constraint pk_id_festivalgoer primary key (id_festivalgoer),
    constraint fk_id_festivalgoer foreign key (id_festivalgoer) REFERENCES person(id_person)
);

DROP TABLE IF EXISTS band;
CREATE TABLE band(
	name_band varchar(50),
    country varchar(30),
    type_of_music varchar(20),
    bio varchar(300),
    is_solo_artist boolean,
    constraint pk_band PRIMARY KEY (name_band, country)
);

DROP TABLE IF EXISTS artist;
CREATE TABLE artist(
	id_artist INT(7),
    short_bio VARCHAR(300),
    preferred_instrument VARCHAR(20),
    band_name VARCHAR(50),
    band_country VARCHAR(30),
    constraint pk_id_artist primary key (id_artist),
    constraint fk_id_artist foreign key (id_artist) REFERENCES person(id_person),
    constraint fk_band foreign key (band_name, band_country) REFERENCES band(name_band, country)
);

DROP TABLE IF EXISTS community_manager;
CREATE TABLE community_manager(
	id_manager INT(7),
    is_freelance boolean,
    constraint pk_id_manager primary key (id_manager),
    constraint fk_id_manager foreign key (id_manager) REFERENCES staff(id_staff)
);

DROP TABLE IF EXISTS bar;
CREATE TABLE bar(
	id_bar int(4),
    name_bar char(40),
    is_foodtruck boolean,
    is_indoor boolean,
    constraint pk_bar primary key (id_bar)
);

DROP TABLE IF EXISTS bartender;
CREATE TABLE bartender(
	id_bartender INT(7),
    cock_tail_master_certificate VARCHAR(40),
    cock_meals VARCHAR(40),
    works int(4),
    constraint pk_id_bartender primary key (id_bartender),
    constraint fk_id_bartender foreign key (id_bartender) REFERENCES staff(id_staff),
    constraint fk_works foreign key (works) REFERENCES bar(id_bar)
);

DROP TABLE IF EXISTS stage;
CREATE TABLE stage(
	id_stage int(4),
    festival_name VARCHAR(40),
    festival_edition int(4),
    name_stage char(100),
    capacity int(6),
	constraint pk_stage primary key (id_stage, festival_name, festival_edition),
	constraint fk_stage_festival FOREIGN KEY (festival_name, festival_edition) REFERENCES music_festival(name_festival, edition_number)
);

DROP TABLE IF EXISTS security_personal;
CREATE TABLE security_personal(
	id_security INT(10),
    wears_arm boolean,
    knows_martial_arts boolean,
    name_festival VARCHAR(40),
    edition_number int(4),
    patrols_stage int(4),
    constraint pk_id_security primary key (id_security),
    constraint fk_id_security foreign key (id_security) REFERENCES staff(id_staff),
    constraint fk_sec_stage foreign key (patrols_stage, name_festival, edition_number) REFERENCES stage(id_stage, festival_name, festival_edition)
);

DROP TABLE IF EXISTS beerman;
CREATE TABLE beerman(
	id_beerman INT(10),
    beer_tank_capacity VARCHAR(3),
    constraint pk_id_beerman primary key (id_beerman),
    constraint fk_id_beerman foreign key (id_beerman) REFERENCES staff(id_staff)
);
    
DROP TABLE IF EXISTS external_provider;
CREATE TABLE external_provider(
	id_provider int(2),
    name_provider char(50),
    address varchar(100),
    phone varchar(20),
    email varchar(100),
    country char(25),
    constraint pk_external_provider primary key (id_provider)
);
    
DROP TABLE IF EXISTS product;
CREATE TABLE product(
	id_product int(2),
    name_product char(20),
    product_description varchar(100),
    constraint pk_product primary key (id_product)
);  
    
DROP TABLE IF EXISTS beverage;
CREATE TABLE beverage(
	id_beverage int(4),
    is_alcohol boolean,
    is_ice boolean,
    is_hot boolean,
    constraint pk_Beverage primary key (id_beverage),
    constraint fk_beverage FOREIGN KEY (id_beverage) REFERENCES product(id_product)
    );
    
DROP TABLE IF EXISTS food;
CREATE TABLE food(
	id_food int(4),
    is_veggie boolean,
    is_gluten boolean,
    is_spicy boolean,
    constraint pk_food PRIMARY KEY (id_food),
    constraint fk_food FOREIGN KEY (id_food) REFERENCES product(id_product)
    );

DROP TABLE IF EXISTS social_media_platform;
CREATE TABLE social_media_platform(
	impact_index VARCHAR(40),
    platform_name VARCHAR(40),
    constraint pk_platfornm_name primary key (platform_name)
);

DROP TABLE IF EXISTS social_media_account;
CREATE TABLE social_media_account (
	platform_name VARCHAR(100),
	account_name VARCHAR(100),
    creation_date DATE,
	followers INT(10),
    constraint pk_social_media_account primary key (account_name, platform_name),
	constraint fk_social_platform_name foreign key (platform_name) REFERENCES social_media_platform(platform_name)
);

DROP TABLE IF EXISTS ticket;
CREATE TABLE ticket (
	id_ticket INT(10),
    type_ticket VARCHAR(40), 
    barcode VARCHAR(40), 
    start_date date, 
    end_date date,
    constraint pk_id_ticket primary key (id_ticket)
);

DROP TABLE IF EXISTS vendor;
CREATE TABLE vendor (
	id_vendor INT(7),
    name_vendor VARCHAR(20), 
    type_vendor VARCHAR(40),
    constraint pk_id_vendor primary key (id_vendor)
);

DROP TABLE IF EXISTS show1;
CREATE TABLE show1(
	 id_show int(2),
     start_date date,
     end_date date,
	constraint pk_show primary key (id_show)
);

DROP TABLE IF EXISTS song;
CREATE TABLE song(
	title varchar(100),
    song_version int(4),
    written_by varchar(100),
    release_date date,
    type_of_music varchar(50),
    album varchar(25),
    constraint pk_song primary key (title, song_version, written_by)
);

###RELATIONS###

DROP TABLE IF EXISTS hangout;
CREATE TABLE hangout(
	friend1 int(7),
    friend2 int(7),
    name_festival VARCHAR(40),
    edition_number INT(2),
    constraint pk_friend primary key (friend1, friend2, name_festival, edition_number),
    constraint fk_hangout_festival foreign key (name_festival, edition_number) REFERENCES music_festival (name_festival, edition_number),
    constraint fk_friend1 foreign key (friend1) references festivalgoer(id_festivalgoer),
    constraint fk_friend2 foreign key (friend2) references festivalgoer(id_festivalgoer)
);


DROP TABLE IF EXISTS buy;
CREATE TABLE buy(
	id_beerman INT(7),
    id_festivalgoer INT(7),
    festival_name VARCHAR(40),
    festival_edition int(4),
	id_stage INT(4),
    constraint pk_id_stage_person_buy primary key (id_beerman, id_festivalgoer, festival_name, festival_edition, id_stage),
    constraint fk_stage_number_buy foreign key (id_stage, festival_name, festival_edition) REFERENCES stage(id_stage, festival_name, festival_edition),
    constraint fk_id_beerman_buy foreign key (id_beerman) REFERENCES beerman(id_beerman),
    constraint fk_id_festivalgoer_buy foreign key (id_festivalgoer) REFERENCES person(id_person)
);

DROP TABLE IF EXISTS attend;
CREATE TABLE attend(
	id_festivalgoer INT(7),
	id_show INT(7),
    sings boolean,
    constraint pk_attend primary key (id_festivalgoer, id_show),
    constraint fk_id_show foreign key (id_show ) REFERENCES show1(id_show),
    constraint fk_id_festivalgoer_attend foreign key (id_festivalgoer) REFERENCES festivalgoer(id_festivalgoer)
);

DROP TABLE IF EXISTS consume;
CREATE TABLE consume(
	id_consume int(7),
    id_festivalgoer INT(7),
    id_bar INT(4),
    id_product INT(7),
	constraint pk_consume primary key (id_consume),
    constraint fk_id_bar_consume foreign key (id_bar) REFERENCES bar(id_bar),
    constraint fk_id_festivalgoer_consume foreign key (id_festivalgoer) REFERENCES festivalgoer(id_festivalgoer),
    constraint fk_id_product_consume foreign key (id_product) REFERENCES product(id_product)
);

DROP TABLE IF EXISTS purchase;
CREATE TABLE purchase (
	id_ticket INT(7),
	festival_name VARCHAR(40),
    festival_edition INT(2),
    id_vendor INT(7),
    price FLOAT(4),
    constraint pk_purchase primary key (id_ticket, festival_name, festival_edition, id_vendor),
    constraint fk_festival_purchase foreign key (festival_name, festival_edition) REFERENCES music_festival(name_festival, edition_number),
    constraint fk_id_vendor foreign key (id_vendor) REFERENCES vendor(id_vendor),
    constraint fk_id_ticket foreign key (id_ticket) REFERENCES ticket(id_ticket)
);

DROP TABLE IF EXISTS manage;
CREATE TABLE manage(
	id_manager INT(7),
    platform_name VARCHAR(40),
    account_name VARCHAR(40),
	name_festival VARCHAR(40),
    edition_number INT(2),
    constraint pk_manage primary key (id_manager, platform_name, account_name, name_festival, edition_number), 
	constraint fk_festival_manage foreign key (name_festival, edition_number) REFERENCES music_festival(name_festival, edition_number),
    constraint fk_account_name foreign key (account_name) REFERENCES social_media_account(account_name),
    constraint fk_platform foreign key (platform_name) references social_media_platform(platform_name)
);

DROP TABLE IF EXISTS compose_of;
CREATE TABLE compose_of(
	id_show INT(2),
    song_ordinality int(2),
	song_title VARCHAR(100),
    song_version INT(4),
    author_name VARCHAR(100),
    CONSTRAINT pk_composeof primary key (song_title, song_version, author_name, id_show),
    CONSTRAINT fk_song_title foreign key (song_title, song_version, author_name) REFERENCES song(title , song_version, written_by),
    CONSTRAINT fk_show foreign key (id_show)  REFERENCES show1(id_show)
);

DROP TABLE IF EXISTS play;
CREATE TABLE play(
	id_show INT(2),
    name_band VARCHAR(50),
    band_country VARCHAR(30),
    festival_name VARCHAR(40),
    festival_edition int(4),
    stage_number INT(4),
    CONSTRAINT pk_play primary key (id_show, band_country, name_band, festival_name, festival_edition, stage_number),
    CONSTRAINT fk_bandname foreign key (name_band, band_country) references band(name_band, country),
    CONSTRAINT fk_stagenumber foreign key (stage_number, festival_name, festival_edition) REFERENCES stage(id_stage, festival_name, festival_edition)
);

DROP TABLE IF EXISTS bring;
CREATE TABLE bring(
	id_provide INT(4),
	id_bar INT(4),
    id_product INT(4),
    id_provider INT(4),
    price FLOAT(12),
    order_date DATE,
    delivery_date DATE,
    quantity INT(3),
    CONSTRAINT pk_bring primary key 
    (id_bar, id_product, id_provider),
    CONSTRAINT fk_bar foreign key (id_bar) references bar(id_bar),
    CONSTRAINT fk_product foreign key (id_product) references product(id_product),
    CONSTRAINT fk_provider foreign key (id_provider) references external_provider(id_provider)
);

DROP TABLE IF EXISTS band_collaboration;
CREATE TABLE band_collaboration(
	name_band1 varchar(50),
    country1 varchar(30),
    name_band2 varchar(50),
    country2 varchar(30),
    CONSTRAINT pk_band_col primary key (name_band1, country1, name_band2, country2),
    CONSTRAINT fk_band1 foreign key (name_band1, country1) references band(name_band, country),
    CONSTRAINT fk_band2 foreign key (name_band2, country2) references band(name_band, country)
);


############### TEMPORARY TABLES ####################
DROP TABLE IF EXISTS temp_ticket;
CREATE temporary TABLE temp_ticket(
    id_ticket INT(20), 
    ticket_type VARCHAR(30), 
    barcode VARCHAR(40), 
    start_date date, 
    end_date date,
    festival_name VARCHAR(40),
    festival_edition int(4),
    id_festivalgoer int(7),
    id_vendor int(2),
    price float(5)
);

DROP TABLE IF EXISTS temp_social_media_account;
CREATE temporary TABLE temp_social_media_account (
	platform_name VARCHAR(40),
    impact_index VARCHAR(40),
	account_name VARCHAR(40),
    creation_date date,
    followers INT(10)
);

DROP TABLE IF EXISTS temp_stage;
CREATE TEMPORARY TABLE temp_stage(
	festival_name VARCHAR(40),
    festival_edition int(4),
    start_time datetime,
    end_time datetime,
    city VARCHAR(20),
    festival_description VARCHAR(400),
    id_stage INT(1),
    capacity INT(6),
    common_name varchar(50)
);

DROP TABLE IF EXISTS temp_bar_product;
CREATE temporary TABLE temp_bar_product(
	id_bar int(4),
    name_bar char(40),
    is_foodtruck boolean,
    is_indoor boolean,
    bar_product_unit_price float(40),
    bar_product_stock int(5),
    id_product int(4),
    name_food char(40),
    description_food varchar(200),
    id_food int(4),
	is_veggie boolean,
    is_gluten boolean,
    is_spicy boolean,
    id_beverage int(4),
	is_alcohol boolean,
	is_hot boolean,
    is_served_with_ice boolean
    );
    
DROP TABLE IF EXISTS temp_staff;
CREATE TEMPORARY TABLE temp_staff(
	id_staff INT(7),
    hire_date VARCHAR(20),
    contract_expiration_date VARCHAR(20),
    years_experience INT(2),
    id_beerman INT(7),
    tank_capacity int(10),
    id_bartender int(7),
    is_cocktail_master varchar(40),
    is_cooker VARCHAR(40), #is_cooks
    id_bar int(7),
    id_security int(7),
    is_armed boolean,
    knows_martial_arts boolean,
    festival_name VARCHAR(40),
    festival_edition int(4),
    id_stage int(4),
    id_community_manager int(7),
    is_freelance boolean
);

DROP TABLE IF EXISTS temp_provides;
CREATE temporary TABLE temp_provides(
	id_provides int(5),
    id_bar int(5),
    id_product int(2),
    id_provider int(2),
    provider_name char(50),
    provider_address varchar(100),
    provider_phone varchar(20),
    provider_email varchar(100),
    provider_base_country char(25),
    unit_price int(100),
	order_date date,
    delivery_date date,
	quantity int(5)    
    );
    
DROP TABLE IF EXISTS temp_show_song;
CREATE temporary TABLE temp_show_song(
	id_show int(2),
	start_date date,
	end_date date,
	name_band varchar(100),
    band_country varchar(20),
	festival_name VARCHAR(40),
    festival_edition int(4),
	id_stage int(2),
    ordinality_show_song int(2),
    title varchar(100),
    version int(3),
    written_by varchar(100),
    duration int(3),
    release_date date,
    type_of_music char(50),
	album varchar(25)
    );
    

DROP TABLE IF EXISTS temp_beerman_sells;
CREATE temporary TABLE temp_beerman_sells(
	id_beerman_sells int(10),
    id_beerman int(6),
    id_festivalgoer int(6),
    festival_name varchar(40),
    festival_edition int(4),
	id_stage int(1) 
    );
    

    

    
    




