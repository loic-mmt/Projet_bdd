INSERT INTO ARTISTE VALUES
	(1, 'Tarantino', 'USA', '1963-03-27', 'R'),
	(2, 'Pitt', 'USA', NULL, 'A'),
	(3, 'Morricone', 'Italy', '1928-11-10', NULL),
	(4, 'Delon', '', '1935-11-08', 'A'),
	(5, 'Bowie', 'Angleterre', NULL, 'M'),
	(6, 'Spielberg', 'USA', '1946-12-18', ''),  -- incohérent
	(7, 'Nolan', 'UK', '1970-07-30', 'R'),
	(8, 'Smith', 'USA', '1968-08-25', 'A'),
	(9, 'Mozart', 'Austria', '1756-01-27', 'M'),
	(10, 'Beethoven', 'Germany', NULL, 'M'),
	(11, 'Jackson', 'USA', '1958-08-29', 'M'),
	(12, 'Cameron', 'Canada', '1954-08-16', 'R'),
	(13, 'Lee', 'USA', '1940-11-27', ''),
	(14, 'Prince', 'USA', '1958-06-07', 'M'),
	(15, 'Unknown', '', NULL, NULL);

INSERT INTO FILM VALUES
	(10, 'Pulp Fiction', 1994, 'Crime', 1, 'USA'),
	(11, 'Inglourious Basterds', 2009, NULL, 1, 'FR'),
	(12, 'Le Samourai', 1967, 'Policier', NULL, NULL),
	(13, 'Inception', 2010, 'SF', 7, 'USA'),
	-- Mix of correct and incorrect data
	(14, '', 2015, 'Comedy', 8, 'USA'),
	(15, 'The Pianist', 2002, 'Drama', NULL, 'PL'),
	(16, 'Unknown Film', NULL, '', 99, '');

INSERT INTO ALBUM VALUES
	(100, 'Heroes', 1977, 'Rock', 5, NULL),
	(101, 'Once Upon a Time in the West', NULL, 'OST', 3, 'EMI'),
	(102, NULL, 2002, 'Jazz', 16, 'BlueNote'), -- artiste fantôme
	(103, 'Thriller', 1982, 'Pop', 11, 'Epic'),
	(104, 'Unknown Album', NULL, '', NULL, '');

INSERT INTO UTILISATEUR VALUES
	(1000, 'Valerie Dupont', 24, 'FR'),
	(1001, NULL, NULL, 'DE'),
	(1002, 'Paul', 38, 'FR'),
	(1003, 'Mona', 17, 'UK'),
	(1004, NULL, NULL, '');

-- Un avis sur un film inexistant, note hors bornes
INSERT INTO AVIS VALUES
	(201, 1000, 99, NULL, 19, NULL, '2022-01-17'),
	(202, 1002, 10, NULL, 8, 'Génial', NULL),
	(203, 1000, NULL, 101, -2, '', '2022-02-21'),
	(204, 1003, 13, NULL, 5, 'Très bon film', '2023-07-11'),
	(250, 1050, NULL, NULL, 10, NULL, NULL);

INSERT INTO PARTICIPE_FILM VALUES
	(2, 10, 'Acteur'),
	(3, 10, 'Compositeur'),
	(2, 11, 'Acteur'),
	(1, 10, 'Scénariste'),
	(1, 11, NULL),
	(50, 60, 'Acteur');;