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