DROP PROCEDURE ZawodnicyWDruzynie;
DROP PROCEDURE DodajJrMlodymZawodnikom;
DROP TRIGGER sprawdz_wartosc_umowy;
DROP TRIGGER IDZawodnika;
--Procedura wyswietla informacje o wszystkich zawodnikach druzyny podanej jako argument
SET Serveroutput ON;
SET Feedback OFF;
CREATE OR REPLACE PROCEDURE ZawodnicyWDruzynie(
    v_nazwa_druzyny Varchar2)
AS
    v_ZawodnikID int;
    v_imie varchar2(40);
    v_nazwisko varchar2(40);
    v_DataUrodzenia date;
    v_numer varchar2(2);
    v_NazwaPozycji varchar(20);
    
    CURSOR zawodnicy IS
    SELECT zawodnik.id_zawodnik, zawodnik.imie, zawodnik.nazwisko, zawodnik.data_urodzenia, zawodnik.numer, pozycja.pozycja
    FROM zawodnik
    JOIN druzyna ON zawodnik.id_druzyna = druzyna.id_druzyna
    JOIN pozycja ON zawodnik.id_pozycja = pozycja.id_pozycja
    WHERE druzyna.nazwa = v_nazwa_druzyny;
    
    v_ile int;
BEGIN
    SELECT COUNT(*) INTO v_ile
    FROM druzyna
    WHERE nazwa = v_nazwa_druzyny;
    
    IF v_ile = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Taka druzyna nie istnieje');
        RETURN;
    END IF;
    
    OPEN zawodnicy;
    LOOP
        FETCH zawodnicy INTO v_ZawodnikID, v_imie, v_nazwisko, v_DataUrodzenia, v_numer, v_NazwaPozycji;
        EXIT WHEN zawodnicy%NotFound;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_ZawodnikID || ', Imie: ' || v_imie || ', Nazwisko: ' || v_nazwisko || ', Data urodzenia: ' || TO_CHAR(v_DataUrodzenia, 'YYYY-MM-DD') || ', Numer: ' || v_numer || ', Pozycja: ' || v_NazwaPozycji);
    END LOOP;
    
    CLOSE zawodnicy;
END;

execute ZawodnicyWDruzynie('Real Madrid Baloncesto');



--Procedura dodaje przedrostek Jr. graczom którzy mają mniej niż 25 lat
SET Serveroutput ON;
SET Feedback OFF;
CREATE OR REPLACE PROCEDURE DodajJrMlodymZawodnikom IS
	v_ile int;
BEGIN
	SELECT COUNT(*) INTO v_ile
	FROM zawodnik
	WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_urodzenia) < 25;

	IF v_ile = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Brak mlodych graczy do zaktualizowania');
	ELSE
		UPDATE zawodnik
		SET nazwisko = 'Jr. ' || nazwisko
		WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_urodzenia) < 25;
		COMMIT;
		DBMS_OUTPUT.PUT_LINE('Przedrostek Jr. zostal dodawny do nazwisk mlodych graczy');
	END IF;
END;

execute DodajJrMlodymZawodnikom;



--Wyzwalacz nie pozwala przy wstawianiu lub modyfikowaniu danych w tabeli sponsor_druzyna wprowadzić wartości umowy mniejszej niż 100000 lub zmienić wartości umowy na niższą niż aktualnie jest
CREATE OR REPLACE TRIGGER sprawdz_wartosc_umowy
BEFORE INSERT OR UPDATE
OF wartosc_umowy
ON sponsor_druzyna
FOR EACH ROW
DECLARE
BEGIN
    IF INSERTING THEN
        IF :new.wartosc_umowy < 100000 THEN
            :new.wartosc_umowy := 100000;
        END IF;
    END IF;
    IF UPDATING THEN
        IF :new.wartosc_umowy < :old.wartosc_umowy THEN
            :new.wartosc_umowy := :old.wartosc_umowy;
        END IF;
    END IF;
END;

DROP TRIGGER sprawdz_wartosc_umowy;



-- Wyzwalacz generuje automatycznie id zawodnika przy wstawianiu do bazy danych w momencie kiedy nie zostało ono wprowadzone w instrukcji INSERT
CREATE OR REPLACE TRIGGER IDZawodnika
BEFORE INSERT
ON zawodnik
FOR EACH ROW
DECLARE v_ID int;
BEGIN
    IF :new.id_zawodnik IS NULL THEN
        SELECT MAX(id_zawodnik)+1 INTO v_ID FROM zawodnik;
        :new.id_zawodnik := v_ID;
        DBMS_OUTPUT.PUT_LINE('Wygenerowany nowy ID zawodnika: ' || v_ID);
    END IF;
END;

DROP TRIGGER IDZawodnika;