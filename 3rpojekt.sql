-- Autor: Michal Fric  <xfricm02> 
-- Autor: Matej Slivka <xslivk03>

DROP TABLE Evidencia_predanych;
DROP TABLE Dodavatel_liek;
DROP TABLE Objednavka_liek;
DROP TABLE Pobocka_dodavatel;
DROP TABLE Pobocka_liek;
DROP TABLE Rezervacia_liek;
DROP TABLE Poistovna_liek;
DROP TABLE Liek;
DROP TABLE Dodavatel;
DROP TABLE Objednavka;
DROP TABLE Rezervacia;
DROP TABLE Zakaznik;
DROP TABLE Poistovna;
DROP TABLE Pobocka;

CREATE TABLE Poistovna (
    ID_poistovne INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    vyska_prispevku DECIMAL(15,2) NULL,
    vedlajsie_info VARCHAR(255)
);

CREATE TABLE Zakaznik (
    IDzakaznik INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    meno VARCHAR(255) NOT NULL ,  
    rodne_cislo VARCHAR(10) NOT NULL,
    CONSTRAINT rodne_cislo_ID
        CHECK(REGEXP_LIKE(rodne_cislo,'^[0-9]{2}([05][1-9]|[16][0-2])([0][1-9]|[1-2][0-9]|[3][0-1])[0-9]{4}$')),
    ID_poistovne INT REFERENCES Poistovna 
);

CREATE TABLE Pobocka (
    IDpobocka INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    adresa VARCHAR(255),
    stav_skladu VARCHAR(255)
);



CREATE TABLE Rezervacia (
    IDrezervacie INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    datum DATE,
    stav VARCHAR(50),
    ID_poistovne INT REFERENCES Poistovna,
    IDpobocka INT REFERENCES Pobocka,
    IDZakaznik INT REFERENCES Zakaznik
);

CREATE TABLE Objednavka (
    IDobjednavka INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    datum DATE,
    stav VARCHAR(20),
    ID_poistovne INT REFERENCES Poistovna,
    IDzakaznik INT REFERENCES Zakaznik,
    IDpobocka INT REFERENCES Pobocka
);

CREATE TABLE Dodavatel (
    IDdodavatel INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    nazov VARCHAR(255),
    adresa VARCHAR(255),
    kontakt VARCHAR(255),
    ico VARCHAR(8),
    dic VARCHAR(10)
);

CREATE TABLE Liek(
    IDliek INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    cena DECIMAL(15,2),
    predpis VARCHAR(3),
    prispevok DECIMAL(15,2),
    spotreba DATE,
    dostupnost VARCHAR(1)
);

CREATE TABLE Evidencia_predanych(
    IDnakupu INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    datum_nakupu DATE,
    mnozstvo INT,
    IDpobocka INT REFERENCES Pobocka,
    IDliek INT REFERENCES Liek
);

CREATE TABLE Poistovna_liek (
    ID_poistovne INT NOT NULL REFERENCES Poistovna,
    IDliek INT NOT NULL REFERENCES Liek,
    CONSTRAINT poistovna_liek_pk
        PRIMARY KEY (ID_poistovne, IDliek)
);

CREATE TABLE Rezervacia_liek (
    ID_poistovne INT NOT NULL REFERENCES Poistovna,
    IDliek INT NOT NULL REFERENCES Liek,
    CONSTRAINT rezervacia_liek_pk
        PRIMARY KEY (ID_poistovne, IDliek)
);

CREATE TABLE Pobocka_liek (
    IDpobocka INT NOT NULL REFERENCES Pobocka,
    IDliek INT NOT NULL REFERENCES Liek,
    CONSTRAINT pobocka_liek_pk
        PRIMARY KEY (IDpobocka, IDliek)
);

CREATE TABLE Pobocka_dodavatel (
    IDpobocka INT NOT NULL REFERENCES Pobocka,
    IDdodavatel INT NOT NULL REFERENCES Dodavatel,
    CONSTRAINT pobocka_dodavatel_pk
        PRIMARY KEY (IDpobocka, IDdodavatel)
);

CREATE TABLE Objednavka_liek (
    IDobjednavka INT NOT NULL REFERENCES Objednavka,
    IDliek INT NOT NULL REFERENCES Liek,
    CONSTRAINT Objednavka_liek_pk
        PRIMARY KEY (IDobjednavka, IDliek)
);

CREATE TABLE Dodavatel_liek (
    IDdodavatel INT NOT NULL REFERENCES Dodavatel,
    IDliek INT NOT NULL REFERENCES Liek,
    CONSTRAINT dodavatel_liek_pk
        PRIMARY KEY (IDdodavatel, IDliek)
);

