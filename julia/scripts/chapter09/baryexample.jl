
f = x -> sin(exp(2*x))

using Plots
plot(f,0,1,label="function",legend=:bottomleft)

t = (0:3)/3 
y = f.(t)
include("../FNC.jl")
p = FNC.polyinterp(t,y)
scatter!(t,y,color=:black)
plot!(p,0,1,label="interpolant",
    title="Interpolation on 4 nodes")

plot(f,0,1,label="function",legend=:bottomleft)
t = (0:6)/6 
y = f.(t)
p = FNC.polyinterp(t,y)
scatter!(t,y,color=:black)
plot!(p,0,1,label="interpolant",title="Interpolation on 7 nodes")
