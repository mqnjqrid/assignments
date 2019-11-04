library(RPostgreSQL)
library(argparse)
parser <- ArgumentParser()

parser$add_argument("-f", "--datafile", type = "character",
                    help = "Data file to patch older data")
args <- parser$parse_args()

con <- dbConnect(PostgreSQL(), user="manjarid", password="fath1Heim",
                 dbname="manjarid", host="sculptor.stat.cmu.edu")

result = dbSendStatement(con, "Delete from blotter;")  
dbClearResult(result)

dbSendQuery(con, "COPY blotter from STDIN WITH DELIMITER ',' CSV HEADER;")
postgresqlCopyIn(con, args$datafile)

result = dbSendQuery(con, "select blotter.* FROM blotter LEFT OUTER JOIN SECTION_OFFENSE on blotter.section = SECTION_OFFENSE.section where SECTION_OFFENSE.section IS NOT NULL AND blotter.REPORT_NAME = 'OFFENSE 2.0' AND blotter.ZONE IS NOT NULL;")
data <- dbFetch(result)
dbClearResult(result)
write.csv(data, row.names = FALSE, quote = c(2, 3, 4, 6, 7))