INSERT INTO Liek ( cena, predpis, prispevok, spotreba, dostupnost)
VALUES ('12.50','ano','2.50', TO_DATE('2021-04-29 17:00 ', 'yyyy-mm-dd hh24:mi'),1);   --1
INSERT INTO Liek ( cena, predpis, prispevok, spotreba, dostupnost)
VALUES ('0.49','nie','0.0', TO_DATE('2021-08-17 23:26 ', 'yyyy-mm-dd hh24:mi'),1);     --2
INSERT INTO Liek ( cena, predpis, prispevok, spotreba, dostupnost)
VALUES ('124.50','nie','23.50', TO_DATE('2024-09-01 17:00 ', 'yyyy-mm-dd hh24:mi'),1); --3
INSERT INTO Liek ( cena, predpis, prispevok, spotreba, dostupnost)
VALUES ('73.00','ano','3.00', TO_DATE('2019-12-31 18:00 ', 'yyyy-mm-dd hh24:mi'),1);   --4
INSERT INTO Liek ( cena, predpis, prispevok, spotreba, dostupnost)
VALUES ('10.00','ano','5.00', TO_DATE('2022-03-30 4:00 ', 'yyyy-mm-dd hh24:mi'),1);    --5

INSERT INTO Dodavatel ( nazov, adresa, kontakt, ico ,dic)
VALUES ('Masokombinat Svit','Svit poskalka 05921','+421954786232','11012453','CZ00121243');     --1
INSERT INTO Dodavatel ( nazov, adresa, kontakt, ico ,dic)
VALUES ('Soros s.r.o. ','Washington 6th Avenue 63281','+12391731264','66666666','US06660666');  --2
INSERT INTO Dodavatel ( nazov, adresa, kontakt, ico ,dic)
VALUES ('Johnson Johnson','Brusel leFork 789456','+763816254385','94982811','BE10283774');      --3
INSERT INTO Dodavatel ( nazov, adresa, kontakt, ico ,dic)
VALUES ('Igor Kmeto Zivotabudic a.s.','Hrochot Druzstevna 12304','+421931937465','10039573','SK09124568'); --4

INSERT INTO Poistovna ( vyska_prispevku, vedlajsie_info) 
VALUES (10.0,'Ceska poistovna');                          --1
INSERT INTO Poistovna ( vyska_prispevku, vedlajsie_info) 
VALUES (2.50,'Reifeisen poistovna');                     --2
INSERT INTO Poistovna ( vyska_prispevku, vedlajsie_info) 
VALUES (23.50,'AIDS poistovna');                         --3

INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Jan Novák','0203307623',1);                       --1
INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Peter Askol','7601107624',1);                     --2
INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Viktoria Orbanova','4611277616',3);               --3
INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Daniel Drevo','0012121318',2);                    --4
INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Igor Kmeto','8311107530',3);                      --5
INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Kim Jong Ill','5610307527',2);                    --6
INSERT INTO Zakaznik ( meno,rodne_cislo, ID_poistovne) 
VALUES ( 'Adam Gajdos','0103037528',2);                     --7

INSERT INTO Pobocka ( adresa, stav_skladu)
VALUES ('Ochotnicka 24 03291 Tomasovce', 'prazdny na 80%');     --1
INSERT INTO Pobocka ( adresa, stav_skladu)
VALUES ('Druzstevna 12 03591 Bosany', 'prazdny na 50%');        --2
INSERT INTO Pobocka ( adresa, stav_skladu)
VALUES ('Hlavna 123 06511 Brno', 'prazdny na 10%');             --3

