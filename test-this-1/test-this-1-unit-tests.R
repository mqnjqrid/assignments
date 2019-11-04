library(testthat)

test_that("Output format check", {
  
  N = sample(1:50, 1)
  testsequence = sort(sample(1:100, N, replace = TRUE))
  answer <- findInterval(3, testsequence)
  
  expect_that( answer, is_a("numeric") )
  expect_true( is.element(answer, 0:N))
  expect_true(length(answer) == 1)
})

test_that("Value verify", {
  
  answer <- findInterval(3, c(2, 2, 2, 2, 2))
  
  expect_true(answer == 5)
})

test_that("Value verify", {
  
  answer <- findInterval(1.9, c(2, 2, 2, 2, 2))
  
  expect_true(answer == 0)
})

test_that("Value verify", {
  
  answer <- findInterval(6, c(6, 6, 6))
  
  expect_true(answer == 3)
})

test_that("Value verify", {
  
  answer <- findInterval(3, c(1, 1, 2, 2, 3, 4, 4))
  
  expect_true(answer == 5)
})

