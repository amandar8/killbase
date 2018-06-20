# Killbase

Killbase is a job board for international assassins. Assassins and their clients can register with Killbase, and enter or sign up for jobs. Assassins can have zero or more code names, and can sign up for any number of contracts; a contract may also be open to any number of assassins.

Assassins have:
  * a full fame
  * zero or more codenames
  * a weapon of choice
  * contact information
  * a minimum price they charge
  * a float rating from 1-10
  * number of kills
  * an age

Contracts have:
  * a target
  * a client
  * a budget (maximum price for the job)
  * whether it's completed or not
  * who completed it, if completed

Clients have:
  * a name

Targets have:
  * a name
  * a location
  * a photo
  * a security level

## Your tasks:

1) Create an entity relationship diagram for the tables in the Killbase database.

CREATE TABLE Assassins
2) Create the killbase database, and write the SQL to create all the tables.
3) Write the SQL to seed the database with the following information:

### Assassins

| Full name        | Code Names              | Weapon                     | Age | Price | Rating | Kills |
|------------------|-------------------------|----------------------------|-----|-------|--------|-------|
| Alexander Duggan | The Jackal              | Sniper rifle               | 31  | 45    | 7.5    | 28    |
| Anton Chigurh    | Old Man                 | Pneumatic bolt gun         | 52  | 40    | 9      | 72    |
|                  | Ghost Dog               | Pistol                     | 28  | 20    | 6.5    | 35    |
| Jason Bourne     |                         | Parkour                    | 27  | 25    | 7      | 48    |
| John Wick        | Baba Yaga               | Lots of guns               | 35  | 50    | 9.5    | 433   |
| Jules Winnfield  |                         | Pistol                     | 26  | 15    | 6.5    | 13    |
| Leon             | The Professional        | Everything                 | 41  | 30    | 8.5    | 87    |
| Nikita Mears     | Nikita, La Femme Nikita | Silenced pistols           | 28  | 30    | 7      | 32    |
| Pickle Rick      | Solenya                 | Lasers and office supplies | 60  | 0     | 8      | 24    |

### Contracts

| Target Name       | Target Location   | Target Photo                    | Target Security | Client Name       | Budget |
|-------------------|-------------------|---------------------------------|-----------------|-------------------|--------|
| Butch Coolidge    | Los Angeles       | https://goo.gl/LCquZj           | 3               | Marcellus Wallace | 40     |
| The Jaguar        | Russian Embassy   | https://goo.gl/6JWsiv           | 9               | Concerto          | 70     |
| Norman Stansfield | Manhattan         | https://i.imgur.com/mdIk33E.jpg | 7               | Mathilda          | 35     |
| Santino D'Antonio | Continental Hotel | https://goo.gl/fUPkYy           | 10              | Winston           | 25     |
| Sonny Valerio     | Queens            | https://goo.gl/8DHYUS           | 4               | Ray Vargo         | 10     |

(Hint: Create a text file with all the SQL commands to create and populate the table, then load it into psql.)

## Exercises

1) Select all the assassins, sorted by number of kills.
SELECT * FROM Assassins ORDER BY kills DESC

2) Select all of the assassins older than 30 years old.
SELECT * FROM Assassins WHERE age>30;

3) Select all of the contracts that can afford to pay Nikita Mears. (Budget >= her price)
SELECT * FROM Contracts WHERE budget>=30;

4) Count the number of assassins that are capable of taking out Norman Stansfield. (Their rating >= his security level)
SELECT * FROM Assassins WHERE rating>=7;

5) Get the total amount it would require to hire every available assassin.
SELECT SUM(price) FROM Assassins;

6) Assign the following jobs to these assassins:
  * Jules Winnfield -> Butch Coolidge
  * The Jackal -> The Jaguar
  * John Wick -> The Jaguar
  * Leon -> Norman Stansfield
  * Pickle Rick -> Sonny Valerio
  * Jules Winnfield -> Santino D'Antonio
  * Nikita Mears -> Norman Stansfield
  * Ghost Dog -> Butch Coolidalge

CREATE TABLE assassins_contracts (Assassins_id integer references Assassins (id), Contracts_id integer references contracts (id));

assassins_id |  full_name     
--------------+--------------
1 | Alexander Duggan
2 | Anton Chigurh
3 |
4 | Jason Bourne
5 | John Wick
6 | Jules Winnfield
7 | Leon
8 | Nikita Mears
9 | Pickle Rick

assassins_id |  code_names        
--------------+-------------
1 | The Jackal
2 | Old Man
3 | Ghost Dog
4 |
5 | Baba Yaga
6 |
7 | The Professional
8 | Nikita, La Femme Nikita
9 | Solenya

contracts_id |  target_name    
--------------+---------------
1 | Butch Coolidge
2 | The Jaguar
3 | Norman Stansfield
4 | Santino D'Antonio
5 | Sonny Valerio


select * from assassins inner join assassins_contracts on assassins.id=assassins_contracts.assassins_id inner join contracts on assassins_contracts.contracts_id=contracts.id;

select (assassins.full_name, contracts.client_name, contracts.target_name) from assassins inner join assassins_contracts on assassins.id=assassins_contracts.assassins.id;

7) Count the number of currently contracted assassins.
select count(*) from Assassins_Contracts;

8) Find the lowest total cost to complete all assigned contracts.


9) Add a new contract: Snake Plissken, New York, (find a photo), security 5, budget 35, Client is Marcellus Wallace.

10) Assign all assassins with a rate lower than the cost of the new contract to the new contract.

11) Complete these contracts: The Jaguar, by the Jackal; Butch Coolidge, by Ghost Dog; Snake Plissken, by Nikita Mears. (Be sure to increment the number of kills!)

12) Select all the completed contracts, showing only the assassins to be paid, and the amount paid to them. Then show the total cost of the completed contracts.

13) The Jackal has retired. Remove him from the database. (How can we do this while maintaining integrity on the contracts table?)

14) Ghost Dog and Nikita Mears have increased their rates by 5 and 10, respectively. Update their entries to reflect this.

15) The contract on Norman Stansfield has been rescinded. Remove it (and any associated data) from the database.

16) Winston has taken out a contract on John Wick! (Security 9, budget 100) We may have to rethink the way we're structuring our data. How can we refactor our database schema to allow a person to be an assassin, a client, or the target of a contract? Do that, then assign all assassins not already on a job to this new contract.