INSERT INTO Rezervacia ( datum, stav,ID_poistovne, IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-03-31 17:00 ', 'yyyy-mm-dd hh24:mi'),'Pripravuje sa',1,2,2);        --1
INSERT INTO Rezervacia ( datum, stav,ID_poistovne,IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-06-06 12:00 ', 'yyyy-mm-dd hh24:mi'),'Tovar prevziaty',1,2,2);    --2
INSERT INTO Rezervacia ( datum, stav,ID_poistovne,IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-06-06 13:00 ', 'yyyy-mm-dd hh24:mi'),'Pripravuje sa',1,1,2);        --3
INSERT INTO Rezervacia ( datum, stav,ID_poistovne,IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-07-07 17:00 ', 'yyyy-mm-dd hh24:mi'),'Tovar prevziaty',1,4,2);    --4
INSERT INTO Rezervacia ( datum, stav,ID_poistovne,IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-07-20 17:00 ', 'yyyy-mm-dd hh24:mi'),'Tovar pripraveny na prevzatie',2,3,2);
INSERT INTO Rezervacia ( datum, stav,ID_poistovne,IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-07-20 18:00 ', 'yyyy-mm-dd hh24:mi'),'Tovar pripraveny na prevzatie',2,1,2);
INSERT INTO Rezervacia ( datum, stav,ID_poistovne,IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-10-29 1:00 ', 'yyyy-mm-dd hh24:mi'),'Tovar pripraveny na prevzatie',1,1,1);

INSERT INTO Objednavka ( datum, stav,ID_poistovne, IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-03-31 17:00 ', 'yyyy-mm-dd hh24:mi'),'Pripravuje sa',1,1,2);
INSERT INTO Objednavka ( datum, stav,ID_poistovne, IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-01-09 17:31 ', 'yyyy-mm-dd hh24:mi'),'Tovar prevziaty',2,2,2);
INSERT INTO Objednavka ( datum, stav,ID_poistovne, IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-02-23 11:00 ', 'yyyy-mm-dd hh24:mi'),'Tovar je zaplateny',3,7,2);
INSERT INTO Objednavka ( datum, stav,ID_poistovne, IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2021-03-27 18:00 ', 'yyyy-mm-dd hh24:mi'),'Pripravuje sa',1,5,2);
INSERT INTO Objednavka ( datum, stav,ID_poistovne, IDzakaznik, IDpobocka) 
VALUES (TO_DATE('2019-04-18 01:00 ', 'yyyy-mm-dd hh24:mi'),'Pripravuje sa',1,1,2);

INSERT INTO Poistovna_liek (ID_poistovne, IDliek)
VALUES (1,1);
INSERT INTO Poistovna_liek (ID_poistovne, IDliek)
VALUES (2,2);
INSERT INTO Poistovna_liek (ID_poistovne, IDliek)
VALUES (2,3);
INSERT INTO Poistovna_liek (ID_poistovne, IDliek)
VALUES (3,2);
INSERT INTO Poistovna_liek (ID_poistovne, IDliek)
VALUES (3,3);


INSERT INTO Rezervacia_liek (ID_poistovne, IDliek)
VALUES (1,1);

INSERT INTO Pobocka_liek (IDpobocka, IDliek)
VALUES (1,1);
INSERT INTO Pobocka_liek (IDpobocka, IDliek)
VALUES (2,5);
INSERT INTO Pobocka_liek (IDpobocka, IDliek)
VALUES (3,1);
INSERT INTO Pobocka_liek (IDpobocka, IDliek)
VALUES (2,2);
INSERT INTO Pobocka_liek (IDpobocka, IDliek)
VALUES (1,4);
INSERT INTO Pobocka_liek (IDpobocka, IDliek)
VALUES (2,4);

INSERT INTO Pobocka_dodavatel(IDpobocka, IDdodavatel)
VALUES (1,1);

INSERT INTO Objednavka_liek(IDobjednavka, IDliek)
VALUES (1,1);
INSERT INTO Objednavka_liek(IDobjednavka, IDliek)
VALUES (2,1);
INSERT INTO Objednavka_liek(IDobjednavka, IDliek)
VALUES (3,3);
INSERT INTO Objednavka_liek(IDobjednavka, IDliek)
VALUES (4,4);
INSERT INTO Objednavka_liek(IDobjednavka, IDliek)
VALUES (5,3);

INSERT INTO Dodavatel_liek(IDdodavatel, IDliek)
VALUES (1,1);

INSERT INTO Evidencia_predanych (datum_nakupu ,mnozstvo ,IDpobocka,IDliek)
VALUES (TO_DATE('2021-03-31', 'yyyy-mm-dd hh24:mi'),2,1,1);

-----------------------------------------------------------SELECTY---------------------------------------
-------- vypisanie rezervacii zakaznika Peter Askol --------------
-------- spojenie dvoch tabuliek
SELECT * 
FROM Rezervacia R INNER JOIN Zakaznik Z ON R.IDZAKAZNIK = Z.IDZAKAZNIK
WHERE Z.meno = 'Peter Askol';

----- chceme mena zakznikov ktory su v Reifeisen poistovni --------------------
----- spojenie dvoch tabuliek
SELECT z.meno
FROM Zakaznik z NATURAL JOIN Poistovna p
WHERE p.vedlajsie_info = 'Reifeisen poistovna';

---- ktory zakanik ma pripravenu rezervaciu na pobocke
---- spojenie troch tabuliek 
SELECT *
FROM Zakaznik z INNER JOIN Rezervacia r ON r.IDzakaznik=z.IDzakaznik  INNER JOIN Pobocka p ON p.IDpobocka= r.IDpobocka
WHERE r.Stav = 'Tovar pripraveny na prevzatie';


---- vypisanie poctu objednavok na jednej pobocke
---- agregacna funkcia a group by
SELECT pl.IDpobocka , COUNT(pl.IDliek) pocet
FROM Pobocka_liek pl
GROUP BY pl.IDpobocka;

------ vypisanie vydajov zakaznika
------ agregacna funkcia a group by
SELECT o.IDzakaznik , SUM(l.Cena) liekcena
FROM Objednavka o INNER JOIN Objednavka_liek ol ON ol.IDobjednavka = o.IDobjednavka INNER JOIN Liek l ON ol.IDliek = l.IDliek
GROUP BY o.IDzakaznik;


----- vypis id pobociek kde je ID lieku 4
---  predikat exists
SELECT IDpobocka
FROM Pobocka_liek
WHERE EXISTS(
    SELECT *
    FROM Liek l 
    WHERE l.IDliek = 4 AND Pobocka_liek.IDliek = 4 
);


------- ktory zkaznik nema ziadnu objednavku
----- predikat IN a select
SELECT z.meno
FROM Zakaznik z
WHERE z.IDzakaznik NOT IN (
    SELECT DISTINCT o.IDzakaznik
    FROM Objednavka o
);
