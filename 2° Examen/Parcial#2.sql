create database Parcial_2
USE Parcial_2
DROP DATABASE Parcial_2

CREATE TABLE tblUser(
Id_User TINYINT AUTO_INCREMENT NOT NULL,
Username  VARCHAR (100),
Email VARCHAR (100) NOT NULL,
Pass BLOB NOT NULL,

 PRIMARY KEY (Id_User)
)

ALTER TABLE tblUser 
ADD UNIQUE (Id_User);

select * from tblUser

INSERT INTO tblUser (Username, Email, Pass)
VALUES ("Jesus Mora", "jesusmora@gmail.com", aes_encrypt('Bycho1234#','key'));
