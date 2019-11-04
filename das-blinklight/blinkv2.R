library(hash)

togglelt = function(state){
  N = length(state)
  state1 = (c(state[N],state[1:(N - 1)]) + state) %% 2
  return(state1)
}

getstate = function(B, state){
  stopifnot(B > 0)
  N = length(state)
  stopifnot(all(state %in% c(0,1)))
  hashtab = hash(toString(matrix(state,nrow = 1)), c(0))
  state_seq = matrix(state,nrow = 1)  #defining to access state by using value from hash table
  n = 2^N
  for (i in 1:n) {
    state = togglelt(state)
    if(i == B) {
      stateB = state
      break
    }
    
    state_string = toString(matrix(state, nrow = 1))
    if ( has.key(state_string, hashtab)) { 
      period = i - hashtab[[state_string]]
      row_cycle_start = hashtab[[state_string]]
      break
    }else {
      state_seq = rbind(state_seq, state)
      hashtab[[state_string]] = i
    }
  }
  
  if (B > i) { 
    stateB = state_seq[(B - i) %% period + row_cycle_start + 1,]
  }
  
  return(stateB)
}

