/*
 CSCI 3410 -- Coffee DB
 Name: -- Seth Barrett
 Date: -- 2/4/21
 */
DROP SCHEMA IF EXISTS HW_Coffee;

CREATE SCHEMA HW_Coffee;

USE HW_Coffee;

CREATE TABLE COFFEE (
	Ref int,
	Origin VARCHAR(55),
	TypeOfRoast VARCHAR(25),
	PricePerPound DECIMAL(4, 2),
	PRIMARY KEY (Ref)
);
INSERT INTO COFFEE VALUES
	(001, 'Brazil', 'Light', 8.9), 
	(121, 'Bolivia', 'Dark', 7.5),
	(311, 'Brazil', 'Medium', 9),
	(221, 'Sumatra', 'Dark', 10.25);
/*COFFEE table done*/
CREATE TABLE CUSTOMER (
	CardNo int,
	Name VARCHAR(55),
	Email VARCHAR(255),
	PRIMARY KEY (CardNo)
);
INSERT INTO CUSTOMER VALUES 
	(001, 'Bob Hill', 'b.hill@isp.net'),
	(002, 'Ana Swamp', 'swampa@nca.edu'),
	(003, 'Mary Sea', 'brig@gsu.gov'),
	(004, 'Pat Mount', 'pmount@fai.fr');
ALTER TABLE CUSTOMER ADD COLUMN FavCoffee int;
ALTER TABLE CUSTOMER ADD FOREIGN KEY (FavCoffee) 
	REFERENCES COFFEE(Ref) ON UPDATE CASCADE ON DELETE CASCADE;
/*CUSTOMER table done*/
CREATE TABLE PROVIDER (
	Name VARCHAR(55),
	Email VARCHAR(255),
	PRIMARY KEY (Name)
);
INSERT INTO PROVIDER VALUES
	('Coffee Unl.', 'bob@cofunl.com'),
	('Coffee Exp.', 'pat@coffeex.dk'),
	('Johns & Co.', NULL);
/*PROVIDER table done*/
CREATE TABLE SUPPLY (
	Provider VARCHAR(55),
	Coffee int,
	PRIMARY KEY (Provider, Coffee),
	FOREIGN KEY (Provider) REFERENCES PROVIDER(Name) 
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN Key (Coffee) REFERENCES COFFEE(Ref) 
		ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO SUPPLY VALUES('Coffee Unl.', 001), ('Coffee Unl.', 121), 
('Coffee Exp.', 311), ('Johns & Co.', 221);
/*SUPPLY table done*/

/*Q2.1-Inserts*/
INSERT INTO CUSTOMER VALUES(005, 'Bob Hill', NULL, 001);
/*Q2.2-Inserts*/
INSERT INTO COFFEE VALUES(002, 'Peru', 'Decaf', 3);
/*Q2.3-Inserts
INSERT INTO PROVIDER VALUES (NULL, 'contact@localcof.com');
----BAD b/c cannot have NULL for Name b/c its a PK*/
/*Q2.4-Inserts
INSERT INTO SUPPLY VALUES('Johns Co.', 121);
----BAD b/c 'Johns Co.' isn't on PROVIDER.Name*/
/*Q2.5-Inserts
INSERT INTO SUPPLY VALUES('Coffee Unl.', 311, 221);
----BAD b/c only 1 number, can't add 2 numbers*/

/*Q3.1*/
UPDATE CUSTOMER SET FavCoffee = 001 WHERE CardNo = 001;
/*SELECT * FROM CUSTOMER WHERE CardNo = 001;*/
/*Q3.2*/
UPDATE COFFEE SET TypeOfRoast = 'Decaf' WHERE Origin = 'Brazil';
/*SELECT * FROM COFFEE WHERE Origin = 'Brazil';*/
/*Q3.3*/
UPDATE PROVIDER SET Name = 'Coffee Unlimited' WHERE Name = 'Coffee Unl.';
/*
SELECT * FROM PROVIDER AS P WHERE P.Name = 'Coffee Unlimited';
SELECT * FROM SUPPLY AS S WHERE S.Provider = 'Coffee Unlimited';
*/
/*Q3.4*/
UPDATE COFFEE SET PricePerPound = 10.00 WHERE PricePerPound > 10.00;
/*SELECT * FROM COFFEE WHERE PricePerPound > 10.00;*/

/*Q4.1*/
/*
SELECT * FROM CUSTOMER WHERE Name LIKE '%S%';
DELETE FROM CUSTOMER WHERE Name LIKE '%S%'; 
*/
/*Q4.2*/
/*
SELECT * FROM COFFEE WHERE Ref = 001;
SELECT * FROM CUSTOMER WHERE FavCoffee = 001;
SELECT * FROM SUPPLY WHERE Coffee = 001;

DELETE FROM COFFEE WHERE Ref = 001;

SELECT * FROM COFFEE WHERE Ref = 001;
SELECT * FROM CUSTOMER WHERE FavCoffee = 001;
SELECT * FROM SUPPLY WHERE Coffee = 001;
*/
/*Q4.3--If commands follow questions, won't delete any no Coffee = 001*/
/*
SELECT * FROM SUPPLY WHERE Provider = 'Coffee Unl.' AND Coffee = 001;
DELETE FROM SUPPLY WHERE Provider = 'Coffee Unl.' AND Coffee = 001;
SELECT * FROM SUPPLY WHERE Provider = 'Coffee Unl.' AND Coffee = 001;
*/
/*Q4.4*/
/*

SELECT * FROM PROVIDER WHERE Name = 'Johns & Co.';
DELETE FROM PROVIDER WHERE Name = 'Johns & Co.';
SELECT * FROM PROVIDER WHERE Name = 'Johns & Co.';
*/
/*

	SELECT Origin FROM COFFEE WHERE TypeOfRoast = 'Dark';

	SELECT DISTINCT FavCoffee FROM CUSTOMER WHERE Name LIKE 'Bob%';

	SELECT Name FROM PROVIDER WHERE Email is NULL;

	SELECT COUNT(Provider) FROM SUPPLY WHERE Provider = 'Johns & Co.';

	SELECT S.Provider AS 'Providers of Dark Coffee' FROM SUPPLY AS S, COFFEE AS C 
	WHERE C.TypeOfRoast = 'Dark' AND C.Ref = S.Coffee;
*/
