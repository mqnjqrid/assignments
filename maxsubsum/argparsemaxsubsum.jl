include("maxsubsum.jl")
t = [parse(Int, xx) for xx in ARGS]
print(maxsubsum(t))