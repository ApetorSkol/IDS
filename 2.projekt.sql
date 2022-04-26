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
    c_poistovne INT,
    CONSTRAINT c_poistovne_fk
        FOREIGN KEY (c_poistovne) REFERENCES Poistovna (ID_poistovne) ON DELETE CASCADE
);

CREATE TABLE Pobocka (
    IDpobocka INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    adresa VARCHAR(255),
    stav_skladu VARCHAR(255)
);



CREATE TABLE Rezervacia (
    IDrezervacie INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    datum DATE,
    stav VARCHAR(20),
    rez_c_poistovne INT,
    CONSTRAINT rez_c_poistovne_fk
        FOREIGN KEY (rez_c_poistovne) REFERENCES Poistovna (ID_poistovne) ON DELETE CASCADE,
    rez_zakaznik INT,
    CONSTRAINT rez_zakaznik_fk
        FOREIGN KEY (rez_zakaznik) REFERENCES Zakaznik (IDzakaznik) ON DELETE CASCADE,
    rez_pobocka INT,
    CONSTRAINT rez_pobocka_fk
        FOREIGN KEY (rez_pobocka) REFERENCES Pobocka (IDpobocka) ON DELETE CASCADE
);

CREATE TABLE Objednavka (
    IDobjednavka INT GENERATED AS IDENTITY NOT NULL PRIMARY KEY,
    datum DATE,
    stav VARCHAR(20),
    obj_c_poistovne INT,
    CONSTRAINT obj_c_poistovne_fk
        FOREIGN KEY (obj_c_poistovne) REFERENCES Poistovna (ID_poistovne) ON DELETE CASCADE,
    obj_zakaznik INT,
    CONSTRAINT obj_zakaznik_fk
        FOREIGN KEY (obj_zakaznik) REFERENCES Zakaznik (IDzakaznik) ON DELETE CASCADE,
    obj_pobocka INT,
    CONSTRAINT obj_pobocka_fk
        FOREIGN KEY (obj_pobocka) REFERENCES Pobocka (IDpobocka) ON DELETE CASCADE
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
    pobocka_evidencia INT,
    CONSTRAINT pobocka_evidencia_FK
        FOREIGN KEY (pobocka_evidencia) REFERENCES Pobocka (IDpobocka) ON DELETE CASCADE,
    liek_evidencia INT,
    CONSTRAINT liek_evidencia_fk
        FOREIGN KEY (liek_evidencia) REFERENCES Liek (IDliek) ON DELETE CASCADE
);

CREATE TABLE Poistovna_liek (
    IDpoistovna INT NOT NULL,
    ID_liek INT NOT NULL,
    CONSTRAINT poistovna_liek_pk
        PRIMARY KEY (IDpoistovna, ID_liek),
    CONSTRAINT IDpoistovna_fk
        FOREIGN KEY (IDpoistovna) REFERENCES Poistovna (ID_poistovne)
        ON DELETE CASCADE,
    CONSTRAINT IDliek_fk
        FOREIGN KEY (ID_liek) REFERENCES Liek (IDliek)
        ON DELETE CASCADE
);

CREATE TABLE Rezervacia_liek (
    IDpoistovna_ID INT NOT NULL,
    ID_liek_ID INT NOT NULL,
    CONSTRAINT rezervacia_liek_pk
        PRIMARY KEY (IDpoistovna_ID, ID_liek_ID),
    CONSTRAINT IDpoistovna__fk
        FOREIGN KEY (IDpoistovna_ID) REFERENCES Poistovna (ID_poistovne)
        ON DELETE CASCADE,
    CONSTRAINT IDliek__fk
        FOREIGN KEY (ID_liek_ID) REFERENCES Liek (IDliek)
        ON DELETE CASCADE
);

CREATE TABLE Pobocka_liek (
    pobocka INT NOT NULL,
    liek INT NOT NULL,
    CONSTRAINT pobocka_liek_pk
        PRIMARY KEY (pobocka, liek),
    CONSTRAINT pobocka_fk
        FOREIGN KEY (pobocka) REFERENCES Pobocka (IDpobocka)
        ON DELETE CASCADE,
    CONSTRAINT liek_fk
        FOREIGN KEY (liek) REFERENCES Liek (IDliek)
        ON DELETE CASCADE
);

