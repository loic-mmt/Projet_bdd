

CREATE TABLE PAYS_ARTISTE(
    idArtiste INT,
    pays_iso2 CHAR(2),
    PRIMARY KEY (idArtiste, pays_iso2),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO PAYS_ARTISTE (idArtiste, pays_iso2)
SELECT idArtiste, pays
FROM ARTISTE;

CREATE TABLE METIER_ARTISTE(
    idArtiste INT,
    metier CHAR(1),
    PRIMARY KEY idArtiste,
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO METIER_ARTISTE (idArtiste, metier)
SELECT idArtiste, type
FROM ARTISTE;

ALTER TABLE ARTISTE
    DROP pays, type;

CREATE TABLE PAYS_FILM(
    idFilm INT,
    pays_iso2 CHAR(2),
    PRIMARY KEY (idArtiste, pays_iso2),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO PAYS_FILM (idFilm, pays_iso2)
    SELECT idFilm, codePays
    FROM FILM;

ALTER TABLE FILM
    DROP codePays