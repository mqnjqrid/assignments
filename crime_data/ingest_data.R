library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")
result = dbSendQuery(con, "select hood from neighborhoodpolice;")
data = dbFetch(result)
dbClearResult(result)
hoods = unlist(data)

datafile = read.csv("stdin", header = TRUE, skip = 4)
#classes = c("integer", "factor", "character", "time", "character", "character", "integer")

write.table(NULL, file = "erroroutfile.txt", row.names = FALSE, col.names = FALSE)
for (j in 1:ncol(datafile)) {
#  print(c(sum(is.na(datafile[,j])), sum(sapply(datafile[,j], "class") != classes[j])))
  if (sum(is.na(datafile[,j])) > 0 ) {#|| sum(sapply(datafile[,j], "class") != classes[j]) > 0) {
    cat("Rows with missing value in column ",file="erroroutfile.txt",append=TRUE)
    cat(j, file = "erroroutfile.txt", append = TRUE)
    cat(" : ", file = "erroroutfile.txt", append = TRUE)
    cat(which(is.na(datafile[,j])), file = "erroroutfile.txt", append = TRUE)
    cat('\n', file = "erroroutfile.txt", append = TRUE)
#    cat("Rows with value not from the required class in column ",file="erroroutfile.txt",append=TRUE)
#    cat(j, file = "erroroutfile.txt", append = TRUE)
#    cat(" : ", file = "erroroutfile.txt", append = TRUE)
#    cat(which(sapply(datafile[,j], "class") != classes[j]), file = "erroroutfile.txt", append = TRUE)
#    cat('\n', file = "erroroutfile.txt", append = TRUE)
  }
}

result = dbSendStatement(con, "Delete from blotter;")  
dbClearResult(result)

colnames(datafile) = c("_id", "report_name", "section", "description", "arrest_time", "address", "neighborhood", "zone")

if (dbExistsTable(con, "blottertemp")) {
  dbRemoveTable(con, "blottertemp")
}
dbWriteTable(con, name = "blottertemp", value = datafile, row.names = FALSE)

#print("\n datafile from blottertemp : \n")
#print(data)

for (hood in hoods) {
  result = dbSendQuery(con, paste("UPDATE blottertemp SET NEIGHBORHOOD = '",  hood, "' WHERE NEIGHBORHOOD ILIKE FORMAT('%%s%%', '", hood, "') or '", hood, "' ilike format ('%%s%%', neighborhood);", sep = ''))
}
#print("hood done")
dbClearResult(result)
dbSendStatement(con, "ALTER table blottertemp alter column report_name type report_type USING report_name::report_type;")
dbSendStatement(con, "ALTER table blottertemp alter column arrest_time type timestamp USING arrest_time::timestamp;")
dbSendStatement(con, "ALTER table blottertemp alter column _id type integer USING _id::integer;")
dbSendStatement(con, "ALTER table blottertemp alter column zone type integer USING zone::integer;")

dbSendStatement(con, "INSERT INTO weeklycrime (SELECT blottertemp.* from blottertemp LEFT OUTER JOIN weeklycrime on weeklycrime._id = blottertemp._id where weeklycrime.* IS NULL);")
