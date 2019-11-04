library(argparse)

parser <- ArgumentParser()

parser$add_argument("-w", "--word", type = "character", default = '', 
                    help = "Word for which suggestions are needed")
parser$add_argument("-n","--numbers", type = "integer", default = 1, 
                    help = "Number of suggestion needed")
parser$add_argument("-r", "--rsession", type = "character", 
                    help = "R Session with trie loaded")
parser$add_argument("-f", "--datafile", type = "character", default = "pokemon.txt",
                    help = "Data file to create trie")
args <- parser$parse_args()

#used to locate file when running from PC
#source("C:/Users/manja/36-750/assignments-mqnjqrid/autocomplete/autocomplete_code.R")
source("autocomplete_code.R")

#checks whether the R session with the trie exists. Otherwise creates the trie using the datafile and stores it in rsession
if (is.null(args$rsession)) {

  trie = create_trie(args$datafile)
  
  #The trie is stored in an Rsession with the same name as that of the datafile
  save(trie, file = paste(substr(args$datafile, 1, nchar(args$datafile) - 4), ".Rdata", sep = ''))
  cat("The trie is stored in file ")
  cat(paste(substr(args$datafile, 1, nchar(args$datafile) - 4), ".Rdata", sep = ''), "\n\n")
 
} else if (!file.exists(args$rsession)) {

  trie = create_trie(args$datafile)
  
  #The trie is stored in the Rsession file entered by the user
  save(trie, file = args$rsession)

} else {
  
  load(args$rsession)
  
  if (!exists("trie")) {
    
    trie = create_trie(args$datafile)
    
    #The trie is stored in the Rsession file entered by the user
    save(trie, file = args$rsession) 
    
  }
}

find_suggestion(args$word, as.numeric(args$numbers), trie)