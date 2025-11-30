-- Données manquantes

-- Album :
DELETE FROM ALBUM
WHERE titre IS NULL
  AND genre IS NULL;

UPDATE ALBUM
SET label = 'RCA Records'
WHERE idAlbum = 100;

UPDATE ALBUM
SET annee = 1972
WHERE idAlbum = 101;

-- Artiste :
DELETE FROM ARTISTE
WHERE idArtiste = 15;

UPDATE ARTISTE
SET pays = 'FR'
WHERE idArtiste = 4;

UPDATE ARTISTE
SET naissance = '1963-12-18'
WHERE idArtiste = 2;

UPDATE ARTISTE
SET naissance = '1947-01-08'
WHERE idArtiste = 5;

UPDATE ARTISTE
SET naissance = '1770-12-15'
WHERE idArtiste = 10;

UPDATE ARTISTE
SET type = 'M'
WHERE idArtiste = 3;

UPDATE ARTISTE
SET type = 'R'
WHERE idArtiste = 6;

UPDATE ARTISTE
SET type = 'A'
WHERE idArtiste = 13;

INSERT INTO ARTISTE VALUES
	(15, 'Melville', 'FR', '1917-10-20', 'R'),
	(16, 'Polanski', 'PL', '1933-08-18', 'R')

-- Avis :
DELETE FROM AVIS
WHERE idAvis = 250; 

UPDATE AVIS
SET note = CASE
  WHEN note < 0 THEN 0
  WHEN note > 5 THEN 5
  ELSE note
END;

UPDATE AVIS
SET dateAvis = '2022-02-01'
WHERE idArtiste = 202;

-- Film :
DELETE FROM FILM
WHERE idFilm = 16; 

UPDATE FILM
SET titre = 'Diversion'
WHERE idFilm = 14;

UPDATE FILM
SET genre = 'Action'
WHERE idFilm = 11;

UPDATE FILM
SET idRealisateur = 15,
    codePays = 'FR'
WHERE idFilm = 11;

UPDATE FILM
SET idRealisateur = 16
WHERE idFilm = 15;

-- Participe_film :
UPDATE PARTICIPE_FILM
SET role = 'ROLE_CORRECT'
WHERE idFilm = 11;

-- Utilisateur :
DELETE FROM UTILISATEUR
WHERE nom IS NULL;