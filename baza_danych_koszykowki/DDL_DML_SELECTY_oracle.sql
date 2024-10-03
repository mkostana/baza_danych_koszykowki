ALTER TABLE druzyna
    DROP CONSTRAINT druzyna_liga;

ALTER TABLE mecz
    DROP CONSTRAINT mecz_druzyna_1;

ALTER TABLE mecz
    DROP CONSTRAINT mecz_druzyna_2;

ALTER TABLE mecz
    DROP CONSTRAINT mecz_stadion;

ALTER TABLE sponsor_druzyna
    DROP CONSTRAINT sponsor_druzyna_druzyna;

ALTER TABLE sponsor_druzyna
    DROP CONSTRAINT sponsor_druzyna_sponsor;

ALTER TABLE transfer
    DROP CONSTRAINT transfer_druzyna_kupujaca;

ALTER TABLE transfer
    DROP CONSTRAINT transfer_druzyna_sprzedajaca;

ALTER TABLE transfer
    DROP CONSTRAINT transfer_zawodnik;

ALTER TABLE zawodnik
    DROP CONSTRAINT zawodnik_druzyna;

ALTER TABLE zawodnik
    DROP CONSTRAINT zawodnik_pozycja;

DROP TABLE druzyna;

DROP TABLE liga;

DROP TABLE mecz;

DROP TABLE pozycja;

DROP TABLE sponsor;

DROP TABLE sponsor_druzyna;

DROP TABLE stadion;

DROP TABLE transfer;

DROP TABLE zawodnik;

-- Table: druzyna
CREATE TABLE druzyna (
    id_druzyna integer  NOT NULL,
    nazwa varchar2(60)  NOT NULL,
    id_liga integer  NOT NULL,
    CONSTRAINT druzyna_pk PRIMARY KEY (id_druzyna)
) ;

-- Table: liga
CREATE TABLE liga (
    id_liga integer  NOT NULL,
    nazwa varchar2(40)  NOT NULL,
    kraj varchar2(40)  NOT NULL,
    poziom integer  NOT NULL,
    CONSTRAINT liga_pk PRIMARY KEY (id_liga)
) ;

-- Table: mecz
CREATE TABLE mecz (
    id_mecz integer  NOT NULL,
    druzyna_1 integer  NOT NULL,
    druzyna_2 integer  NOT NULL,
    data_godzina timestamp  NOT NULL,
    stadion integer  NOT NULL,
    CONSTRAINT mecz_pk PRIMARY KEY (id_mecz)
) ;

-- Table: pozycja
CREATE TABLE pozycja (
    id_pozycja integer  NOT NULL,
    pozycja varchar2(20)  NOT NULL,
    CONSTRAINT pozycja_pk PRIMARY KEY (id_pozycja)
) ;

-- Table: sponsor
CREATE TABLE sponsor (
    id_sponsor integer  NOT NULL,
    nazwa varchar2(60)  NOT NULL,
    branza varchar2(120)  NOT NULL,
    CONSTRAINT sponsor_pk PRIMARY KEY (id_sponsor)
) ;

-- Table: sponsor_druzyna
CREATE TABLE sponsor_druzyna (
    druzyna integer  NOT NULL,
    sponsor integer  NOT NULL,
    wartosc_umowy number(9,2)  NOT NULL,
    CONSTRAINT sponsor_druzyna_pk PRIMARY KEY (druzyna,sponsor)
) ;

-- Table: stadion
CREATE TABLE stadion (
    id_stadion integer  NOT NULL,
    nazwa varchar2(60)  NOT NULL,
    lokalizacja varchar2(60)  NOT NULL,
    pojemnosc integer  NOT NULL,
    CONSTRAINT stadion_pk PRIMARY KEY (id_stadion)
) ;

-- Table: transfer
CREATE TABLE transfer (
    id_transfer integer  NOT NULL,
    druzyna_sprzedajaca integer  NOT NULL,
    druzyna_kupujaca integer  NOT NULL,
    id_zawodnik integer  NOT NULL,
    kwota_transferu number(9,2)  NOT NULL,
    data date  NOT NULL,
    CONSTRAINT transfer_pk PRIMARY KEY (id_transfer)
) ;

-- Table: zawodnik
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

-- foreign keys
-- Reference: druzyna_liga (table: druzyna)
ALTER TABLE druzyna ADD CONSTRAINT druzyna_liga
    FOREIGN KEY (id_liga)
    REFERENCES liga (id_liga);

-- Reference: mecz_druzyna_1 (table: mecz)
ALTER TABLE mecz ADD CONSTRAINT mecz_druzyna_1
    FOREIGN KEY (druzyna_1)
    REFERENCES druzyna (id_druzyna);

