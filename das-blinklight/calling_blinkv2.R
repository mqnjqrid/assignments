args = commandArgs(trailingOnly = TRUE)
arr=as.numeric(strsplit(args," "))
B=arr[1]
state=arr[-1]
#source("C:/Users/manja/36-750/assignments-mqnjqrid/das-blinklight/blinkv2.R")
source("blinkv2.R")
getstate(B,state)