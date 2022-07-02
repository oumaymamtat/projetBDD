/* 1-Donner les noms et prénoms des clients, triés, nées après 1985 */

select nomclient,prenomclient  from client
where datenaissclient >= TO_DATE('1985-01-01', 'YYYY-MM-DD')
order by nomclient;

/* 2-afficher la liste des clients ayant au moins un compte devise */

select nomclient,prenomclient
from client cl,compte co
where cl.idclient=co.idclient
And co.typecompte = Any (select TYpecompte from compte where typecompte='devise');

/* 3- donner le numero de compte ayant subi l'opération de virement la plus élévée */

select idcompte from transaction
where montanttransaction > All(select montanttransaction from transaction where typetransaction = 'virement');

/* 4- donner le nombre de prets,s'il y en a, effectues pour le client n°42*/

select sum(nbechepret) from pret
where exists(select * from pret where idclient=42);


/* 5- donner la liste des clients qui sont à la fois filleul et parrain */

select nomclient, prenomclient 
from client cl,parrainage p
where p.Idclientparrain = cl.idclient
INTERSECT
select nomclient,prenom
from client cl,parrainage p 
where p.idclientfilleul = cl.idclient;

/* 6- donner la moyenne des montants dont on a cloturé les comptes */
select avg(montantservice) as moyennecloturecomptes
from service 
where typeservice='cloture';

/* 7- donner les agences du banque outre que celle qui contient le compte coutant n°24 */
select * from agence
Minus 
select * from agence 
where idagence = (select idagence from compte 
where idcompte = (select idcomptecourant from comptecourant where idcomptecourant = 24));


/* 8- Donner le nombre de cartes pour chaque clients */
select cl.nomclient||cl.prenomclient as client,count(c.Idcarte) as nbcarte 
from carte c,client cl
group by(cl.nomclient||cl.prenomclient);


/* 9- Donner la liste des clients ayant plus que 100 cheques */
select cl.nomclient||cl.prenomclient as client,count(ch.datecheque) 
from cheque ch,client cl
group by(cl.nomclient||cl.prenomclient)
having(count(ch.datecheque) >100);

/* 10- Supprimer tous les transactions dont le montant est null */
Delete from transaction where montanttransaction is null;