-- Reference: mecz_druzyna_2 (table: mecz)
ALTER TABLE mecz ADD CONSTRAINT mecz_druzyna_2
    FOREIGN KEY (druzyna_2)
    REFERENCES druzyna (id_druzyna);

-- Reference: mecz_stadion (table: mecz)
ALTER TABLE mecz ADD CONSTRAINT mecz_stadion
    FOREIGN KEY (stadion)
    REFERENCES stadion (id_stadion);

-- Reference: sponsor_druzyna_druzyna (table: sponsor_druzyna)
ALTER TABLE sponsor_druzyna ADD CONSTRAINT sponsor_druzyna_druzyna
    FOREIGN KEY (druzyna)
    REFERENCES druzyna (id_druzyna);

-- Reference: sponsor_druzyna_sponsor (table: sponsor_druzyna)
ALTER TABLE sponsor_druzyna ADD CONSTRAINT sponsor_druzyna_sponsor
    FOREIGN KEY (sponsor)
    REFERENCES sponsor (id_sponsor);

-- Reference: transfer_druzyna_kupujaca (table: transfer)
ALTER TABLE transfer ADD CONSTRAINT transfer_druzyna_kupujaca
    FOREIGN KEY (druzyna_kupujaca)
    REFERENCES druzyna (id_druzyna);

-- Reference: transfer_druzyna_sprzedajaca (table: transfer)
ALTER TABLE transfer ADD CONSTRAINT transfer_druzyna_sprzedajaca
    FOREIGN KEY (druzyna_sprzedajaca)
    REFERENCES druzyna (id_druzyna);

-- Reference: transfer_zawodnik (table: transfer)
ALTER TABLE transfer ADD CONSTRAINT transfer_zawodnik
    FOREIGN KEY (id_zawodnik)
    REFERENCES zawodnik (id_zawodnik);

-- Reference: zawodnik_druzyna (table: zawodnik)
ALTER TABLE zawodnik ADD CONSTRAINT zawodnik_druzyna
    FOREIGN KEY (id_druzyna)
    REFERENCES druzyna (id_druzyna);

-- Reference: zawodnik_pozycja (table: zawodnik)
ALTER TABLE zawodnik ADD CONSTRAINT zawodnik_pozycja
    FOREIGN KEY (id_pozycja)
    REFERENCES pozycja (id_pozycja);



INSERT INTO liga (id_liga, nazwa, kraj, poziom) VALUES (1, 'NBA', 'USA', 1);
INSERT INTO liga (id_liga, nazwa, kraj, poziom) VALUES (2, 'EuroLeague', 'Europa', 1);
INSERT INTO liga (id_liga, nazwa, kraj, poziom) VALUES (3, 'ACB', 'Hiszpania', 1);

INSERT INTO stadion (id_stadion, nazwa, lokalizacja, pojemnosc) VALUES (1, 'Staples Center', 'USA', 19000);
INSERT INTO stadion (id_stadion, nazwa, lokalizacja, pojemnosc) VALUES (2, 'WiZink Center', 'Hiszpania', 17000);
INSERT INTO stadion (id_stadion, nazwa, lokalizacja, pojemnosc) VALUES (3, 'Palau Blaugrana', 'Hiszpania', 7800);

INSERT INTO pozycja (id_pozycja, pozycja) VALUES (1, 'Obronca');
INSERT INTO pozycja (id_pozycja, pozycja) VALUES (2, 'Pomocnik');
INSERT INTO pozycja (id_pozycja, pozycja) VALUES (3, 'Napastnik');

INSERT INTO druzyna (id_druzyna, nazwa, id_liga) VALUES (1, 'Los Angeles Lakers', 1);
INSERT INTO druzyna (id_druzyna, nazwa, id_liga) VALUES (2, 'Real Madrid Baloncesto', 2);
INSERT INTO druzyna (id_druzyna, nazwa, id_liga) VALUES (3, 'FC Barcelona Basquet', 3);
INSERT INTO druzyna (id_druzyna, nazwa, id_liga) VALUES (4, 'Chicago Bulls', 1);

