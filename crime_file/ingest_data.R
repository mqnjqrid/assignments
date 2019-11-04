library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")
result = dbSendQuery(con, "select hood from neighborhoodpolice;")
data = dbFetch(result)
dbClearResult(result)

hoods = unlist(data)

for (hood in hoods) {
  result = dbSendQuery(con, "UPDATE Blotterstdin SET NEIGHBORHOOD = hood WHERE NEIGHBORHOOD ILIKE FORMAT('%%s%%', hood) or hood ilike format ('%%s%%', neighborhood);")
}






result = dbSendQuery(con, "UPDATE Blotterstdin AS bb SET NEIGHBORHOOD = (select hood from neighborhoodpolice AS np WHERE bb.NEIGHBORHOOD ILIKE FORMAT('%%s%%', np.hood) or np.hood ilike format ('%%s%%', bb.neighborhood));")

result = dbSendStatement(con, "UPDATE Blotterstdin SET NEIGHBORHOOD = (select hood from neighborhoodpolice AS np INNER join blotterstdin AS bb on bb.NEIGHBORHOOD ILIKE FORMAT('%%s%%', np.hood) or np.hood ilike format ('%%s%%', bb.neighborhood));")
result = dbSendStatement(con, "select hood from neighborhoodpolice AS np INNER join blotterstdin AS bb on bb.NEIGHBORHOOD ILIKE FORMAT('%%s%%', np.hood) or np.hood ilike format ('%%s%%', bb.neighborhood) AND bb._id IS NULL AND;")
data = dbFetch(result)
