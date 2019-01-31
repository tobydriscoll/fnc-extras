
t = [ 0.35,0.5,0.57,0.6,0.75 ]   # nodes
f = x -> cos(x^2)
dfdx = x -> -2*x*sin(x^2)
exact_value = dfdx(0.5)

include("../FNC.jl")
w = FNC.fdweights(t.-0.5,1)

using LinearAlgebra
fd_value = dot(w,f.(t))

Rational.( FNC.fdweights(0:2,1) )
