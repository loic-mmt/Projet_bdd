CREATE TABLE ARTISTE (
    idArtiste INT PRIMARY KEY,
    nom VARCHAR(50),
    pays VARCHAR(40),
    naissance DATE,
    type CHAR(1) -- 'R'=réalisateur, 'A'=acteur, 'M'=musicien, parfois laissé vide ou incohérent
);

CREATE TABLE FILM (
    idFilm INT PRIMARY KEY,
    titre VARCHAR(100),
    annee INT,
    genre VARCHAR(30),
    idRealisateur INT,
    codePays VARCHAR(10),
    FOREIGN KEY (idRealisateur) REFERENCES ARTISTE(idArtiste)
);

CREATE TABLE ALBUM (
    idAlbum INT PRIMARY KEY,
    titre VARCHAR(100),
    annee INT,
    genre VARCHAR(30),
    idArtistePrincipal INT,
    label VARCHAR(50)
    -- pas de clé étrangère définie ici exprès
);

CREATE TABLE UTILISATEUR (
    idUser INT PRIMARY KEY,
    nom VARCHAR(100),
    age INT,
    pays VARCHAR(40)
);

CREATE TABLE AVIS (
    idAvis INT PRIMARY KEY,
    idUser INT,
    idFilm INT,
    idAlbum INT,
    note INT,
    commentaire VARCHAR(255),
    dateAvis DATE
    -- manques de contraintes d'intégrité, acceptation de notes hors bornes, null acceptés partout
);

CREATE TABLE PARTICIPE_FILM (
    idArtiste INT,
    idFilm INT,
    role VARCHAR(30)
    -- pas de clé primaire, redondances possibles
);
-- Pas de table PAYS ici pour ajouter du flou
-- Pas d’historique des propositions dans cette version "sale"