#Gaussian kernel function
K_gaussian <- function(x) {
  return(exp(-x^2/2)/(sqrt(2*pi)))
}

#K_boxcar kernel function
K_boxcar <- function(x) {
  if (abs(x) > 1) {
    return(0)
  } else {
    return(0.5)
  }
}

# takes in pairs (x, y) and a function Kernel and returns a smoother function fsmooth that scales function Kernel by Bandwidth to create a new function
smoother_factory <- function(xs, ys, Kernel) {

  # function that smoothes a given kernel by scaling it with Bandwidth
  fsmooth <- function(Bandwidth) {

    if (Bandwidth <= 0) {
      stop("Error : Bandwidth must be positive")
    } else {
      
      # function that evaluates the estimator at a given value x
      fBandwidth <- function(x) {

        weight = sapply((xs - x)/Bandwidth, Kernel)
        
        # checks if any of the points is xs can contribute to the estimation. If no points have positive weight, then 0 is the estimated value
        if (sum(weight) == 0) {
          return(0)
        } else {
          return(sum(weight*ys)/sum(weight))
        }
      }
    }
    return(fBandwidth)
  }
  return(fsmooth)
}

# function that returns a function kernel_estimate, that returns the estimated value at x (simple or vector)
make_Kernel_smoother <- function(xs, ys, Bandwidth, Kernel) {

  # smoothing the kernel and obtaining an estimator function fBandwidth
  factory = smoother_factory(xs, ys, Kernel)
  fBandwidth = factory(Bandwidth)
  
  kernel_estimate <- function(x) {
    
    fhat = sapply(x, fBandwidth)
    return(fhat)
  }
  
  return(kernel_estimate)
}

