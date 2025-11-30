PRAGMA foreign_keys = OFF;

CREATE TABLE ARTISTE_COPIE (
    idArtiste INT NOT NULL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    naissance DATE -- Artists can have unknow born date
);

INSERT INTO ARTISTE_COPIE(idArtiste, nom, naissance)
    SELECT idArtiste, nom, naissance
    FROM ARTISTE;

CREATE TABLE PAYS_ARTISTE(
    idArtiste INT NOT NULL,
    pays_iso2 CHAR(2), -- Artists can have unknow or to ancient country to have iso2 code.
    PRIMARY KEY (idArtiste, pays_iso2),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE_COPIE(idArtiste) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO PAYS_ARTISTE (idArtiste, pays_iso2)
    SELECT idArtiste, pays
    FROM ARTISTE;

CREATE TABLE METIER_ARTISTE(
    idArtiste INT NOT NULL,
    metier CHAR(1) NOT NULL,
    PRIMARY KEY (idArtiste),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE_COPIE(idArtiste) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO METIER_ARTISTE (idArtiste, metier)
    SELECT idArtiste, type
    FROM ARTISTE;

DROP TABLE ARTISTE;

ALTER TABLE ARTISTE_COPIE 
    RENAME TO ARTISTE;

CREATE TABLE UTILISATEUR_COPIE (
    idUser INT NOT NULL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    age INT CHECK(age < 125) NOT NULL
);

INSERT INTO UTILISATEUR_COPIE(idUser, nom, age)
    SELECT idUser, nom, age
    FROM UTILISATEUR;

CREATE TABLE PAYS_UTILISATEUR(
    idUser INT NOT NULL,
    pays_iso2 CHAR(2) NOT NULL, -- Users have know and actual countries.
    PRIMARY KEY (idUser, pays_iso2),
    FOREIGN KEY (idUser) REFERENCES UTILISATEUR_COPIE(idUser) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO PAYS_UTILISATEUR(idUser, pays_iso2)
    SELECT idUser, pays
    FROM UTILISATEUR;

DROP TABLE UTILISATEUR;

ALTER TABLE UTILISATEUR_COPIE
    RENAME TO UTILISATEUR;

CREATE TABLE FILM_COPIE (
    idFilm INT NOT NULL PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    annee INT, -- Same than for ALBUM
    genre VARCHAR(30) NOT NULL,
    idRealisateur INT NOT NULL,
    FOREIGN KEY (idRealisateur) REFERENCES ARTISTE(idArtiste) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO FILM_COPIE(idFilm, titre, annee, genre, idRealisateur)
    SELECT idFilm, titre, annee, genre, idRealisateur
    FROM FILM;

CREATE TABLE PAYS_FILM(
    idFilm INT NOT NULL,
    pays_iso2 CHAR(2), -- Same thing
    PRIMARY KEY (idFilm, pays_iso2),
    FOREIGN KEY (idFilm) REFERENCES FILM_COPIE(idFilm) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO PAYS_FILM (idFilm, pays_iso2)
    SELECT idFilm, codePays
    FROM FILM;

CREATE TABLE PARTICIPE_FILM_COPIE(
    idArtiste INT NOT NULL,
    idFilm INT NOT NULL,
    role VARCHAR(100), -- Augmentation of the maxlength if artists have multiple roles in the same film.
                       -- We don't know if an artist can have an unknow role in a film, so we authorize NULL by default.
    PRIMARY KEY (idArtiste, idFilm),
    FOREIGN KEY (idArtiste) REFERENCES ARTISTE(idArtiste) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idFilm) REFERENCES FILM_COPIE(idFilm) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO PARTICIPE_FILM_COPIE(idArtiste, idFilm, role)
    SELECT idArtiste, idFilm, role
    FROM PARTICIPE_FILM;

CREATE TABLE AVIS_FILM (
    idAvisFilm INT PRIMARY KEY,
    idUser INT NOT NULL,
    idFilm INT NOT NULL,
    note INT CHECK(note BETWEEN 0 AND 5) NOT NULL,
    commentaire VARCHAR(255), -- We've supposed that you can leave a note without a commentaire.
    dateAvis DATE NOT NULL,
    FOREIGN KEY (idUser) REFERENCES UTILISATEUR(idUser) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idFilm) REFERENCES FILM_COPIE(idFilm) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO AVIS_FILM(idAvisFilm, idUser, idFilm, note, commentaire, dateAvis)
    SELECT idAvis, idUser, idFilm, note, commentaire, dateAvis
    FROM AVIS
    WHERE idFilm IS NOT NULL;

DROP TABLE FILM;
DROP TABLE PARTICIPE_FILM;

ALTER TABLE FILM_COPIE RENAME TO FILM;
ALTER TABLE PARTICIPE_FILM_COPIE RENAME TO PARTICIPE_FILM;

CREATE TABLE ALBUM_COPIE (
    idAlbum INT NOT NULL PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    annee INT, -- Albums can have unknow year of droping.
    genre VARCHAR(30) NOT NULL,
    idArtistePrincipal INT NOT NULL,
    label VARCHAR(50), -- Albums can have no or Unknow label.
    FOREIGN KEY (idArtistePrincipal) REFERENCES ARTISTE(idArtiste) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO ALBUM_COPIE (idAlbum, titre, annee, genre, idArtistePrincipal, label)
    SELECT idAlbum, titre, annee, genre, idArtistePrincipal, label
    FROM ALBUM;

CREATE TABLE AVIS_ALBUM (
    idAvisAlbum INT PRIMARY KEY,
    idUser INT NOT NULL,
    idAlbum INT NOT NULL,
    note INT CHECK(note BETWEEN 0 AND 5) NOT NULL,
    commentaire VARCHAR(255), -- We've supposed that you can leave a note without a commentaire.
    dateAvis DATE NOT NULL,
    FOREIGN KEY (idUser) REFERENCES UTILISATEUR(idUser) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idAlbum) REFERENCES ALBUM_COPIE(idAlbum) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO AVIS_ALBUM(idAvisAlbum, idUser, idAlbum, note, commentaire, dateAvis)
    SELECT idAvis, idUser, idAlbum, note, commentaire, dateAvis
    FROM AVIS
    WHERE idAlbum IS NOT NULL;

DROP TABLE ALBUM;
ALTER TABLE ALBUM_COPIE RENAME TO ALBUM;

DROP TABLE AVIS;

PRAGMA foreign_keys = ON; 

-- Gestion of weird ids numerotation, each one have to begin from 0.

UPDATE ALBUM
    SET idAlbum = idAlbum -100;

UPDATE AVIS_ALBUM
    SET idAvisAlbum = idAvisAlbum -200;

UPDATE AVIS_FILM
    SET idAvisFilm = idAvisFilm -200;

UPDATE FILM
    SET idFilm = idFilm -10;

UPDATE UTILISATEUR
    SET idUser = idUser - 1000