
f = x -> exp(sin(7*x))

using Plots
plot(f,0,1,label="function",
    xlabel="x",ylabel="f(x)")

t = [0, 0.075, 0.25, 0.55, 0.7, 1]    # nodes
y = f.(t)                             # function values

plot!(t,y,m=:o,l=nothing,label="nodes")

include("../FNC.jl")
p = FNC.plinterp(t,y)
plot!(p,0,1,label="interpolant",title="PL interpolation")
