
exact = x -> exp(sin(x));

p = x -> -cos(x);
q = sin;
r = x -> 0;      # function, not value 

include("../FNC.jl")
x,u = FNC.bvplin(p,q,r,[0,pi/2],1,exp(1),25);

using Plots

plot(x,u,layout=(2,1),subplot=1,yaxis=("solution"),
    title="Solution of the BVP",leg=:none)

plot!(x,exact.(x)-u,m=:o,subplot=2,yaxis=("error"),leg=:none)
