DROP DATABASE IF EXISTS killbase;

CREATE DATABASE killbase;

\c killbase

--create assassins table
CREATE TABLE assassins (id serial primary key, full_name text, weapon text, age integer, price integer, rating numeric (2,1), kills integer);
INSERT INTO assassins (id, full_name, weapon, age, price, rating, kills)
VALUES
(DEFAULT, 'Alexander Duggan','Sniper Rifle', 31, 45, 7.5, 28),
(DEFAULT, 'Anton Chigurh', 'Pneumatic bolt gun', 52, 40, 9, 72),
(DEFAULT, null, 'Pistol', 28, 20, 6.5, 35),
(DEFAULT, 'Jason Bourne', 'Parkour', 27, 25, 7, 48),
(DEFAULT, 'John Wick', 'Lots of guns', 35, 50, 9.5, 433),
(DEFAULT, 'Jules Winnfield', 'Pistol', 26, 15, 6.5, 13),
(DEFAULT, 'Leon', 'Everything', 41, 30, 8.5, 87),
(DEFAULT, 'Nikita Mears', 'Silenced pistols', 28, 30, 7, 32),
(DEFAULT, 'Pickle Rick', 'Lasers and office supplies', 60, 0, 8, 24);

--create code_names table
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

--create clients table
CREATE TABLE clients (id serial primary key, client_name text);
INSERT INTO clients (id, client_name)
VALUES
(DEFAULT, 'Marcellus Wallace'),
(DEFAULT, 'Concerto'),
(DEFAULT, 'Mathilda'),
(DEFAULT, 'Winston'),
(DEFAULT, 'Ray Vargo');

--create targets table
CREATE TABLE targets (id serial primary key, target_name text, target_location text, target_photo text, target_security integer);
INSERT INTO targets (id, target_name, target_location, target_photo, target_security)
VALUES
(DEFAULT, 'Butch Coolidge', 'Los Angeles', 'https://goo.gl/LCquZj', 3),
(DEFAULT, 'The Jaguar', 'Russian Embassy', 'https://goo.gl/6JWsiv', 9),
(DEFAULT, 'Norman Stansfield', 'Manhattan', 'https://i.imgur.com/mdIk33E.jpg', 7),
(DEFAULT, 'Santino D''Antonio', 'Continental Hotel', 'https://goo.gl/fUPkYy', 10),
(DEFAULT, 'Sonny Valerio', 'Queens', 'https://goo.gl/8DHYUS', 4);

--create contracts table
CREATE TABLE contracts (id serial primary key, client_id integer references clients (id), budget integer, target_id integer references targets (id), completed boolean, assassins_id integer references assassins (id));
INSERT INTO contracts (id, client_id, budget, target_id, completed, assassins_id)
VALUES
(DEFAULT, 1, 40, 1, false, null),
(DEFAULT, 2, 70, 2, false, null),
(DEFAULT, 3, 35, 3, false, null),
(DEFAULT, 4, 25, 4, false, null),
(DEFAULT, 5, 10, 5, false, null);

--cAssign the following jobs to these assassins:
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

--Select all the assassins, sorted by number of kills. SELECT * FROM Assassins ORDER BY kills DESC
SELECT * FROM assassins ORDER BY kills DESC;

--Select all of the assassins older than 30 years old. SELECT * FROM Assassins WHERE age>30;
SELECT * FROM assassins WHERE age>30;

--Select all of the contracts that can afford to pay Nikita Mears. (Budget >= her price) SELECT * FROM Contracts WHERE budget>=30;
SELECT * FROM contracts WHERE budget>=30;

--Count the number of assassins that are capable of taking out Norman Stansfield. (Their rating >= his security level) SELECT * FROM Assassins WHERE rating>=7;
SELECT * FROM assassins WHERE rating>=7;

--Get the total amount it would require to hire every available assassin. SELECT SUM(price) FROM Assassins;
SELECT SUM(price) FROM assassins;

--Count the number of currently contracted assassins. select count(*) from Assassins_Contracts;
SELECT COUNT(*) FROM assassins_contracts;

--Find the lowest total cost to complete all assigned contracts.

--Add a new contract: Snake Plissken, New York, (find a photo), security 5, budget 35, Client is Marcellus Wallace.
INSERT INTO targets (id, target_name, target_location, target_photo, target_security)
VALUES
(DEFAULT, 'Snake Plissken', 'New York', 'https://imgur.com/gallery/kEuzp', 5);

INSERT INTO contracts (id, client_id, budget, target_id, completed, assassins_id)
VALUES
(DEFAULT, 1, 35, 6, FALSE, NULL);

--Assign all assassins with a rate lower than the cost of the new contract to the new contract.

--Complete these contracts:
--The Jaguar, by the Jackal
UPDATE contracts SET completed = TRUE, assassins_id = 1 WHERE target_id = 2;
UPDATE assassins SET kills = kills+1 WHERE id = 1;

--Butch Coolidge, by Ghost Dog
UPDATE contracts SET completed = TRUE, assassins_id = 3 WHERE target_id = 1;
UPDATE assassins SET kills = kills+1 WHERE id = 3;

--Snake Plissken, by Nikita Mears
UPDATE contracts SET completed = TRUE, assassins_id = 8 WHERE target_id = 6;
UPDATE assassins SET kills = kills+1 WHERE id = 8;

--Select all the completed contracts, showing only the assassins to be paid, and the amount paid to them. Then show the total cost of the completed contracts.


--Show tables
SELECT * FROM assassins;
SELECT * FROM code_names;
SELECT * FROM clients;
SELECT * FROM contracts;
SELECT * FROM targets;
SELECT * FROM assassins_contracts;
