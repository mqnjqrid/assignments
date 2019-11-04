library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")

patchfile = read.csv("C:/Users/manja/36-750/assignments-mqnjqrid/crime_file/crime-week-1-patch.csv", header = FALSE, skip = 1)#, row.names = FALSE)
oldfile = read.csv("C:/Users/manja/36-750/assignments-mqnjqrid/crime_file/crime-week-1.csv")

if(dbExistsTable(con, "patchfileblot")) {
  dbRemoveTable(con, "patchfileblot")
}
if(dbExistsTable(con, "oldfileblot")) {
  dbRemoveTable(con, "oldfileblot")
}
result = dbSendStatement(con, "CREATE table patchfileblot (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);")

dbWriteTable(conn = con, value = patchfile, name = "patchfileblot", append = TRUE)

result1 = dbSendStatement(con, "\copy patchfileblot FROM 'patchfile' WITH CSV HEADER DELIMITER ',';")

result2 = dbSendStatement(con, "CREATE table oldfileblot (_id integer PRIMARY KEY, 
                         REPORT_NAME report_type DEFAULT 'OFFENSE 2.0', 
                         SECTION TEXT, DESCRIPTION TEXT, 
                         ARREST_TIME TIMESTAMP, 
                         ADDRESS TEXT, 
                         NEIGHBORHOOD TEXT, 
                         ZONE NUMERIC);")

result3 = dbSendStatement(con, "\copy oldfileblot FROM 'oldfile' WITH CSV HEADER DELIMITER ',';")

result4 = dbSendStatement(con, "update oldfileblot SET * = patchfileblot.* FROM patchfileblot WHERE oldfileblot._id = patchfileblot._id;")
result5 = dbSendStatement(con, "INSERT into oldfileblot values (select pathfileblot.* FROM patchfileblot LEFT OUTER JOIN oldfileblot on oldfileblot._id = patchfileblot._id where oldfileblot.* IS NULL);")
result6 = dbSendQuery(con, "SELECT * from oldfileblot;")
data = dbFetch(result6)
dbClearResult(result6)







