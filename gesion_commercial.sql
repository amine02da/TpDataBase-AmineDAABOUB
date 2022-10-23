-- Question n° 01 :
CREATE DATABASE  Gesion_Commercial ;
CREATE TABLE CLIENT(
    numClient int(11) PRIMARY KEY AUTO_INCREMENT,
    RaisonSocial VARCHAR(20) NOT NULL,
    AdresseClient VARCHAR(20) NOT NULL,
    villeClient VARCHAR(20),
    Telephone VARCHAR(10)
);
CREATE TABLE DetailsCommande(
    NumCommande INT(11) PRIMARY KEY AUTO_INCREMENT,
    RefProduit VARCHAR(15) NOT NULL,
    QteCommande VARCHAR(10) NOT NULL,
    CONSTRAiNT fk_prod_Dcmd FOREIGN KEY(RefProduit) REFERENCES Produit(RefProduit)
);

CREATE TABLE Produit(
    RefProduit INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomProduit VARCHAR(15) NOT NULL,
    PrixUnitaire VARCHAR(15) NOT NULL,
    QteStockee VARCHAR(15) NOT NULL,
    Disponible BOOLEAN
);

CREATE TABLE Commande(
    NumCommande INT(11) NOT NULL,
    numClient int(11)  NOT NULL,
    DateCommande DATE NOT NULL,
    CONSTRAiNT fk_Cmd_dCmd FOREIGN KEY(NumCommande) REFERENCES DetailsCommande(NumCommande),
    CONSTRAiNT fk_Cmd_clt FOREIGN KEY(numClient) REFERENCES CLIENT(numClient),
    CONSTRAiNT pk_cmd PRIMARY KEY (NumCommande,numClient) NOT NULL AUTO_INCREMENT
);

-- Question n° 02 :
-- procedure pour affichage
DELIMITER $$
CREATE PROCEDURE `affichage` (IN `TBName` VARCHAR(64))
BEGIN

  SET @SQLString = CONCAT("SELECT * FROM `", TBName, "` ;");

  PREPARE qry FROM @SQLString;
  EXECUTE qry;

END$$
DELIMITER;

--1)
call affichage("client");
--2)
CALL affichage("commande")

--3)

DELIMITER // 
create Procedure Q3()
BEGIN
select numClient,villeClient from client ;
end //
DELIMITER ;

CALL Q3()

--4)

DELIMITER // 
create Procedure Q4()
BEGIN
select numClient,RaisonSocial,Telephone from client ;
end //
DELIMITER ;

CALL Q4()

--5)

DELIMITER // 
create Procedure Q5()
BEGIN
select * from client WHERE numClient = 15;
end //
DELIMITER ;

CALL Q5()

--6)

DELIMITER // 
create Procedure Q6()
BEGIN
select * from client ORDER BY RaisonSocial DESC  ;
end //
DELIMITER ;

CALL Q6()



--7)

DELIMITER // 
create Procedure Q7()
BEGIN
select * from client ORDER BY RaisonSocial DESC ,villeClient ASC ;
end //
DELIMITER ;

CALL Q7();



--8)

DELIMITER // 
create Procedure Q8()
BEGIN
select * from client WHERE RaisonSocial LIKE "s%" ;
end //
DELIMITER ;

CALL Q8();

--9)

DELIMITER // 
create Procedure Q9()
BEGIN
select * from client WHERE RaisonSocial LIKE "%e" ;
end //
DELIMITER ;

CALL Q9()

--10)

DELIMITER // 
create Procedure Q10()
BEGIN
select * from client WHERE RaisonSocial LIKE "a%" and RaisonSocial LIKE "%e" ;
end //
DELIMITER ;

CALL Q10()

--11)

DELIMITER // 
create Procedure Q11()
BEGIN
select * from client WHERE RaisonSocial LIKE "a%" or RaisonSocial LIKE "%e" ;
end //
DELIMITER ;

CALL Q11()

--12)

DELIMITER // 
create Procedure Q12()
BEGIN
select * from client  WHERE villeClient in ("Casablanca","Rabat","Ouarzazate");
end //
DELIMITER ;

CALL Q12()

--13)

DELIMITER // 
create Procedure Q13()
BEGIN
select * from produit WHERE PrixUnitaire = "300" ;
end //
DELIMITER ;

CALL Q13()




--14)

DELIMITER // 
create Procedure Q14()
BEGIN
select * from produit WHERE PrixUnitaire < "300" ;
end //
DELIMITER ;

CALL Q14()

--15)

