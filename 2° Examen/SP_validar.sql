USE Parcial_2

DELIMITER $$
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `spValidate`(IN PUsername varchar(100),IN pEmail varchar(100),IN pPass blob)

BEGIN
SELECT Username,Email,CAST(AES_DECRYPT(Pass, 'key') AS CHAR)
FROM tblUser
WHERE Email = pEmail
AND Pass = (AES_DECRYPT(pPass, 'key'));
END;$$

DELIMITER ;
CALL spValidate ("fran", "fran@gmail.com",'Fran1234?');

