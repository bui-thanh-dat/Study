CREATE TABLE Persons (
	ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int,
    UNIQUE (ID) -- 1 cột 
);
ALTER TABLE Persons
ADD UNIQUE(ID); 

CREATE TABLE Persons (
	ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName) -- tên là UC_Person, cả id và last name không được trùng 
);
ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE(ID,LastName); 


-- DROP a UNIQUE Constraint 
ALTER TABLE Persons
DROP INDEX UC_Person;
