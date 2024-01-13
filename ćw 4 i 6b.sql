
CREATE TABLE ksiegowosc.pracownicyyy(
    id_pracownika int NOT NULL,
    imie varchar(255),
    nazwisko varchar(255),
    Address varchar(255),
    telefon varchar(255),
	PRIMARY KEY (id_pracownika)
);
CREATE TABLE ksiegowosc.godziny(
    id_godziny int ,
    data varchar(255),
    liczba_godzin varchar(255),
    id_pracownika int NOT NULL,
	PRIMARY KEY (id_godziny),
	FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicyyy(id_pracownika)
);
CREATE TABLE ksiegowosc.pensje(
    id_pensji int,
    stanowisko varchar(255),
    kwota varchar(255),
	PRIMARY KEY (id_pensji)
);
CREATE TABLE ksiegowosc.premie(
    id_premii int,
    rodzaj varchar(255),
    kwota varchar(255),
	PRIMARY KEY (id_premii)
);
CREATE TABLE ksiegowosc.wynagrodzenie(
	id_wynagrodzenia int,
	data_wynagrodzenia DATE,
	id_pracownika int,
	id_godziny int,
	id_pensji int,
	id_premii int
	PRIMARY KEY (id_wynagrodzenia),
	FOREIGN KEY (id_pracownika) REFERENCES pracownicyy(id_pracownika),
	FOREIGN KEY (id_godziny) REFERENCES godziny(id_godziny),
	FOREIGN KEY (id_pensji) REFERENCES pensje(id_pensji),
	FOREIGN KEY (id_premii) REFERENCES premie(id_premii)
);


INSERT INTO ksiegowosc.pracownicyyy
VALUES
('1', 'Ala', 'Skage', '123', '4050'),
('2', 'Maja', 'Kaage', '23', '3040'),
('3', 'a', 'Kage', '23', '3005'),
('4', 'Ma', 'Kage', '23', '3300'),
('5', 'Maa', 'Kage', '23', '33030'),
('6', 'Masja', 'Kage', '23', '3030'),
('7', 'Madja', 'Kage', '23', '3002'),
('8', 'Mafja', 'Kage', '23', '3020'),
('9', 'Majga', 'Kage', '23', '2200'),
('10', 'Majra', 'Kage', '23', '200');

INSERT INTO ksiegowosc.godziny
VALUES
('3', '22.03.2001', '3', '1'),
('4', '22.03.2001', '2', '2'),
('5', '21.03.2001', '19', '4'),
('6', '24.03.2001', '24', '3'),
('7', '26.03.2001', '54', '6'),
('8', '02.03.2001', '34', '5'),
('9', '12.03.2001', '12', '8'),
('10', '29.03.2001', '9', '7'),
('11', '14.03.2001', '4', '9'),
('12', '15.03.2001', '5', '10');

INSERT INTO ksiegowosc.pensje
VALUES
('23', '2', '101'),
('232','4', '102'),
('24', '5', '103'),
('33', '6', '104'),
('53', '43','105'),
('63', '23','106'),
('73', '3', '107'),
('83', '4', '108'),
('93', '8', '109'),
('26', '7', '110');

INSERT INTO ksiegowosc.premie
VALUES
('19', 'uznaniowe', '110'),
('18', 'uznaniowe', '108'),
('17', 'uznaniowe', '109'),
('10', 'uznaniowe', '101'),
('12', 'uznaniowe', '102'),
('14', 'uznaniowe', '104'),
('15', 'uznaniowe', '107'),
('11', 'uznaniowe', '103'),
('13', 'uznaniowe', '105'),
('16', 'uznaniowe', '106');

INSERT INTO ksiegowosc.wynagrodzenie
VALUES
(3, '2001-03-22', 1, 3, 232, 11),
(4, '2001-03-21', 2, 5, 23, 19),
(5, '2001-03-22', 3, 4, 24, 18),
(6, '2001-03-26', 4, 7, 33, 17),
(7, '2001-03-24', 5, 6, 53, 10),
(8, '2001-03-12', 6, 9, 63, 12),
(9, '2001-03-02', 7, 8, 73, 14),
(10, '2001-03-15', 8, 12, 83, 15),
(11, '2001-03-14', 9, 11, 93, 13),
(12, '2001-03-29', 10, 10, 26, 12);

--a 
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicyyy;
--b
SELECT w.id_pracownika
FROM ksiegowosc.wynagrodzenie w
LEFT JOIN ksiegowosc.pensje p ON w.id_pensji = p.id_pensji
WHERE p.kwota>1000

--c
SELECT w.id_pracownika
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje p ON w.id_pensji = p.id_pensji
LEFT JOIN ksiegowosc.premie pr ON w.id_premii=pr.id_premii
WHERE p.kwota>2000 AND pr.id_premii IS NULL

