library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")

patchfile = read.csv("C:/Users/manja/36-750/assignments-mqnjqrid/crime_file/crime-week-1-patch.csv")
#                     header = TRUE, colClasses = col_types, col.names = namesset)
oldfile = read.csv("C:/Users/manja/36-750/assignments-mqnjqrid/crime_file/crime-week-1.csv")

if(dbExistsTable(con, "patchfileblot")) {
  dbRemoveTable(con, "patchfileblot")
}

dbWriteTable(conn = con, value = patchfile, name = "patchfileblot", row.names = FALSE)

if(dbExistsTable(con, "oldfileblot")) {
  dbRemoveTable(con, "oldfileblot")
}

dbWriteTable(conn = con, value = oldfile, name = "oldfileblot")

result4 = dbSendStatement(con, "update oldfileblot SET oldfileblot.* = patchfileblot.* FROM patchfileblot WHERE oldfileblot.X_id = patchfileblot.X_id;")
result5 = dbSendStatement(con, "INSERT into oldfileblot values (select pathfileblot.* FROM patchfileblot LEFT OUTER JOIN oldfileblot on oldfileblot.X_id = patchfileblot.X_id where oldfileblot.* IS NULL);")
result6 = dbReadTable(con, "oldfileblot", row.names = FALSE)
write.csv(result6, file = "C:/Users/manja/36-750/assignments-mqnjqrid/crime_files/updated/crime-week-1.csv", row.names = FALSE)
dbClearResult(result6)







