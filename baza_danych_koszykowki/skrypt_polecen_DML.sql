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