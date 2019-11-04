library(RPostgreSQL)

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")

result = dbSendQuery(con, "select blotter1.* FROM blotter1 LEFT OUTER JOIN SECTION_OFFENSE on blotter1.section = SECTION_OFFENSE.section where SECTION_OFFENSE.section IS NOT NULL AND blotter1.REPORT_NAME = 'OFFENSE 2.0' AND blotter1.ZONE IS NOT NULL;")
data <- dbFetch(result)

write.csv(data)

dbClearResult(result)

