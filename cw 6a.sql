CREATE TABLE zamowienia(
id_produktu int PRIMARY KEY,
nazwa_produktu varchar(255),
id_klienta int,
nazwa_klienta varchar(255),
data_zamowienia varchar(255),
cena_produktu int,
iloœæ int,
VAT int,
suma_brutto int,
suma_netto int
);
--zaleznosci
id_produktu -> nazwa_produktu
id_produktu -> cena_produktu
id_klienta -> nazwa_klienta
id_produktu, id_klienta -> data_zamowienia
cena_produktu, iloœæ, VAT -> suma_brutto
cena_produktu, iloœæ -> suma_netto
suma_brutto -> VAT, suma_netto
nazwa_produktu, id_klienta -> id_produktu
data_zamowienia -> id_klienta, id_produktu, iloœæ

Klucze_kandyduj¹ce: id_produktu, id_klienta, data_zamowienia  



CREATE TABLE pomieszczenia(
id_pomieszczenia int PRIMARY KEY,
numer_pomieszczenia int,
id_budynku int,
powierzchnia varchar(255),
liczba_okien int, 
liczba_drzwi int,
ulica varchar(255),
miasto varchar(255),
kod_pocztowy varchar(255)
);
numer_pomieszczenia, id_budynku -> powierzchnia, liczba_okien, liczba_drzwi
id_budynku -> ulica, miasto, kod_pocztowy
numer_pomieszczenia, ulica, miasto -> id_pomieszczenia
miasto, kod_pocztowy -> ulica
id_budynku, numer_pomieszczenia -> id_pomieszczenia
id_budynku, numer_pomieszczenia -> powierzchnia, liczba_okien, liczba_drzwi

KLUCZE KANDYDUJ¥CE: 
1. numer_pomieszczenia, id_budynku, id_pomieszczenia
