source("blinkv2.R")
#source("C:/Users/manja/36-750/assignments-mqnjqrid/das-blinklight/blinkv2.R") used when running in R console

library(testthat)

test_that("Output is in format", {
  N=sample(3:16,1)
  returned_state <- getstate(sample(3:(10^9),1),sample(c(0,1),N,replace=TRUE))
  
  expect_true( all(returned_state %in% c(0,1))==TRUE)
  expect_that( length(returned_state), equals(N))
  })
test_that("Output correctness for arbitrary length", {
  N=sample(3:16,1)
  returned_state <- getstate(2,c(1,rep(0,N-1)))
  
  expect_equal( returned_state, c(c(1,0,1),rep(0,N-3)))
  })
test_that("Output coorrectness for arbitraty B", {
  B=sample(3:(10^9),1)
  returned_state <- getstate(B,c(1,0,0))
  checkstate=c(1,1,1)
  checkstate[(B+1)%%3+1]=0
  expect_equal( returned_state, checkstate)
  })
