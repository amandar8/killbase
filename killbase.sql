DROP DATABASE IF EXISTS killbase;

CREATE DATABASE killbase;

\c killbase

CREATE TABLE assassins (id serial primary key, full_name text, weapon text, age integer, price integer, rating numeric (2,1), kills integer);
INSERT INTO assassins (full_name, weapon, age, price, rating, kills)
VALUES
('Alexander Duggan','Sniper Rifle', 31, 45, 7.5, 28),
('Anton Chigurh', 'Pneumatic bolt gun', 52, 40, 9, 72),
(null, 'Pistol', 28, 20, 6.5, 35),
('Jason Bourne', 'Parkour', 27, 25, 7, 48),
('John Wick', 'Lots of guns', 35, 50, 9.5, 433),
('Jules Winnfield', 'Pistol', 26, 15, 6.5, 13),
('Leon', 'Everything', 41, 30, 8.5, 87),
('Nikita Mears', 'Silenced pistols', 28, 30, 7, 32),
('Pickle Rick', 'Lasers and office supplies', 60, 0, 8, 24);

CREATE TABLE code_names (assassins_id integer references assassins (id), code_names text);
INSERT INTO code_names (assassins_id, code_names)
VALUES
(1, 'The Jackal'),
(2, 'Old Man'),
(3, 'Ghost Dog'),
(5, 'Baba Yaga'),
(7, 'The Professional'),
(8, 'Nikita'),
(8, 'La Femme Nikita'),
(9, 'Solenya');

CREATE TABLE clients (id serial primary key, client_name text);
INSERT INTO clients (client_name)
VALUES
('Marcellus Wallace'),
('Concerto'),
('Mathilda'),
('Winston'),
('Ray Vargo');


CREATE TABLE targets (id serial primary key, target_name text, target_location text, target_photo text, target_security integer);
INSERT INTO targets (target_name, target_location, target_photo, target_security)
VALUES
('Butch Coolidge', 'Los Angeles', 'https://goo.gl/LCquZj', 3),
('The Jaguar', 'Russian Embassy', 'https://goo.gl/6JWsiv', 9),
('Norman Stansfield', 'Manhattan', 'https://i.imgur.com/mdIk33E.jpg', 7),
('Santino D''Antonio', 'Continental Hotel', 'https://goo.gl/fUPkYy', 10),
('Sonny Valerio', 'Queens', 'https://goo.gl/8DHYUS', 4);

CREATE TABLE contracts (id serial primary key, client_id integer references clients (id), budget integer, target_id integer references targets (id), completed boolean, assassins_id integer references assassins (id));
INSERT INTO contracts (client_id, budget, target_id, completed, assassins_id)
VALUES
(1, 40, 1, false, null),
(2, 70, 2, false, null),
(3, 35, 3, false, null),
(4, 25, 4, false, null),
(5, 10, 5, false, null);

CREATE TABLE assassins_contracts (assassins_id integer references assassins (id), contract_id integer references contracts (id));
INSERT INTO assassins_contracts (assassins_id, contract_id)
VALUES
(6, 1),
(1, 2),
(5, 2),
(7, 3),
(9, 5),
(6, 4),
(8, 3),
(3, 1);

SELECT * FROM assassins;
SELECT * FROM code_names;
SELECT * FROM clients;
SELECT * FROM contracts;
SELECT * FROM targets;
SELECT * FROM assassins_contracts;

SELECT * FROM assassins ORDER BY kills DESC;
SELECT * FROM assassins WHERE age>30;
SELECT * FROM contracts WHERE budget>=30;
SELECT * FROM assassins WHERE rating>=7;
SELECT SUM(price) FROM assassins;
SELECT COUNT(*) FROM assassins_contracts;

INSERT INTO targets (target_name, target_location, target_photo, target_security)
VALUES
('Snake Plissken', 'New York', 'https://imgur.com/gallery/kEuzp', 5);

SELECT * FROM targets;