DELIMITER // 
create Procedure Q15()
BEGIN
select * from produit WHERE PrixUnitaire BETWEEN "300" and "5000";
end //
DELIMITER ;

CALL Q15()

--16)

DELIMITER // 
create Procedure Q16()
BEGIN
select * from produit WHERE Disponible = "oui" ;
end //
DELIMITER ;

CALL Q16()

--17)

DELIMITER // 
create Procedure Q17()
BEGIN
select * from produit where PrixUnitaire < "300" and Disponible = "non" ;
end //
DELIMITER ;

CALL Q17()

--18)

DELIMITER // 
create Procedure Q18()
BEGIN
select * from commande where  DateCommande = "2016/11/01";
end //
DELIMITER ;

CALL Q18()

--19)

DELIMITER // 
create Procedure Q19()
BEGIN
select * from commande where  DateCommande > "2016/11/01" ;
end //
DELIMITER ;

CALL Q19()

--20)

DELIMITER // 
create Procedure Q20()
BEGIN
select * from commande where  DateCommande BETWEEN "2016/1/02" AND "2016/31/03" ;
end //
DELIMITER ;

CALL Q20()

--21)

DELIMITER // 
create Procedure Q21()
BEGIN
select * from commande where  DateCommande = Date(now());
end //
DELIMITER ;

CALL Q21()



--22)

DELIMITER // 
create Procedure Q22()
BEGIN
SELECT * from commande WHERE year(DateCommande) = year(Date(now()));
end //
DELIMITER ;


CALL Q22()

--23)

DELIMITER // 
create Procedure Q23()
BEGIN
select * from commande where month(DateCommande) = 7 ;
end //
DELIMITER ;

CALL Q23()



--24)

DELIMITER // 
create Procedure Q24()
BEGIN
SELECT PrixUnitaire*QteStockee as 'valeur de stock' from produit  ;
end //
DELIMITER ;

CALL Q24()

--25)

DELIMITER // 
create Procedure Q25()
BEGIN
select  PrixUnitaire*0,2 as "TTC Produit" from produit ;
end //
DELIMITER ;

CALL Q25()

--26)

DELIMITER // 
create Procedure Q26()
BEGIN
select DISTINCT villeClient  from client ;
end //
DELIMITER ;

CALL Q26()

--27)

DELIMITER // 
create Procedure Q27()
BEGIN
select * from client ct inner JOIN commande  cmd on  ct.numClient = cmd.numClient;
end //
DELIMITER ;

CALL Q27()

--28)

DELIMITER // 
create Procedure Q28()
BEGIN
select * from produit prod join detailscommande Dcmd on prod.RefProduit = Dcmd.RefProduit ;
end //
DELIMITER ;

CALL Q28()

--29)

DELIMITER // 
create Procedure Q29()
BEGIN
select * from commande ct join client cmd on ct.numClient = cmd.numClient WHERE ct.numClient = 15   ;
end //
DELIMITER ;

CALL Q29()

--30)

DELIMITER // 
create Procedure Q30()
BEGIN
select * from produit prod join detailscommande Dcmd on 
                        prod.RefProduit = Dcmd.RefProduit  WHERE Dcmd.NumCommande = 5 ;
end //
DELIMITER ;

CALL Q30()

--31)

DELIMITER // 
create Procedure Q31()
BEGIN
select * from produit prod join detailscommande Dcmd 
        on 
        prod.RefProduit = Dcmd.RefProduit  join commande cmd on Dcmd.NumCommande = cmd.NumCommande 
        WHERE cmd.DateCommande = "2020/19/09";
end //
DELIMITER ;

CALL Q31()


--32)

DELIMITER // 
create Procedure Q32()
BEGIN
select prod.nomProduit from produit prod inner join detailscommande dcmd on prod.RefProduit = dcmd.refProduit
inner join commande cmd on  cmd.NumCommande = dcmd.NumCommande inner join client ct on
ct.numclient = cmd.numclient where ct.villeClient = "Madrid";
end //
DELIMITER ;

CALL Q32()



--33)

DELIMITER // 
create Procedure Q33()
BEGIN
select * from produit prod inner join detailscommande dcmd on dcmd.Refproduit = prod.RefProduit
inner join commande cmd on cmd.NumCommande = dcmd.NumCommande where cmd.numClient = 15;
end //
DELIMITER ;

CALL Q33()

--34)

DELIMITER // 
create Procedure Q34()
BEGIN
select count(*) as "Nombre des clients" from client;
end //
DELIMITER ;

CALL Q34()


--35)

