library(testthat)
source("autocomplete_code.R")

###################################### The folloing commented commands are used when testing in R console #######
#                                      Pokemon.txt is used mainly
    # used when run from laptop
    #source("C:/Users/manja/36-750/assignments-mqnjqrid/autocomplete/autocomplete_code.R")

###############################################################################################
datafile = "pokemon.txt"
trie = create_trie(datafile)


# function to counts the number of nodes in the trie that are also data instances
count_intheset = function(trie) {
  sum = sum(trie$intheset)
  if (length(trie$children) == 0) {
    return(sum)      
    } else {
    for (child in trie$children) {
      sum = sum + count_intheset(child)
    }
  }
  return(sum)
}    

############################# Set of tests #####################################
test_that("number of object nodes same as number of instances in datafile", {
  
  #729 is the number of instances in pokemon.txt
  expect_equal(count_intheset(trie), 729)
  trie_wiktionary = create_trie("wiktionary.txt")
  trie_babynames = create_trie("baby-names.txt")
  expect_equal(count_intheset(trie_wiktionary), 10000)
  expect_equal(count_intheset(trie_babynames), 31109)
})
    
test_that("presence of random word from datafile", {
  
  wordset = read.table(datafile, sep = '\t', header = FALSE, stringsAsFactors = FALSE, skip = 1, fill = TRUE, quote = "\"", comment.char = "")
  xword = sample(wordset[,2], 1)
  answer = find_suggestion(xword, 100, trie)
  expect_true(tolower(xword) %in% tolower(answer$word))
})

test_that("presence of random word from datafile suffixed by random string", {
  
  wordset = read.table(datafile, sep = '\t', header = FALSE, stringsAsFactors = FALSE, skip = 1, fill = TRUE, quote = "\"", comment.char = "")
  testsuffix = stri_rand_strings(1, sample(6:20, 1), pattern = "[A-Za-z0-9]")
  xword = paste(sample(wordset[,2], 1), testsuffix, sep = '')
  answer = find_suggestion(xword, 100, trie)
  expect_true(!(tolower(xword) %in% tolower(answer$word)))
})

test_that("double word overlap check", {
  
  answer = find_suggestion("landorus", 2, trie)
  expect_true( answer$word[1] == "Landorus-Therian" )
  expect_true( answer$word[2] == "Landorus" )
  expect_true( length(answer$word) == 2)
})

test_that("output sorted order check", {

  k = ceiling(runif(1, 0, 1)*100)
  answer = find_suggestion("l", k, trie)
  expect_true( is.unsorted(answer$weight))
  expect_true( length(answer$word) <= k)
})

test_that("output case-insensitive", {

  k = ceiling(runif(1, 0, 1)*100)
  answer1 = find_suggestion("lan", k, trie)
  answer2 = find_suggestion("lAN", k, trie)
  answer3 = find_suggestion("LAN", k, trie)
  expect_true( min(answer1$word == answer2$word) > 0) # checks whether all word suggestions match
  expect_true( min(answer1$word == answer3$word) > 0)
  expect_true( min(answer1$weight == answer2$weight) > 0) # checks whether all coordinates match
  expect_true( min(answer1$weight == answer3$weight) > 0)
})

test_that("finds entered whole word", {
  
  answer = find_suggestion("Pikachu", 10, trie)
  expect_true( answer$word[1] == "Pikachu")
  answer = find_suggestion("landorus-THErian", 10, trie)
  expect_true( answer$word[1] == "Landorus-Therian")
})

test_that("check output for random word not present", {
  
  testword = stri_rand_strings(1, sample(6:20, 1), pattern = "[A-Za-z0-9]")
  answer = find_suggestion(testword, 10, trie)
  expect_true(is.null(answer))
})