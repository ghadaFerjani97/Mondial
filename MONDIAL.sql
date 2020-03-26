select c2.name, b.length as longueur_frontiere
from country c1, country c2, borders b
where c1.name = 'France'
and
(
(c1.code = b.country1
and c2.code = b.country2)
or
(c1.code = b.country2
and c2.code = b.country1)
)
and b.length >= ALL (select b1.length
 from country c3, borders b1
 where
 (
 (c1.code = b1.country1
 and c3.code = b1.country2)
 or
 (c1.code = b1.country2
 and c3.code = b1.country1)
 ))
;

select c2.name, b.length as longueur_frontiere
from country c1, country c2, borders b
where c1.name = 'France'
and
(
(c1.code = b.country1
and c2.code = b.country2)
or
(c1.code = b.country2
and c2.code = b.country1)
)
and not exists (select *
 from country c3, borders b1
 where b1.length > b.length and
 (
 (c1.code = b1.country1
 and c3.code = b1.country2)
 or
 (c1.code = b1.country2
 and c3.code = b1.country1)
 ))
;


select c2.name, count(c3.code) as nbvoisins
from country c1, country c2, country c3, borders b, borders b1
where c1.name = 'France'
and
(
(c1.code = b.country1
and c2.code = b.country2)
or
(c1.code = b.country2
and c2.code = b.country1)
)
and
(
(c3.code = b1.country1
and c2.code = b1.country2)
or
(c3.code = b1.country2
and c2.code = b1.country1)
)
group by c2.name;


select SUM(c1.population * l.percentage / 100)
from country c1, language l
where l.country=c1.code and l.name = 'French';


select distinct r.name
from religion r
where not exists
(select * from continent co where not exists
 (select * from country c, encompasses e, religion r1
 where e.country=c.code and e.continent = co.name
 and r1.name=r.name and r1.country=c.code));
 
 
 select e.continent
from country c, encompasses e
where e.country=c.code
group by e.continent
having SUM(c.population)/SUM(c.area) > 30 ;



select distinct s.name, s.depth, c.name
from sea s, geo_sea g, encompasses e, country c
where e.country=c.code and e.continent='Africa' and g.country=c.code and g.sea=s.name
and s.depth =
(select MAX(s1.depth)
from sea s1, geo_sea g1, encompasses e1, country c1
where e1.country=c1.code and e1.continent='Africa' and g1.country=c1.code and g1.sea=s1.name);

select distinct c1.name, c2.name
from country c1, country c2, borders b, language l1, language l2
where b.country1=c1.code and b.country2=c2.code and l1.country=c1.code and l2.country=c2.code and
l1.percentage > 30 and l2.percentage > 30 and l1.name=l2.name order by c1.name ;
