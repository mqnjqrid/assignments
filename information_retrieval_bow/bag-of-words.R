library(lexicon)
library(Matrix)

tokenize = function(namefile) {

  file_of_words = scan(namefile, character(0), comment.char = "")
  word_vector = file_of_words[!grepl('#', file_of_words)]

  return(tolower(word_vector))
}

makeBoW = function(token, lexicon) {
  bow = matrix(0, nrow = 1, ncol = length(lexicon))
  colnames(bow) = lexicon
  for (word in token) {
    bow[1, word] = bow[1, word] + 1
  }

  return(bow)
}

analyzeCorpus = function(file_list) {
  n = length(file_list)
  word_list = NULL
  for (filename in file_list) {
    word_list = c(word_list, tokenize(filename))
  }
  lexicon = sort(unique(word_list))
  bow_list = matrix(NA, nrow = n, ncol = length(lexicon))
  for (i in 1:n) {
        word_list = tokenize(file_list[i])
    bow_list[i,] = makeBoW(word_list, lexicon)
  }
  return(bow_list)
}

path_art = "C:/Users/manja/36-750/problem-bank/Data/information-retrieval-bow/nyt-collection-text/art/"
filelist_art = list.files(path_art, pattern = NULL, all.files = FALSE, full.names = TRUE)

path_music = "C:/Users/manja/36-750/problem-bank/Data/information-retrieval-bow/nyt-collection-text/music/"
filelist_music = list.files(path_music, pattern = NULL, all.files = FALSE, full.names = TRUE)

file_art_music = c(filelist_art, filelist_music)

bow_matrix = analyzeCorpus(c(filelist_art, filelist_music))

euclid_dist = function(bow1, bow2) {
  return(sqrt(sum((bow1 - bow2)^2)))
}

max_dist = function(bow1, bow2) {
  return(max(abs(bow1 - bow2)))
}

################# distance matrices
bow_euclid_dist = apply(bow_matrix, 1, function(x) { return(apply(bow_matrix, 1, function(y) { return(euclid_dist(x, y))}))})
bow_max_dist = apply(bow_matrix, 1, function(x) { return(apply(bow_matrix, 1, function(y) { return(max_dist(x, y))}))})

IrSearch = function(bow, bow_corpus, k) {
  bow_dist = apply(bow_corpus, 1, function(y) { return(euclid_dist(bow, y))})
  top_k = order(bow_dist[1:k])
  return(file_art_music[top_k])
}

######################################## plot with cmd scale
#  loc = cmdscale(bow_euclid_dist)
#  x <- loc[, 1]
#  y <- -loc[, 2] # reflect so North is at the top

## note asp = 1, to ensure Euclidean distances are represented correctly
#  plot(x, y, xlab = "", ylab = "", asp = 1, axes =TRUE,
#       main = "euclid_dist", col = c(rep("red", times = 57), rep("blue", times = 45)))

#aadist = apply(aa, 1, function(x) { return(apply(aa, 1, function(y) { return(euclid_dist(x, y))}))})
#plot(c(1:102), c(1:102), col = bow_euclid_dist)

# plotting distance as image. white for low value, blue for high value
rbPal <- colorRampPalette(c('white','blue'))
image(bow_euclid_dist, col = rbPal(64))
image(bow_max_dist, col = rbPal(64))

############################################# defining lexicon ###############
word_list = NULL
for (filename in file_art_music) {
  word_list = c(word_list, tokenize(filename))
}
lexicon = sort(unique(word_list))

################################################

test_set = sample(file_art_music, 5, replace = FALSE)

for (file in test_set) {
  print(file)
  token = tokenize(file)
  bow = makeBoW(token, lexicon)
  print(IrSearch(bow, bow_matrix, 6))
}
