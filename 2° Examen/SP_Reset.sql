USE Parcial_2

/*CREATE TABLE tblReset(
Id_Pass TINYINT AUTO_INCREMENT NOT NULL,
Username  VARCHAR (100),
Email VARCHAR (100) NOT NULL,
Pass BLOB NOT NULL,

 PRIMARY KEY (Id_Pass)
)*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost`
PROCEDURE `SPreset` (IN pUsername VARCHAR(100),IN pEmail varchar(100),IN pPass blob ,IN pnewUsername VARCHAR(100),
IN pnewEmail varchar(100),IN pnewPass blob ,OUT result bool)
BEGIN
if(pUsername = Binary (Select Username from tblUser limit 1)and 
   pPass= Binary (Select Pass from tblUser limit 1) and pEmail =Binary (select Email from tblUser limit 1))
    then
        delete from tblUser where Username=pUsername;
        insert into tblUser values(pnewUsername,pnewEmail,pnewPass);

        set @stm = CONCAT("set password for 'root'@'localhost' = ",pPass);
        prepare stmt from @stm;
        execute stmt;
        deallocate prepare stmt;

        set result=true;
    else
        set result=false;
end if;
select Username,Pass from tblUser where Username = pUsername and convert(aes_decrypt(Pass,'key')using utf8mb4) = pPass;

END $$ DELIMITER ;

select * from tblUser
select Username,Email,cast(aes_decrypt(Pass,'key') as char ) from tblUser
call SPreset("Jesus Mora", "jesusmora@gmail.com",'Bycho1234#','jesus','new@gmail.com','Loba1234¡¡',@result);