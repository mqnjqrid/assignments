select c.crime_type, count(*) AS WEEK1 from fileblot1 as f FULL outer join section_offense as c on f.section = c.section where f.section in (select cc.section from section_offense as cc) group by c.crime_type;
select c.crime_type, count(*) AS WEEK2 from fileblot2 as f FULL outer join section_offense as c on f.section = c.section where f.section in (select cc.section from section_offense as cc) group by c.crime_type;
select c.crime_type, count(*) AS WEEK3 from fileblot3 as f FULL outer join section_offense as c on f.section = c.section where f.section in (select cc.section from section_offense as cc) group by c.crime_type;
select c.crime_type, count(*) AS WEEK4 from fileblot4 as f FULL outer join section_offense as c on f.section = c.section where f.section in (select cc.section from section_offense as cc) group by c.crime_type;


select count(*) from blotter group by CAST(arrest_time AS DATE);

