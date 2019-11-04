library(hash)

Nodeclass <- setClass(
  "NodeClass",
  
  slots = c(name = "character", nodeobject = "ANY", neighbor = "character"),
  
  prototype = list(name = NULL, nodeobject = NULL, neighbor = NULL)
                                                    
)
  
setMethod("show", "NodeClass", function(object) { cat(object$name, " : ")
                                                    for (friend in object$neighbor) {
                                                      cat(friend$name, ", ")
                                                    }
                                                     cat("\n")
                                                 })

edgeClass <- setClass(
  "edgeClass",
  
  slots = list(edges = "character"),
  
)

Graphclass <- setClass(

  "Graphclass",
  
  slots = c(nodes = "NodeClass", edges   = "edgeClass", directed   = "logical"),
  
  prototype = list(nodes = NULL, edges = NULL, directed = FALSE),
  
  validity = function(object) { # checks whether the graph meets the critia for an undirected graph if it is marked so       
    
    if (object$directed == FALSE) {
      if (setequal(object$edges, cbind(object$edges[,2], object$edges[,1]))) {
        return(TRUE)
        } else {
          return(FALSE)
        }
      }
    }

  toadjmatrix = function(object) {        # to convert the graph into an adjacency matrix. node names are stored in row and column names
    
    mat = matrix(0, nrow = length(object$nodes), ncol = length(object$nodes))
    nameset = NULL
    for (i in 1:length(object$nodes)) {
      nameset = c(colname, (object$nodes[i])$name)
      }
    colnames(mat) = nameset
    rownames(mat) = nameset
    for (edge in object$edges) {
      mat[edge[1], edge[2]] = 1
    }
    return(mat)
  }

  breathfs = function(object, node, fun, hashtable) {  # breadth first search, object = 'graph', node = 'starting node', fun = 'function to be applied on each node', hashtable = 'an empty hash object to be supplied'
    
    hashtable[[node]] = TRUE
    if ((length(node$neighbor) == 0)) {
      return()
    } else {
      for (adj_node in node$neighbor) {
        if (!has.key(adj_node, hashtable) || hashtable[[adj_node]] == FALSE ) {
          hashtable[[adj_node]] = TRUE
          fun(node$neighbor)    # do the processing on each neighbor first
        }
      }
      
      for (adj_node in node$neighbor) {
        if (!has.key(adj_node, hashtable) || hashtable[[adj_node]] == FALSE ) {
                  return(breadthfs(object, adj_node, fun, hashtable) )
        } 
      }
      marked_neighbor = 0
      for (adj_node in node$neighbor) {
        if (has.key(adj_node, hashtable) && hashtable[[adj_node]] == TRUE ) {
          marked_neighbor = marked_neighbor + 1
        }
      }
      if (marked_neighbor == length(node$neighbor )) {
        return()
      }
    }
  }
  
  depthfs = function(object, node, fun, hashtable) {  # depth first search, object = 'graph', node = 'starting node', fun = 'function to be applied on each node', hashtable = 'an empty hash object to be supplied'
    
    hashtable[[node]] = TRUE
    fun(node)     # process the node
    if ((length(node$neighbor) == 0)) {
      return()
    } else {
      for (adj_node in node$neighbor) {
        if (!has.key(adj_node, hashtable) || hashtable[[adj_node]] == FALSE ) {
          return(depthfs(object, adj_node, fun, hashtable) )
        }
      }
      marked_neighbor = 0
      for (adj_node in node$neighbor) {
        if (has.key(adj_node, hashtable) && hashtable[[adj_node]] == TRUE ) {
          marked_neighbor = marked_neighbor + 1
        }
      }
      if (marked_neighbor == length(node$neighbor )) {
        return()
      }
    }
  }
)

setMethod("show", "Graphclass", function(object) {
  
  for (node in object$nodes) {
    print(node)
  }
})