INSERT INTO zawodnik (id_zawodnik, imie, nazwisko, data_urodzenia, numer, id_pozycja, id_druzyna) VALUES (1, 'LeBron', 'James', '1984-12-30', '23', 1, 1);
INSERT INTO zawodnik (id_zawodnik, imie, nazwisko, data_urodzenia, numer, id_pozycja, id_druzyna) VALUES (2, 'Luka', 'Doncic', '1999-02-28', '77', 2, 2);
INSERT INTO zawodnik (id_zawodnik, imie, nazwisko, data_urodzenia, numer, id_pozycja, id_druzyna) VALUES (3, 'Pau', 'Gasol', '1980-07-06', '16', 3, 3);
INSERT INTO zawodnik (id_zawodnik, imie, nazwisko, data_urodzenia, numer, id_pozycja, id_druzyna) VALUES (4, 'Michael', 'Jordan', '1963-02-12', '23', 1, 4);
INSERT INTO zawodnik (id_zawodnik, imie, nazwisko, data_urodzenia, numer, id_pozycja, id_druzyna) VALUES (5, 'Nikola', 'Jokic', '1995-02-19', '15', 2, 2);

INSERT INTO transfer (id_transfer, druzyna_sprzedajaca, druzyna_kupujaca, id_zawodnik, kwota_transferu, data) VALUES (1, 1, 2, 1, 5000000, '2020-06-20');
INSERT INTO transfer (id_transfer, druzyna_sprzedajaca, druzyna_kupujaca, id_zawodnik, kwota_transferu, data) VALUES (2, 2, 3, 2, 6000000, '2019-06-25');
INSERT INTO transfer (id_transfer, druzyna_sprzedajaca, druzyna_kupujaca, id_zawodnik, kwota_transferu, data) VALUES (3, 1, 3, 3, 4000000, '2021-06-30');

INSERT INTO mecz (id_mecz, druzyna_1, druzyna_2, data_godzina, stadion) VALUES (1, 1, 2, '2023-06-15 18:00', 1);
INSERT INTO mecz (id_mecz, druzyna_1, druzyna_2, data_godzina, stadion) VALUES (2, 2, 3, '2023-06-16 20:30', 2);
INSERT INTO mecz (id_mecz, druzyna_1, druzyna_2, data_godzina, stadion) VALUES (3, 1, 3, '2023-06-17 16:15', 3);

INSERT INTO sponsor (id_sponsor, nazwa, branza) VALUES (1, 'Nike', 'Odziez sportowa');
INSERT INTO sponsor (id_sponsor, nazwa, branza) VALUES (2, 'Adidas', 'Obuwie sportowe');
INSERT INTO sponsor (id_sponsor, nazwa, branza) VALUES (3, 'Gatorade', 'Napoje sportowe');
INSERT INTO sponsor (id_sponsor, nazwa, branza) VALUES (4, 'Betclic', 'Zaklady bukmacherskie');

INSERT INTO sponsor_druzyna (druzyna, sponsor, wartosc_umowy) VALUES (1, 1, 1000000);
INSERT INTO sponsor_druzyna (druzyna, sponsor, wartosc_umowy) VALUES (2, 2, 750000);
INSERT INTO sponsor_druzyna (druzyna, sponsor, wartosc_umowy) VALUES (3, 3, 500000);
INSERT INTO sponsor_druzyna (druzyna, sponsor, wartosc_umowy) VALUES (1, 4, 800000);



--1 zwraca imie zawodników którzy urodzili się po 1 stycznia 1984 roku
SELECT imie
FROM zawodnik
WHERE data_urodzenia > TO_DATE('1984-01-01');

--2 zwraca wszystkie informacje o stadionach które mają pojemność powyżej 18000
SELECT *
FROM stadion
WHERE pojemnosc > 18000;

--3 zwraca nazwe i kraj ligi których poziom wynosi 1
SELECT nazwa, kraj
FROM liga
WHERE poziom=1;

--4 zwraca wszystkie informacje o sponsorach których brażna zawiera w sobie "sportowe"
SELECT *
FROM sponsor
WHERE branza LIKE '%sportowe%';

--5 zwraca drużynę sprzedającą i drużynę kupującą dla transferów których kwota jest mniejsza od 4,5mln lub większa od 5,5mln
SELECT druzyna_sprzedajaca, druzyna_kupujaca, kwota_transferu
FROM transfer
WHERE kwota_transferu<4500000 OR kwota_transferu>5500000;

--6 zwraca imiona i nazwiska zawodników którzy grają na pozycji która w swojej nazwie zawiera litere "o"
SELECT imie, nazwisko
FROM zawodnik
JOIN pozycja ON zawodnik.id_pozycja=pozycja.id_pozycja 
WHERE pozycja.pozycja LIKE '%o%';

--7 zwraca wszystkie informacje z tabeli mecz dla meczów które zostały rozegrane na stadionach których pojemność wynosi poniżej 10000
SELECT mecz.*
FROM mecz
JOIN stadion ON mecz.stadion=stadion.id_stadion 
WHERE stadion.pojemnosc < 10000;

