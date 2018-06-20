DROP DATABASE killbase;

CREATE DATABASE killbase;

\c killbase

CREATE TABLE assassins (id serial primary key, full_name text, code_names text, weapon text, age integer, price integer, rating numeric (2,1), kills integer);

INSERT INTO assassins (full_name, code_names, weapon, age, price, rating, kills) VALUES ('Alexander Duggan', 'The Jackal', 'Sniper Rifle', 31, 34, 45, 7.5, 28);
INSERT INTO Assassins (full_name, code_names, weapon, age, price, rating, kills) VALUES ('Anton Chigurh', 'Old Man', 'Pneumatic bolt gun', 52, 40, 9, 72);
INSERT INTO Assassins (code_names, weapon, age, price, rating, kills) VALUES ('Ghost Dog', 'Pistol', 28, 20, 6.5, 35);
INSERT INTO Assassins (full_name, weapon, age, price, rating, kills) VALUES ('Jason Bourne', 'Parkour', 27, 25, 7, 48);
INSERT INTO Assassins (full_name, code_names, weapon, age, price, rating, kills) VALUES ('John Wick', 'Baba Yaga', 'Lots of guns', 35, 50, 9.5, 433);
INSERT INTO Assassins (full_name, weapon, age, price, rating, kills) VALUES ('Jules Winnfield', 'Pistol', 26, 15, 6.5, 13);
INSERT INTO Assassins (full_name, code_names, weapon, age, price, rating, kills) VALUES ('Leon', 'The Professional', 'Everything', 41, 30, 8.5, 87);
INSERT INTO Assassins (full_name, code_names, weapon, age, price, rating, kills) VALUES ('Nikita Mears', 'Nikita, La Femme Nikita', 'Silenced pistols', 28, 30, 7, 32);
INSERT INTO Assassins (full_name, code_names, weapon, age, price, rating, kills) VALUES ('Pickle Rick', 'Solenya', 'Lasers and office supplies', 60, 0, 8, 24);

CREATE TABLE clients (id serial primary key, client_name text);
INSERT INTO clients (client_name) VALUES ('Marcellus Wallace');
INSERT INTO clients (client_name) VALUES ('Concerto');
INSERT INTO clients (client_name) VALUES ('Mathilda');
INSERT INTO clients (client_name) VALUES ('Winston');
INSERT INTO clients (client_name) VALUES ('Ray Vargo');


CREATE TABLE targets (id serial primary key, target_name text, target_location text, target_photo text, target_security integer);
INSERT INTO targets (target_name, target_location, target_photo, target_security) VALUES ('Butch Coolidge', 'Los Angeles', 'https://goo.gl/LCquZj', 3);
INSERT INTO targets (target_name, target_location, target_photo, target_security) VALUES ('The Jaguar', 'Russian Embassy', 'https://goo.gl/6JWsiv', 9);
INSERT INTO targets (target_name, target_location, target_photo, target_security) VALUES ('Norman Stansfield', 'Manhattan', 'https://i.imgur.com/mdIk33E.jpg', 7);
INSERT INTO targets (target_name, target_location, target_photo, target_security) VALUES ('Santino D''Antonio', 'Continental Hotel', 'https://goo.gl/fUPkYy', 10);
INSERT INTO targets (target_name, target_location, target_photo, target_security) VALUES ('Sonny Valerio', 'Queens', 'https://goo.gl/8DHYUS', 4);

CREATE TABLE Contracts (id serial primary key, client_id integer references clients (id), budget integer, target_id integer references targets (id), completed boolean, assassins_id integer references assassins (id));
INSERT INTO Contracts (client_id, budget, target_id, completed, assassins_id) VALUES (1, 40, 1, false, null);
INSERT INTO Contracts (client_id, budget, target_id, completed, assassins_id) VALUES (2, 70, 2, false, null);
INSERT INTO Contracts (client_id, budget, target_id, completed, assassins_id) VALUES (3, 35, 3, false, null);
INSERT INTO Contracts (client_id, budget, target_id, completed, assassins_id) VALUES (4, 25, 4, false, null);
INSERT INTO Contracts (client_id, budget, target_id, completed, assassins_id) VALUES (5, 10, 5, false, null);

CREATE TABLE assassins_contracts(contract_id integer references contracts(id), assassians_id integer references assassins(id));
SELECT * FROM assassins;
SELECT * FROM clients;
SELECT * FROM contracts;
SELECT * FROM targets;
SELECT * FROM assassins_contracts;