CREATE TABLE Pobocka_dodavatel (
    pobocka_ID INT NOT NULL,
    dodavatel_ID INT NOT NULL,
    CONSTRAINT pobocka_dodavatel_pk
        PRIMARY KEY (pobocka_ID, dodavatel_ID),
    CONSTRAINT pobocka_ID_fk
        FOREIGN KEY (pobocka_ID) REFERENCES Pobocka (IDpobocka)
        ON DELETE CASCADE,
    CONSTRAINT dodavatel_ID_fk
        FOREIGN KEY (dodavatel_ID) REFERENCES Dodavatel (IDdodavatel)
        ON DELETE CASCADE
);

CREATE TABLE Objednavka_liek (
    objednavka__ INT NOT NULL,
    liek__ INT NOT NULL,
    CONSTRAINT Objednavka_liek_pk
        PRIMARY KEY (objednavka__, liek__),
    CONSTRAINT objednavka___fk
        FOREIGN KEY (objednavka__) REFERENCES Objednavka (IDobjednavka)
        ON DELETE CASCADE,
    CONSTRAINT liek___fk
        FOREIGN KEY (liek__) REFERENCES Liek (IDliek)
        ON DELETE CASCADE
);

CREATE TABLE Dodavatel_liek (
    Dodavatel_l INT NOT NULL,
    Liek_k INT NOT NULL,
    CONSTRAINT dodavatel_liek_pk
        PRIMARY KEY (Dodavatel_l, Liek_k),
    CONSTRAINT Dodavatel_l_fk
        FOREIGN KEY (Dodavatel_l) REFERENCES Dodavatel (IDdodavatel)
        ON DELETE CASCADE,
    CONSTRAINT Liek_k_fk
        FOREIGN KEY (Liek_k) REFERENCES Liek (IDliek)
        ON DELETE CASCADE
);

INSERT INTO Liek ( cena, predpis, prispevok, spotreba, dostupnost)
VALUES ('12.50','ano','2.50', TO_DATE('2021-04-29 17:00 ', 'yyyy-mm-dd hh24:mi'),1);
INSERT INTO Dodavatel ( nazov, adresa, kontakt, ico ,dic)
VALUES ('masokombinat svit','svit poskalka','+421954786232','11012453','CZ00121243');
INSERT INTO Poistovna ( vyska_prispevku, vedlajsie_info) 
VALUES ('0.0','Ceska poistovna');
INSERT INTO Zakaznik ( meno,rodne_cislo, c_poistovne) 
VALUES ( 'Jan Novák','0203307623',1);
INSERT INTO Pobocka ( adresa, stav_skladu)
VALUES ('Ochotnicka 24 03291 Tomasovce', 'prazdny na 80');
INSERT INTO Rezervacia ( datum, stav,rez_c_poistovne, rez_zakaznik, rez_pobocka) 
VALUES (TO_DATE('2021-03-31 17:00 ', 'yyyy-mm-dd hh24:mi'),'Vybavuje sa',1,1,1);
INSERT INTO Objednavka ( datum, stav,obj_c_poistovne, obj_zakaznik, obj_pobocka) 
VALUES (TO_DATE('2021-03-31 17:00 ', 'yyyy-mm-dd hh24:mi'),'Vybavuje sa',1,1,1);
INSERT INTO Poistovna_liek (IDpoistovna, ID_liek)
VALUES (1,1);
INSERT INTO Rezervacia_liek (IDpoistovna_ID, ID_liek_ID)
VALUES (1,1);
INSERT INTO Pobocka_liek (pobocka, liek)
VALUES (1,1);
INSERT INTO Pobocka_dodavatel(pobocka_ID, dodavatel_ID)
VALUES (1,1);
INSERT INTO Objednavka_liek(objednavka__, liek__)
VALUES (1,1);
INSERT INTO Dodavatel_liek(Dodavatel_l, Liek_k)
VALUES (1,1);
INSERT INTO Evidencia_predanych (datum_nakupu ,mnozstvo ,pobocka_evidencia ,liek_evidencia)
VALUES (TO_DATE('2021-03-31', 'yyyy-mm-dd hh24:mi'),2,1,1);