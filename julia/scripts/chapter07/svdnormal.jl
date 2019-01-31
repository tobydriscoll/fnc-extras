
A = [0 2; -2 0]

using LinearAlgebra
lambda,V = eigen(A)
opnorm( V'*V - I )

lambda

svdvals(A)
