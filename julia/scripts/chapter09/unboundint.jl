
f = x -> 1/(1+x^2);

h = 10 .^range(-3,stop=-1,length=60)
M = 10 .^range(3,stop=16,length=60)

include("../FNC.jl")
I = [ FNC.intde(f,h,M)[1] for h=h, M=M ]
err = @. abs(I-pi);

using Plots
contour(h,M,-log.(10,err.+1e-20),
    xflip=true,xaxis=("h",:log10),yaxis=("M",:log10),
    title="Number of accurate digits")

I,x = FNC.intde(f,0.1,1e10)
err = abs(pi-I)
number_of_nodes = length(x)

xpos = @. (x>0)

plot(x[xpos],f.(x[xpos]),m=:o,
    xaxis=("x",:log10), yaxis=("f(x)",[0,1]),
    title="Positive nodes used for integration",leg=:none)
