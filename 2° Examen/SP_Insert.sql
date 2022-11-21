USE Parcial_2
DELIMITER $$
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `spRegisterUser`(IN PUsername varchar(150),IN pEmail varchar(100),IN pPass blob, out pMessage VARCHAR(200))

BEGIN
IF(SELECT REGEXP_LIKE(pPass, '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$#%&/.,?])[A-Za-z[0-9]$#%&/.,?]{8,}$')!=1) THEN
    SET pMessage:= 'EL EMAIL esta duplicado 
					La contraseña debe detener al menos una mayuscula, al menos un numero y
                    al menos un caracter especial ($#%&/.,?)';
ELSE 
	INSERT INTO tblUser (Username,Email,Pass) 
    values (PUsername,pEmail, AES_ENCRYPT(pPass,'key')); SET pMessage:= 'Usuario ingresado';
    end if;
end$$


CALL spRegisterUser("fran", "fran@gmail.com",'Fran1234?',@pMessage);
CALL spRegisterUser("Jesus Mora", "jesusmora@gmail.com",'Bycho1234#',@pMessage);
SELECT @pMessage
SELECT * FROM tblUser