--d
SELECT imie
FROM ksiegowosc.pracownicyyy
WHERE imie LIKE 'J%'
--e
SELECT imie, nazwisko
FROM ksiegowosc.pracownicyyy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'
--f
UPDATE godziny 
SET liczba_godzin = 180;
SELECT p.imie, p.nazwisko, g.liczba_godzin -160 AS nadgodziny
FROM ksiegowosc.pracownicyyy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny
--g
SELECT imie, nazwisko, pe.kwota
FROM ksiegowosc.pracownicyyy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
WHERE pe.kwota BETWEEN 1500 AND 3000
--h
SELECT p.imie, p.nazwisko 
FROM ksiegowosc.pracownicyyy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
LEFT JOIN ksiegowosc.godziny g ON w.id_godziny = g.id_godziny 
WHERE g.liczba_godzin > 160 AND pr.id_premii IS NULL
--i
SELECT w.id_pracownika
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
ORDER BY pe.kwota;
--j
SELECT w.id_pracownika
FROM ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
ORDER BY pr.kwota, pe.kwota DESC;
--k
SELECT stanowisko, COUNT(*) as liczba_pracownikow
FROM ksiegowosc.pensje
GROUP BY stanowisko;
--l
SELECT
stanowisko,
  AVG(CAST(kwota AS DECIMAL(10, 2))) AS srednia_placa,
  MIN(CAST(kwota AS DECIMAL(10, 2))) AS minimalna_placa,
  MAX(CAST(kwota AS DECIMAL(10, 2))) AS maksymalna_placa
FROM ksiegowosc.pensje
WHERE stanowisko = 'uznaniowe'
GROUP BY stanowisko
--m
SELECT stanowisko, SUM(CAST(kwota AS DECIMAL(10, 2))) AS suma_wynagrodzen
FROM ksiegowosc.pensje
--n
SELECT stanowisko, SUM(CAST(kwota AS DECIMAL(10, 2))) AS suma_wynagrodzen
FROM ksiegowosc.pensje
GROUP BY stanowisko;
--o
SELECT p.stanowisko, COUNT(*) AS liczba_premii
FROM ksiegowosc.pensje p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pensji = w.id_pensji
JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
GROUP BY stanowisko
--p
DELETE FROM ksiegowosc.pracownicyyy
WHERE id_pracownika IN(
SELECT p.id_pracownika
FROM ksiegowosc.pracownicyyy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
WHERE pe.kwota <1200
)


--cw b
--a
UPDATE ksiegowosc.pracownicyyy
SET telefon = CONCAT('(+48)', telefon);

--b
UPDATE ksiegowosc.pracownicyyy
SET telefon = CONCAT(SUBSTRING(telefon, 1, 3), '-', SUBSTRING(telefon, 4, 3), '-', SUBSTRING(telefon, 7, NULL));

--c
SELECT TOP 1  UPPER(nazwisko) AS Imie, Nazwisko, telefon
FROM ksiegowosc.pracownicyyy
ORDER BY LEN(Nazwisko) DESC;

--d
SELECT p.imie, p.nazwisko, HASHBYTES('MD5', cast(pe.kwota as varchar(255))) AS Pensja_MD5
FROM ksiegowosc.pracownicyyy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji;

--f
SELECT p.imie, p.nazwisko, pe.kwota, pr.kwota
FROM ksiegowosc.pracownicyyy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
LEFT JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii;

--g
DECLARE @stawka_za_godzine DECIMAL(10, 2) = 25.00;

SELECT CONCAT(
  'Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', 
  CONVERT(varchar, w.data_wynagrodzenia, 105), 
  ' otrzyma³ pensjê ca³kowit¹ na kwotê ', 
  CONVERT(varchar, pe.kwota + pr.kwota + (CAST(g.liczba_godzin AS DECIMAL(10, 2)) - 160) * @stawka_za_godzine), 
  ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', 
  CONVERT(varchar, pe.kwota), 
  ' z³, premia: ', 
  CONVERT(varchar, pr.kwota), 
  ' z³, nadgodziny: ', 
  CONVERT(varchar, (CAST(g.liczba_godzin AS DECIMAL(10, 2)) - 160) * @stawka_za_godzine), 
  ' z³'
) AS Raport
FROM ksiegowosc.pracownicyyy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensje pe ON w.id_pensji = pe.id_pensji
JOIN ksiegowosc.premie pr ON w.id_premii = pr.id_premii
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
WHERE p.imie = 'Jan' AND p.nazwisko = 'Nowak' AND w.data_wynagrodzenia = '2017-08-07';
