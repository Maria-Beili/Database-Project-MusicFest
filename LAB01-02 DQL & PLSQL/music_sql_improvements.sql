USE music_festival;
DROP TABLE IF EXISTS present;
CREATE TABLE present(
	id_bar int(4),
    festival_name varchar(40),
    festival_number int(2),
    constraint pk_present primary key (id_bar, festival_name, festival_number),
    CONSTRAINT fk_bar_present foreign key (id_bar) REFERENCES bar(id_bar),
    CONSTRAINT fk_festival_bar foreign key (festival_name, festival_number) REFERENCES music_festival(name_festival, edition_number)
);

DROP TABLE IF EXISTS show_up;
CREATE TABLE show_up(
	festival_name varchar(40),
    festival_number int(2),
    id_person int(7),
    present boolean,
    CONSTRAINT pk_show_up primary key (festival_name, festival_number, id_person),
    CONSTRAINT pk_person_show_up foreign key (id_person) REFERENCES person(id_person),
    CONSTRAINT fk_festival_show_up foreign key (festival_name, festival_number) REFERENCES music_festival(name_festival, edition_number)
);

