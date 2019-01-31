
t = [0, 0.075, 0.25, 0.55, 0.7, 1]

using Plots
include("../FNC.jl")

plot([x->FNC.hatfun(x,t,k) for k=0:5],0,1,label="",
    xlabel="\$x\$", ylabel="\$H_k(x)\$", title="Hat functions")
