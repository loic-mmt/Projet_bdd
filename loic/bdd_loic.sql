--- données manquantes

--- Album:
DELETE FROM ALBUM
 WHERE annee IS NULL;

UPDATE ALBUM
 WHERE
--- Artiste:
--- Avis:
UPDATE AVIS
SET note = 0
  WHERE note IS NULL;

UPDATE AVIS
SET note = CASE
  WHEN note < 0 THEN 0
  WHEN note > 5 THEN 5
  ELSE note
END;

--- Film:
--- Participe_film:
--- Utilisateur:
