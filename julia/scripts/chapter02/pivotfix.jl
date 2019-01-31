
A = [2 0 4 3 ; -4 5 -7 -10 ; 1 15 2 -4.5 ; -2 0 2 -13];
b = [ 4, 9, 29, 40 ];

using LinearAlgebra
L,U,p = lu(A);
L

U

p

I = diagm(0=>ones(4))
P = I[p,:]

include("../FNC.jl")
x = FNC.backsub( U, FNC.forwardsub(L,b[p,:]) )

fact = lu(A)
fact.L

x = fact\b
