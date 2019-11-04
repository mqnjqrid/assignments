###################################################################################################
##
##                                      AUTOCOMPLETE-ME (Challenge 1)
##
###################################################################################################
#
#  Function list and details :-
#     filltree : takes a word and a weight and a trie and places the word in the trie
#     create_trie : takes a datafile and creates a trie containing the data in the datafile using filltree
#     find_suggestion : takes a prefix, number of suggestions (k) and a trie and returns the top k matches
#
###################################################################################################

library(data.tree)
library(data.table)
library(stringi)
library(stringr)
library(liqueueR)
library(profvis)

# inserts words/instances at appropriate places in the trie
filltree = function(treenode, newword, newweight) {   
  # treenode is the starting node, newword is the word to be inserted into the subtrie
  # of treenode, newweight is the corresponding weight

  if (treenode$weight < newweight) {                  
    treenode$weight = newweight
  }
  
  # checking for the maximum substring of newword that is present in treenode
  for (character_position in 1:stri_length(newword)) {
    
    matchnode = NULL
    for (child in treenode$children) {
      if (tolower(child$name) == tolower(substr(newword, character_position, character_position))) {
        
        matchnode = child
        
      }
    }
    
    if (!is.null(matchnode)) {
      
      if (treenode$weight < newweight) {
        treenode$weight = newweight
      }
      
      if (matchnode$weight < newweight) {
        matchnode$weight = newweight
      }
      
      treenode = matchnode 
      #updating treenode for the next loop
      
    } else {
      
      # if the sub string of the newword does not exist already, we create a new path for it
      for (current_position in (character_position):stri_length(newword)) { 
        
        newchild = treenode$AddChild(substr(newword, current_position, current_position))  # the trie nodes are named "child_word1" if the "word1" is the word they contain
        newchild$weight = newweight
        treenode = newchild
      }
      
      # the newword has been placed in the trie and the loop will be exited
      break         
    }
  }
  
  #updating the elements of the leaf node in the trie
  treenode$intheset = TRUE
  treenode$objweight = newweight
}

##################################################################################
##################################################################################
# function to create the trie using the data in the filename
create_trie = function(filename) { 
  
  wordset = read.table(filename, sep = '\t', header = FALSE, stringsAsFactors = FALSE, skip = 1, fill = TRUE, quote = "\"", comment.char = "")
  colnames(wordset) = c("weight", "word")
  wordset$weight = as.numeric(wordset$weight)

  trie = Node$new("") 
  # creating an empty trie
  trie$weight = 0 
  # weight is the maximum of the weights of all the words present in the subtrie of the trie node 
  trie$objweight = NA
  # objweight is the weight of the word at the trie node if that word also belongs to our file 'filename'
  trie$intheset = FALSE
  # TRUE or FALSE correspond to wether the word at the trie node also belongs to the set or not respectively
  
  for (i in 1:length(wordset$weight)) {
    
    filltree(trie, wordset$word[i], wordset$weight[i])
    # reading entries from file 'filename' and entering in trie
  }
  return(trie)
}

####################################################################################
####################################################################################
#function to read word (xword), and return k suggestions from trie starting at treenode
find_suggestion = function(xword, k, treenode) {
  
  # checking if user wants 0 suggestions or entered an empty string
  stopifnot(k > 0)
  stopifnot(nchar(xword) > 0)
  
  ################################## loop to find the node that matches the xword string
  for (character_position in 1:stri_length(xword)) {
    
    matchnode = NULL
    
    for (child in treenode$children) {
      if (tolower(child$name) == tolower(substr(xword, character_position, character_position))) {
        matchnode = child
      }
    }
    treenode = matchnode 
    #updating treenode with matchnode
  }
  
  ################################## search finished
  #return NULL if no match found
  if (is.null(treenode)) {
    return(NULL)
  }
  
  ################################## is match is found, then we look for suggestions in its' subtrie
  #empty queue defined to store nodes that will be processed
  queue = PriorityQueue$new()
  
  #add the first matched node into the queue
  queue$push(treenode, priority = treenode$weight)
  
  #a sorted (in decreasing order by weight) list of size k to contain the suggested words and their weights (initializing with negative weight of -1000)
  #containing the words and their corresponding weights
  suggest = list(word = rep(NA, times = k), weight = rep(-1000, times = k))
  
  #loop to process the queue and update suggest until queue is empty or until all queue elements are of lower weight than all those in suggest
  while (!(is.null(queue)) || ((queue$peek(1))$weight < suggest$weight[k])) {
    
    #obtain the maximum weighted node from the queue
    q_element = queue$poll()

    #checks whether q_element word belongs to the data file and if it does then checks if it has higher weight than all those in suggest
    if (max(q_element$objweight, suggest$weight[k], na.rm = TRUE) > suggest$weight[k]) {

      suggest$word[k] = gsub('\\/', '', q_element$pathString)
      suggest$weight[k] = q_element$objweight
      suggest$word = suggest$word[order(-suggest$weight)]
      suggest$weight = sort(suggest$weight, decreasing = TRUE)
      #inserted q_element's path as a string in suggest and replaced the one with the lowest weight and sorted
    }

    #checks if q_element has children who have higher weight than all those in suggest. It condition is met then the corresponding children are pushed into the queue
    if (q_element$weight > suggest$weight[k]) {
      for (child in q_element$children) {
        if (child$weight > suggest$weight[k]) {
          queue$push(child, priority = child$weight)
        }
      }
    }
    
    #checks of queue is empty
    if (length(queue$priorities) == 0) {
      break
    }
  }
  
  ################################################### process final result
  #drops the elements from the suggest that are empty or NA
  suggest$weight = suggest$weight[which(!is.na(suggest$word))]
  suggest$word = suggest$word[which(!is.na(suggest$word))]
  
  return(suggest)
  
}