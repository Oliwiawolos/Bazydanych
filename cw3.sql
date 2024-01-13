
CREATE TABLE rozliczenia1.pracownicy(
    id_pracownika int NOT NULL,
    imie varchar(255),
    nazwisko varchar(255),
    Address varchar(255),
    telefon varchar(255),
	PRIMARY KEY (id_pracownika)
);
CREATE TABLE rozliczenia1.godziny(
    id_godziny int,
    data varchar(255),
    liczba_godzin varchar(255),
    id_pracownika int NOT NULL,
	PRIMARY KEY (id_godziny)
);
CREATE TABLE rozliczenia1.pensje(
    id_pensji int NOT NULL,
    stanowisko varchar(255),
    kwota_brutto varchar(255),
	kwota_netto varchar(255),
    id_premii int,
	PRIMARY KEY (id_pensji)
);
CREATE TABLE rozliczenia1.premie(
    id_premii int,
    rodzaj varchar(255),
    kwota varchar(255),
	PRIMARY KEY (id_premii)
);
ALTER TABLE rozliczenia1.pracownicy
ADD FOREIGN KEY (id_godziny) REFERENCES rozliczenia.godziny(id_godziny);

ALTER TABLE rozliczenia1.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia1.pracownicy(id_pracownika);

ALTER TABLE rozliczenia1.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia1.premie(id_premii);

INSERT INTO rozliczenia1.pracownicy
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

INSERT INTO rozliczenia1.godziny
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

INSERT INTO rozliczenia1.pensje
VALUES
('23', '2', '101', '10'),
('232','4', '102', '12'),
('24', '5', '103', '11'),
('33', '6', '104', '14'),
('53', '43','105', '13'),
('63', '23','106', '16'),
('73', '3', '107', '15'),
('83', '4', '108', '18'),
('93', '8', '109', '17'),
('26', '7', '110', '19');

INSERT INTO rozliczenia1.premie
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

SELECT nazwisko, Address FROM rozliczenia1.pracownicy;
SELECT DATEPART(month, 'data') AS DatePartMonth
SELECT DATEPART(day, 'data') AS DatePartDay;
SELECT kwota_brutto/(1+0.23) AS kwota_netto
FROM rozliczenia1.pensje;
