CREATE table patchfile1 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy patchfile1 FROM '/home/manjarid/crime-week-1-patch.csv' WITH CSV HEADER DELIMITER ',';

CREATE table patchfile2 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy patchfile2 FROM '/home/manjarid/crime-week-2-patch.csv' WITH CSV HEADER DELIMITER ',';

CREATE table patchfile3 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy patchfile3 FROM '/home/manjarid/crime-week-3-patch.csv' WITH CSV HEADER DELIMITER ',';

CREATE table patchfile4 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy patchfile4 FROM '/home/manjarid/crime-week-4-patch.csv' WITH CSV HEADER DELIMITER ',';

CREATE table fileblot2 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy fileblot2 FROM '/home/manjarid/crime-week-1.csv' WITH CSV HEADER DELIMITER ',';

CREATE table fileblot2 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy fileblot2 FROM '/home/manjarid/crime-week-2.csv' WITH CSV HEADER DELIMITER ',';

CREATE table fileblot3 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy fileblot3 FROM '/home/manjarid/crime-week-3.csv' WITH CSV HEADER DELIMITER ',';

CREATE table fileblot4 (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);

\copy fileblot4 FROM '/home/manjarid/crime-week-4.csv' WITH CSV HEADER DELIMITER ',';

update fileblot1 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile1 AS pfile WHERE fileblot1._id = pfile._id;
INSERT into fileblot1 (select pfile.* FROM patchfile1 AS pfile LEFT OUTER JOIN fileblot1 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);
update fileblot1 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile2 AS pfile WHERE fileblot1._id = pfile._id;
INSERT into fileblot1 (select pfile.* FROM patchfile2 AS pfile LEFT OUTER JOIN fileblot1 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);
update fileblot1 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile3 AS pfile WHERE fileblot1._id = pfile._id;
INSERT into fileblot1 (select pfile.* FROM patchfile3 AS pfile LEFT OUTER JOIN fileblot1 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);
update fileblot1 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile4 AS pfile WHERE fileblot1._id = pfile._id;
INSERT into fileblot1 (select pfile.* FROM patchfile4 AS pfile LEFT OUTER JOIN fileblot1 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);

update fileblot2 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile2 AS pfile WHERE fileblot2._id = pfile._id;
INSERT into fileblot2 (select pfile.* FROM patchfile2 AS pfile LEFT OUTER JOIN fileblot2 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);
update fileblot2 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile3 AS pfile WHERE fileblot2._id = pfile._id;
INSERT into fileblot2 (select pfile.* FROM patchfile3 AS pfile LEFT OUTER JOIN fileblot2 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);
update fileblot2 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile4 AS pfile WHERE fileblot2._id = pfile._id;
INSERT into fileblot2 (select pfile.* FROM patchfile4 AS pfile LEFT OUTER JOIN fileblot2 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);

update fileblot3 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile3 AS pfile WHERE fileblot3._id = pfile._id;
INSERT into fileblot3 (select pfile.* FROM patchfile3 AS pfile LEFT OUTER JOIN fileblot3 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);
update fileblot3 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile4 AS pfile WHERE fileblot3._id = pfile._id;
INSERT into fileblot3 (select pfile.* FROM patchfile4 AS pfile LEFT OUTER JOIN fileblot3 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);

update fileblot4 SET REPORT_NAME = pfile.REPORT_NAME, SECTION = pfile.SECTION, ARREST_TIME = pfile.ARREST_TIME, ADDRESS = pfile.ADDRESS, NEIGHBORHOOD = pfile.NEIGHBORHOOD, ZONE = pfile.ZONE FROM patchfile4 AS pfile WHERE fileblot4._id = pfile._id;
INSERT into fileblot4 (select pfile.* FROM patchfile4 AS pfile LEFT OUTER JOIN fileblot4 AS ofile on ofile._id = pfile._id where ofile.* IS NULL);

