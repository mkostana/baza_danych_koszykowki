DROP TABLE transfer;
DROP TABLE zawodnik;
DROP TABLE pozycja;
DROP TABLE mecz;
DROP TABLE stadion;
DROP TABLE sponsor_druzyna;
DROP TABLE sponsor;
DROP TABLE druzyna;
DROP TABLE liga;

CREATE TABLE druzyna (
    id_druzyna integer  NOT NULL,
    nazwa varchar2(60)  NOT NULL,
    id_liga integer  NOT NULL,
    CONSTRAINT druzyna_pk PRIMARY KEY (id_druzyna)
) ;


CREATE TABLE liga (
    id_liga integer  NOT NULL,
    nazwa varchar2(40)  NOT NULL,
    kraj varchar2(40)  NOT NULL,
    poziom integer  NOT NULL,
    CONSTRAINT liga_pk PRIMARY KEY (id_liga)
) ;


CREATE TABLE mecz (
    id_mecz integer  NOT NULL,
    druzyna_1 integer  NOT NULL,
    druzyna_2 integer  NOT NULL,
    data_godzina timestamp  NOT NULL,
    stadion integer  NOT NULL,
    CONSTRAINT mecz_pk PRIMARY KEY (id_mecz)
) ;


CREATE TABLE pozycja (
    id_pozycja integer  NOT NULL,
    pozycja varchar2(20)  NOT NULL,
    CONSTRAINT pozycja_pk PRIMARY KEY (id_pozycja)
) ;


CREATE TABLE sponsor (
    id_sponsor integer  NOT NULL,
    nazwa varchar2(60)  NOT NULL,
    branza varchar2(120)  NOT NULL,
    CONSTRAINT sponsor_pk PRIMARY KEY (id_sponsor)
) ;


CREATE TABLE sponsor_druzyna (
    druzyna integer  NOT NULL,
    sponsor integer  NOT NULL,
    wartosc_umowy number(9,2)  NOT NULL,
    CONSTRAINT sponsor_druzyna_pk PRIMARY KEY (druzyna,sponsor)
) ;


CREATE TABLE stadion (
    id_stadion integer  NOT NULL,
    nazwa varchar2(60)  NOT NULL,
    lokalizacja varchar2(60)  NOT NULL,
    pojemnosc integer  NOT NULL,
    CONSTRAINT stadion_pk PRIMARY KEY (id_stadion)
) ;


CREATE TABLE transfer (
    id_transfer integer  NOT NULL,
    druzyna_sprzedajaca integer  NOT NULL,
    druzyna_kupujaca integer  NOT NULL,
    id_zawodnik integer  NOT NULL,
    kwota_transferu number(9,2)  NOT NULL,
    data date  NOT NULL,
    CONSTRAINT transfer_pk PRIMARY KEY (id_transfer)
) ;


CREATE TABLE zawodnik (
    id_zawodnik integer  NOT NULL,
    imie varchar2(40)  NOT NULL,
    nazwisko varchar2(40)  NOT NULL,
    data_urodzenia date  NOT NULL,
    numer varchar2(2)  NOT NULL,
    id_pozycja integer  NOT NULL,
    id_druzyna integer  NOT NULL,
    CONSTRAINT zawodnik_pk PRIMARY KEY (id_zawodnik)
) ;



ALTER TABLE druzyna ADD CONSTRAINT druzyna_liga
    FOREIGN KEY (id_liga)
    REFERENCES liga (id_liga);


ALTER TABLE mecz ADD CONSTRAINT mecz_druzyna_1
    FOREIGN KEY (druzyna_1)
    REFERENCES druzyna (id_druzyna);


ALTER TABLE mecz ADD CONSTRAINT mecz_druzyna_2
    FOREIGN KEY (druzyna_2)
    REFERENCES druzyna (id_druzyna);


ALTER TABLE mecz ADD CONSTRAINT mecz_stadion
    FOREIGN KEY (stadion)
    REFERENCES stadion (id_stadion);


ALTER TABLE sponsor_druzyna ADD CONSTRAINT sponsor_druzyna_druzyna
    FOREIGN KEY (druzyna)
    REFERENCES druzyna (id_druzyna);


ALTER TABLE sponsor_druzyna ADD CONSTRAINT sponsor_druzyna_sponsor
    FOREIGN KEY (sponsor)
    REFERENCES sponsor (id_sponsor);


ALTER TABLE transfer ADD CONSTRAINT transfer_druzyna_kupujaca
    FOREIGN KEY (druzyna_kupujaca)
    REFERENCES druzyna (id_druzyna);


ALTER TABLE transfer ADD CONSTRAINT transfer_druzyna_sprzedajaca
    FOREIGN KEY (druzyna_sprzedajaca)
    REFERENCES druzyna (id_druzyna);


ALTER TABLE transfer ADD CONSTRAINT transfer_zawodnik
    FOREIGN KEY (id_zawodnik)
    REFERENCES zawodnik (id_zawodnik);


ALTER TABLE zawodnik ADD CONSTRAINT zawodnik_druzyna
    FOREIGN KEY (id_druzyna)
    REFERENCES druzyna (id_druzyna);


ALTER TABLE zawodnik ADD CONSTRAINT zawodnik_pozycja
    FOREIGN KEY (id_pozycja)
    REFERENCES pozycja (id_pozycja);