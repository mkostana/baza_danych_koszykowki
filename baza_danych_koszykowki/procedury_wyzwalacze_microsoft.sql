DROP PROCEDURE DodajNowaDruzyne;
DROP PROCEDURE PodwyzkaDlaDruzyn;
DROP TRIGGER transfer_zawodnika;
DROP TRIGGER zakaz_usuniecia_stadionu;
-- Procedura dodaje nową drużynę do bazy danych
-- Pobiera w argumentach nazwe nowej drużyny do dodania oraz nazwe istniejącej ligi do której chcemy przypisać drużyne
-- Procedura sprawdza czy dana liga istnieje - jeżeli nie to wyświetla 'Taka liga nie istnieje'
-- Procedura sprawdza czy dana drużyna istnieje - jeżeli tak to wyświetla 'Taka druzyna juz istnieje'
-- Jeżeli wszystko jest w porządku to procedura dodaje nową drużynę i wyświetla 'Nowa druzyna dodana pomyslnie'
CREATE PROCEDURE DodajNowaDruzyne @NazwaDruzyny VARCHAR(60), @NazwaLigi VARCHAR(40)
AS
	DECLARE @LigaID INT, @DruzynaID INT;
BEGIN
	SELECT @LigaID = id_liga
	FROM liga
	WHERE nazwa = @NazwaLigi;

	SELECT @DruzynaID = id_druzyna
	FROM druzyna
	WHERE nazwa = @NazwaDruzyny;

	IF @LigaID IS NOT NULL
	BEGIN
		IF @DruzynaID IS NULL
		BEGIN
			DECLARE @MaxID INT;

			SELECT @MaxID = MAX(id_druzyna)+1
			FROM druzyna;

			INSERT INTO druzyna(id_druzyna, nazwa, id_liga)
			VALUES(@MaxID, @NazwaDruzyny, @LigaID);

			PRINT 'Nowa druzyna dodana pomyslnie';
		END
		ELSE
		BEGIN
			PRINT 'Taka druzyna juz istnieje';
		END
	END
	ELSE
	BEGIN
		PRINT 'Taka liga nie istnieje';
	END
END

exec DodajNowaDruzyne 'NowaDruzyna', 'NBA';
SELECT * FROM druzyna;
DROP PROCEDURE DodajNowaDruzyne;



-- Procedura powoduje podwyżkę o 10% umów sponsorskich, które przekraczają 600000
CREATE PROCEDURE PodwyzkaDlaDruzyn
AS
BEGIN
	DECLARE @DruzynaID INT, @SponsorID INT, @WartoscUmowy MONEY;

	DECLARE zawodnicy_cursor CURSOR FOR
	SELECT druzyna, sponsor, wartosc_umowy
	FROM sponsor_druzyna;

	OPEN zawodnicy_cursor;
	FETCH NEXT FROM zawodnicy_cursor INTO @DruzynaID, @SponsorID, @WartoscUmowy;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @WartoscUmowy > 600000
		BEGIN
			UPDATE sponsor_druzyna
			SET wartosc_umowy = @WartoscUmowy * 1.1
			WHERE druzyna = @DruzynaID AND sponsor = @SponsorID;
		END
		FETCH NEXT FROM zawodnicy_cursor INTO @DruzynaID, @SponsorID, @WartoscUmowy;
	END
	CLOSE zawodnicy_cursor;
	DEALLOCATE zawodnicy_cursor;
END

SELECT * FROM sponsor_druzyna;
exec PodwyzkaDlaDruzyn;
SELECT * FROM sponsor_druzyna;
DROP PROCEDURE PodwyzkaDlaDruzyn;



--Wyzwalacz powoduje zmiane id_druzyny w tabeli zawodnik na id nowej druzyny w momencie dodania nowego transferu
CREATE TRIGGER transfer_zawodnika
ON transfer
AFTER INSERT
AS
	DECLARE @IDZawodnika int, @IDDruzynyKupujacej int;
BEGIN
	SELECT @IDZawodnika = id_zawodnik, @IDDruzynyKupujacej = druzyna_kupujaca
	FROM inserted;

	IF EXISTS (SELECT 1 FROM druzyna WHERE id_druzyna = @IDDruzynyKupujacej)
	BEGIN
		UPDATE zawodnik SET id_druzyna = @IDDruzynyKupujacej WHERE id_zawodnik = @IDZawodnika;
	END
	ELSE
	BEGIN
		PRINT 'Nowa druzyna nie istnieje';
	END
END;



--Wyzwalacz powoduje zakaz usuniecia rekordu z tabeli stadion jezeli istnieje mecz z przyszla data ktory ma sie rozegrac na tym stadionie
CREATE TRIGGER zakaz_usuniecia_stadionu
ON stadion
FOR DELETE
AS
BEGIN
	IF EXISTS (SELECT 1 FROM deleted 
	JOIN mecz ON deleted.id_stadion = mecz.stadion
	WHERE mecz.data_godzina > GETDATE())
	BEGIN
		Rollback;
		PRINT 'Nie mozna usunac stadionu, poniewaz istnieje przyszly mecz zwiazany z tym stadionem';
	END
END;