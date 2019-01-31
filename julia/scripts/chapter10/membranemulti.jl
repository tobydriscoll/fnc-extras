
lambda = 0.5
phi = (r,w,dwdr) -> lambda/w^2 - dwdr/r;

init = ones(301)
include("../FNC.jl")
r,w1 = FNC.bvp(phi,[0,1],[],0,1,[],init)

using Plots
plot(r,w1,xaxis=("r"),yaxis=("w(r)"),title="Solution",leg=:none)

init = 0.5*ones(301)
r,w2 = FNC.bvp(phi,[0,1],[],0,1,[],init)
plot!(r,w2)