--8 zwraca nazwe druzyny i nazwe sponsora pomiędzy którymi doszlo do umowy której wartość jest powyżej 600000
SELECT druzyna.nazwa, sponsor.nazwa
FROM druzyna
JOIN sponsor_druzyna ON druzyna.id_druzyna=sponsor_druzyna.druzyna 
JOIN sponsor ON sponsor_druzyna.sponsor=sponsor.id_sponsor 
WHERE sponsor_druzyna.wartosc_umowy>600000;

--9 zwraca imie, nazwisko i numer zawodników którzy odbyli transfer po 1 stycznia 2020 roku
SELECT zawodnik.imie, zawodnik.nazwisko, zawodnik.numer
FROM zawodnik
JOIN transfer ON zawodnik.id_zawodnik=transfer.id_zawodnik
WHERE transfer.data > TO_DATE('2020-01-01');

--10 zwraca nazwy drużyn które grają w Hiszpańskiej lidze
SELECT druzyna.nazwa
FROM druzyna
JOIN liga ON druzyna.id_liga=liga.id_liga
WHERE liga.kraj='Hiszpania';

--11 zwraca ilość zawodników grających na danych pozycjach którzy urodzili się przed 1990 rokiem
SELECT pozycja.pozycja, COUNT(zawodnik.id_zawodnik)
FROM pozycja
JOIN zawodnik ON pozycja.id_pozycja=zawodnik.id_pozycja
WHERE zawodnik.data_urodzenia < TO_DATE('1990-01-01')
GROUP BY pozycja.pozycja;

--12 zwraca sumę pojemności wszystkich stadionów w każdym kraju
SELECT lokalizacja, SUM(pojemnosc)
FROM stadion
GROUP BY lokalizacja;

--13 zwraca nazwy drużyn i średnią wartość umów sponsorskich dla każdej z drużyn
SELECT druzyna.nazwa, AVG(sponsor_druzyna.wartosc_umowy)
FROM druzyna
JOIN sponsor_druzyna ON druzyna.id_druzyna = sponsor_druzyna.druzyna
GROUP BY druzyna.nazwa;

--14 zwraca nazwy lig i ilość drużyn w nich dla lig w których jest więcej niż 1 drużyna
SELECT liga.nazwa, COUNT(druzyna.id_druzyna)
FROM liga
JOIN druzyna ON liga.id_liga=druzyna.id_liga
GROUP BY liga.nazwa
HAVING COUNT(druzyna.id_druzyna) > 1;

--15 zwraca nazwy drużyn i ilość ich sponsorów dla drużyn które mają więcej niż jednego sponsora
SELECT druzyna.nazwa, COUNT(sponsor_druzyna.sponsor)
FROM druzyna
JOIN sponsor_druzyna ON druzyna.id_druzyna = sponsor_druzyna.druzyna
GROUP BY druzyna.nazwa
HAVING COUNT(sponsor_druzyna.sponsor) > 1;

--16 zwraca nazwy sponsorów którzy mają jakąś umowę która przekracza średnią wartość wszystkich umów
SELECT nazwa
FROM sponsor
WHERE (
    SELECT AVG(wartosc_umowy)
    FROM sponsor_druzyna
) < ANY (
    SELECT sponsor_druzyna.wartosc_umowy
    FROM sponsor_druzyna
    WHERE sponsor_druzyna.sponsor = sponsor.id_sponsor
);

--17 zwraca nazwy drużyn, które mają przynajmniej jednego sponsora
SELECT nazwa
FROM druzyna
WHERE id_druzyna IN (
    SELECT druzyna
    FROM sponsor_druzyna
);

--18 zwraca nazwy drużyn które mają więcej niż jednego zawodnika na danej pozycji
SELECT nazwa
FROM druzyna
WHERE id_druzyna IN (
    SELECT id_druzyna
    FROM zawodnik
    GROUP BY id_druzyna, id_pozycja
    HAVING COUNT(*) > 1
);

--19 zwraca nazwiska zawodników którzy są starsi niż przynajmniej jeden zawodnik w swojej drużynie
SELECT nazwisko
FROM zawodnik z
WHERE EXISTS (
    SELECT 0
    FROM zawodnik
    WHERE id_druzyna = z.id_druzyna
    AND data_urodzenia < z.data_urodzenia
);

--20 zwraca imiona i nazwiska zawodników którzy grają w drużynach z USA
SELECT imie, nazwisko
FROM zawodnik z
WHERE EXISTS (
    SELECT 0
    FROM druzyna
    JOIN liga ON druzyna.id_liga = liga.id_liga
    WHERE druzyna.id_druzyna = z.id_druzyna
    AND liga.kraj = 'USA'
);