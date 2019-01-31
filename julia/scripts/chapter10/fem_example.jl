
c = x -> x^2;
q = x -> 4;
f = x -> sin(pi*x);

include("../FNC.jl")
x,u = FNC.fem(c,q,f,0,1,50)

using Plots
plot(x,u,xaxis=("x"),yaxis=("u"),title="Solution by finite elements",leg=:none)
