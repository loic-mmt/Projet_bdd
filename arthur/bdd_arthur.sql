

CREATE TABLE PAYS_ARTISTE(
    idArtiste INT NOT NULL,
    pays_iso2 CHAR(2), -- Artists can have unknow or to ancient country to have iso2 code.
    PRIMARY KEY (idArtiste, pays_iso2),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO PAYS_ARTISTE (idArtiste, pays_iso2)
SELECT idArtiste, pays
FROM ARTISTE;

CREATE TABLE METIER_ARTISTE(
    idArtiste INT NOT NULL,
    metier CHAR(1) NOT NULL,
    PRIMARY KEY idArtiste,
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO METIER_ARTISTE (idArtiste, metier)
SELECT idArtiste, type
FROM ARTISTE;

ALTER TABLE ARTISTE
    DROP pays, type;

CREATE TABLE PAYS_FILM(
    idFilm INT NOT NULL,
    pays_iso2 CHAR(2), -- Same thing
    PRIMARY KEY (idArtiste, pays_iso2),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO PAYS_FILM (idFilm, pays_iso2)
    SELECT idFilm, codePays
    FROM FILM;

ALTER TABLE FILM
    DROP codePays;

CREATE TABLE ALBUM_COPIE (
    idAlbum INT NOT NULL,
    titre VARCHAR(100) NOT NULL,
    annee INT, -- Albums can have unknow year of droping.
    genre VARCHAR(30) NOT NULL,
    idArtistePrincipal INT NOT NULL,
    label VARCHAR(50), -- Albums can have no or Unknow label.
    PRIMARY KEY idAlbum,
    FOREIGN KEY (idArtistePrincipal) REFERENCES ARTISTE(idArtiste)
    );

INSERT INTO ALBUM_COPIE (idAlbum, titre, annee, genre, idArtistePrincipal, label)
    SELECT idAlbum, titre, annee, genre, idArtistePrincipal, label
    FROM ALBUM;

DROP TABLE ALBUM;

ALTER TABLE ALBUM_COPIE
    RENAME TO ALBUM;

CREATE TABLE PAYS_UTILISATEUR(
    idUser INT NOT NULL,
    pays_iso2 CHAR(2) NOT NULL, -- Users have know and actual countries.
    PRIMARY KEY (idUser, pays_iso2),
    FOREIGN KEY (idUser) REFERENCES UTILISATEUR(idUser)
    );

INSERT INTO PAYS_UTILISATEUR(idUser, pays_iso2)
    SELECT idUser, pays
    FROM UTILISATEUR;

ALTER TABLE UTILISATEUR
    DROP pays;

CREATE TABLE AVIS_COPIE (
    idAvis INT NOT NULL,
    idUser INT NOT NULL,
    idFilm INT NOT NULL,
    idAlbum INT NOT NULL,
    note INT CHECK(note BETWEEN 0 AND 5) NOT NULL,
    commentaire VARCHAR(255), -- We've supposed that you can leave a note without a commentaire.
    dateAvis DATE NOT NULL,
    PRIMARY KEY id_Avis,
    FOREIGN KEY idUser REFERENCES UTILISATEUR(IdUser),
    FOREIGN KEY idFilm REFERENCES FILM(idFilm),
    FOREIGN KEY idAlbum REFERENCES ALBUM(idAlbum)
);

INSERT INTO AVIS_COPIE(idAvis, idUser, idFilm, idAlbum, note, commentaire, dateAvis)
    SELECT idAvis, idUser, idFilm, idAlbum, note, commentaire, dateAvis
    FROM AVIS;

DROP TABLE AVIS;

ALTER TABLE AVIS_COPIE
    RENAME TO AVIS;

CREATE TABLE PARTICIPE_FILM_COPIE(
    idArtiste INT NOT NULL,
    idFilm INT NOT NULL,
    role VARCHAR(100), --Augmentation of the maxlength if artists have multiple roles in the same film.
                       -- We don't know if an artist can have an unknow role in a film, so we authorize NULL by default.
    PRIMARY KEY (idArtiste, idFilm),
    FOREIGN KEY idArtiste REFERENCES ARTISTE(idArtiste),
    FOREIGN KEY idFilm REFERENCES FILM(idFilm)
    );

INSERT INTO PARTICIPE_FILM_COPIE(idArtiste, idFilm, role)
    SELECT idArtiste, idFilm, role
    FROM PARTICIPE_FILM;

DROP TABLE PARTICIPE_FILM;

ALTER TABLE PARTICIPE_FILM_COPIE
    RENAME TO PARTICIPE_FILM;

-- Adding constraints to table we haven't recreated.

CREATE TABLE ARTISTE_COPIE (
    idArtiste INT NOT NULL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    naissance DATE --Artists can have unknow born date
);

INSERT INTO ARTISTE_COPIE(idArtiste, nom, naissance)
    SELECT idArtiste, nom, naissance
    FROM ARTISTE;

DROP TABLE ARTISTE;

ALTER TABLE ARTISTE_COPIE 
    RENAME TO ARTISTE;

CREATE TABLE FILM_COPIE (
    idFilm INT NOT NULL PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    annee INT, -- Same than for ALBUM
    genre VARCHAR(30) NOT NULL,
    idRealisateur INT NOT NULL,
    FOREIGN KEY (idRealisateur) REFERENCES ARTISTE(idArtiste)
);

INSERT INTO FILM_COPIE(idFilm, titre, annee, genre, idRealisateur)
    SELECT idFilm, titre, annee, genre, idRealisateur
    FROM FILM;

DROP TABLE FILM;

ALTER TABLE FILM_COPIE
    RENAME TO FILM;


CREATE TABLE UTILISATEUR_COPIE (
    idUser INT NOT NULL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    age INT (age < 125) NOT NULL
);

INSERT INTO UTILISATEUR_COPIE(idUser, nom, age)
    SELECT idUser, nom, age
    FROM UTILISATEUR;

DROP TABLE UTILISATEUR;

ALTER TABLE UTILISATEUR_COPIE
    RENAME TO UTILISATEUR;