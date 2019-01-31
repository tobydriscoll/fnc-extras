
lambda = 0.6
phi = (r,w,dwdr) -> lambda/w^2 - dwdr/r;
a = eps();  b = 1;

lval = [];  lder = 0;   # w(a)=?, w'(a)=0
rval = 1;   rder = [];  # w(b)=1, w'(b)=?

include("../FNC.jl")
r,w,dwdx = FNC.shoot(phi,(a,b),lval,lder,rval,rder,0.8)

using Plots
plot(r,w,leg=:none,title="Correct solution",
    xaxis=("x"), yaxis=("w(x)"))

@show w[end];

@show w[1];