DELIMITER // 
create Procedure Q35()
BEGIN
select count(*) as "Nombre des clients habitant « Berlin »" from client WHERE villeClient = "Berlin";
end //
DELIMITER ;

CALL Q35()


--36)

DELIMITER // 
create Procedure Q36()
BEGIN
select count(*) as "Nombre des clients" from produit where Disponible = "oui";
end //
DELIMITER ;

CALL Q36()


--37)

DELIMITER // 
create Procedure Q37()
BEGIN
select count(*) as "Nombre des clients" from produit where Disponible = "non";
end //
DELIMITER ;

CALL Q37()


--38)

DELIMITER // 
create Procedure Q38()
BEGIN
select max(PrixUnitaire)  as "Le plus grand prix" from produit ;
end //
DELIMITER ;

CALL Q38()


--39)

DELIMITER // 
create Procedure Q39()
BEGIN
select min(PrixUnitaire)  as " Le plus petit prix" from produit;
end //
DELIMITER ;

CALL Q39()


--40)

DELIMITER // 
create Procedure Q40()
BEGIN
select avg(PrixUnitaire)  as " La moyenne des prix" from produit;
end //
DELIMITER ;

CALL Q40()


--41)

DELIMITER // 
create Procedure Q41()
BEGIN
select sum(PrixUnitaire)  as " La somme de tous les prix" from produit;
end //
DELIMITER ;

CALL Q41()

--42)

DELIMITER // 
create Procedure Q42(in numt int(11))
BEGIN
select numClient,count(*) as "nombre de commandes réalisées" from Commande where numClient = numt ;
end //
DELIMITER ;

CALL Q42(102)



--43)

DELIMITER // 
create Procedure Q43()
BEGIN
declare set nbrCmd = select numClient,count(*) as "nombre de commandes réalisées" from Commande cmd inner JOIN
client ct where ct.numclient = cmd.numclient;
select * from client where @nbrCmd > 2;
end //
DELIMITER ;

CALL Q43()

select count(*) as "nombre de commandes réalisées" from Commande cmd inner JOIN
client ct where ct.numclient = cmd.numclient;
--44)

DELIMITER // 
create Procedure Q44()
BEGIN
select count(*) as "les produits commandés par raison sociale" from produit prod inner join detailsCommande Dcmd on prod.RefProduit = Dcmd.RefProduit
                join Client ct GROUP BY ct.RaisonSocial ;
end //
DELIMITER ;

CALL Q44()


--45)

DELIMITER // 
create Procedure Q45()
BEGIN
select * from client ct left join commande cmd on ct.numClient = cmd.numClient where NumCommande is null;
end //
DELIMITER ;

CALL Q45()




--46)

DELIMITER // 
create Procedure Q46()
BEGIN
select * from produit prod left join detailsCommande Dcmd on prod.RefProduit = Dcmd.RefProduit
where Dcmd.RefProduit is null
;
end //
DELIMITER ;

CALL Q46()



--47)

DELIMITER // 
create Procedure Q47()
BEGIN
select count(PrixUnitaire*QteStockee)  as 'La valeur du stock' from produit ;
end //
DELIMITER ;

CALL Q47()


--48)

DELIMITER // 
create Procedure Q48()
BEGIN
select numCommande ,sum(PrixUnitaire) as "Le montant total de chaque commande" from produit prod inner join detailsCommande Dcmd on prod.RefProduit = Dcmd.RefProduit GROUP BY NumCommande;

end //
DELIMITER ;

CALL Q48()



--49)

DELIMITER // 
create Procedure Q49(in refProd int(11) ,out note varchar(30))
BEGIN
declare QteProd float;
set QteProd = (SELECT QteStockee from produit where RefProduit=refProd);
if QteProd<10 then
    set note = "Besoin en réapprovisionnement";
    else 
    set note = "quantité Suffisante";
end if;
end //
DELIMITER ;

CALL Q49(10,@note)
select @note as "note"






--50)

DELIMITER // 
create Procedure Q50(in villeLivrasion varchar(10))
BEGIN
select * from commande c inner join client ct on c.numClient = ct.numClient where ct.villeClient = "Madrid"
or villeLivrasion="madrid";
end //
DELIMITER ;

CALL Q50("maroc") 
CALL Q50("madrid")

--51)

DELIMITER // 
create Procedure Q51(in villeLivrasion varchar(10))
BEGIN
select * from commande c inner join client ct on c.numClient = ct.numClient where ct.villeClient = "Madrid"
and villeLivrasion="madrid";
end //
DELIMITER ;

CALL Q51("madrid")
















