CREATE table neighborhoodpolice (   
                           lattitude numeric,
                           longitude numeric,
                           hood text,
                           hood_no numeric PRIMARY KEY,
                           acres numeric CHECK (acres > 0),
                           sqmiles numeric CHECK (sqmiles > 0)
                         );

\copy neighborhoodpolice FROM '/home/manjarid/police-neighborhoods.csv' WITH CSV HEADER DELIMITER ',';                                                                                                         

CREATE type report_type as ENUM('OFFENSE 2.0', 'ARREST');

CREATE table blotter (_id integer PRIMARY KEY, REPORT_NAME report_type  DEFAULT 'OFFENSE 2.0', SECTION TEXT, DESCRIPTION TEXT, ARREST_TIME TIMESTAMP, ADDRESS TEXT, NEIGHBORHOOD TEXT, ZONE NUMERIC);

CREATE table weeklycrime (_id integer PRIMARY KEY, REPORT_NAME report_type  DEFAULT 'OFFENSE 2.0', SECTION TEXT, DESCRIPTION TEXT, ARREST_TIME TIMESTAMP, ADDRESS TEXT, NEIGHBORHOOD TEXT, ZONE NUMERIC);


\copy blotter FROM '/home/manjarid/crime-base.csv' WITH CSV HEADER DELIMITER ',';

CREATE TABLE SECTION_OFFENSE (section TEXT, CRIME_type TEXT);

INSERT INTO SECTION_OFFENSE values 
	('3304', 'Criminal mischief'),
	('2709', 'Harassment'),
	('3502', 'Burglary'),
	('13(a)(16)', 'Possession of a controlled substance'),
	('13(a)(30)', 'Possession w/ intent to deliver'),
	('3701', 'Robbery'),
	('3921', 'Theft'),
	('3921(a)', 'Theft of movable property'),
	('3934', 'Theft from a motor vehicle'),
	('3929', 'Retail theft'),
	('2701', 'Simple assault'),
	('2702', 'Aggravated assault'),
	('2501', 'Homicide');