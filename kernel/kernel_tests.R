library(testthat)
library(assertthat)

source("kernel_smoother.R")

test_that("match value for all y's same", {
  
  xs = c(1:7)
  ys = rep(1, times = 7)
  f = make_Kernel_smoother(xs, ys, 7, K_gaussian)
  for (j in 2:7) {
    assert_that(f(xs[1]) == f(xs[j]), msg = "Computes wrong value of y-hat")
  }
})

test_that("individual value check", {
  
  xs = c(1:700)
  ys = runif(700, 0, 2)
  f = make_Kernel_smoother(xs, ys, 0.7, K_boxcar)
  for (j in 2:7) {
    assert_that(f(xs[j]) == ys[j], msg = "Computes wrong value of y-hat")
  }
})

test_that("sorted order for sorted input", {
  
  xs = c(1:700)
  ys = runif(700, 0, 2)
  ys = sort(ys)
  f = make_Kernel_smoother(xs, ys, runif(1, 0.1, 7), K_gaussian)
  assert_that(!is.unsorted(f(xs)), msg = "Increasing input value is not ensuring non-decreasing output")
  
})

test_that("check out for vector input", {
  
  xs = c(1:700)
  ys = runif(700, 0, 2)
  ys = sort(ys)
  f = make_Kernel_smoother(xs, ys, runif(1, 0.1, 7), K_boxcar)
  for (i in 1:7) {
    assert_that(f(xs)[i] == f(xs[i]), msg = "Applying function on a vector and on individual values do not produce same output")
  }  
})
