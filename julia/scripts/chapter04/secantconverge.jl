
f = x -> x*exp(x) - 2;
include("../FNC.jl")
x = FNC.secant(f,1,0.5)

using NLsolve
r = nlsolve(x->f(x[1]),[1.]).zero

err = @. r - x

logerr = @. log(abs(err))
ratios = @. logerr[2:end] / logerr[1:end-1]
