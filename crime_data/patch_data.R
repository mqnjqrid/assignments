library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")


if (dbExistsTable(con, "patchfileblot")) { 
  dbSendStatement(con, "DROP table patchfileblot;")  
}

datafile = read.csv("stdin", header = TRUE, skip = 4)

colnames(datafile) = c("_id", "report_name", "section", "description", "arrest_time", "address", "neighborhood", "zone")
dbWriteTable(conn = con, value = datafile, name = "patchfileblot", row.names = FALSE)

dbSendStatement(con, "ALTER table patchfileblot alter column report_name type report_type USING report_name::report_type;")
dbSendStatement(con, "ALTER table patchfileblot alter column arrest_time type timestamp USING arrest_time::timestamp;")
dbSendStatement(con, "ALTER table patchfileblot alter column _id type integer USING _id::integer;")
dbSendStatement(con, "ALTER table patchfileblot alter column zone type integer USING zone::integer;")

result4 = dbSendStatement(con, "update weeklycrime SET REPORT_NAME = patchfileblot.REPORT_NAME, SECTION = patchfileblot.SECTION,
                          ARREST_TIME = patchfileblot.ARREST_TIME, ADDRESS = patchfileblot.ADDRESS, 
                          NEIGHBORHOOD = patchfileblot.NEIGHBORHOOD, ZONE = patchfileblot.ZONE  
                          FROM patchfileblot WHERE weeklycrime._id = patchfileblot._id;")
dbClearResult(result4)
result5 = dbSendStatement(con, "INSERT into weeklycrime (select patchfileblot.* FROM patchfileblot LEFT OUTER JOIN weeklycrime on weeklycrime._id = patchfileblot._id where weeklycrime.* IS NULL);")
dbClearResult(result5)