using Base.Test
using StatsBase
include("maxsubsum.jl")
@test maxsubsum([1, -1, 1, -1]) == 1
@test maxsubsum([-2, -6, -4, -8, -6, -5]) == 0
@test maxsubsum([1, 2, -5, -7, 3, 4, -2, 20]) == 25
@test maxsubsum([10, -11, 6, 6, -11, 10]) == 12
x = sample(1:1000, 200)
@test maxsubsum(x) == sum(x)