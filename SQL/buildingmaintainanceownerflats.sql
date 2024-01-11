use buildingmaintainanceownerflats;

-- a.Write a query to  update  Ownername,mobile and email of owner of flat B111 

Update owners o
SET o.Ownername="S.K.Deshpande", o.mobile=847384333, o.email='skdeshpande@gmail.com'
WHERE o.oid IN(SELECT oid FROM flats where flatNo="B111");

-- b.Write query to display owner details who owns more than 1 flats.

SELECT o.* ,count(f.flatno) as count
FROM owners o 
INNER JOIN flats f USING (oid)
GROUP BY oid
HAVING count(f.flatno)>1;

select distinct(o.ownername) 
from flats f 
join Owners o on f.oid = o.oid  
and o.oid in (select oid from flats group by oid having count(oid)>1);

-- c.Delete Flat records whose Owner is A.V.Bhat and Occupiedstatus is ‘Tenent’   . 

DELETE FROM flats f
WHERE f.oid IN(SELECT oid FROM owners o WHERE OwnerName="A.V.Bhat") 
AND f.Occupiedstatus="Tenent";

-- another way
delete from flats 
where oid = (select oid from Owners where ownername like'A.V.Bhat') 
and occupiedstatus like'Tenent';

-- e.Create a stored procedure which accepts  building name and returns Representative Name and his flat no.	

-- f.Show building wise total amount of maintenance collected and total balance amount 
--   in descending order of maintenance collected.		[1]

select subString(flatno,1,1) as 'building' ,sum(amout_paid) as 'Amount_collected',
 sum(balance) as 'total balance' 
 from maintanince
 group by building
 order by Amount_collected desc;
 
 
 SELECT f.flatno, o.* 
 FROM flats f , owners o 
 where f.oid = o.oid ;