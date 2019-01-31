
A = rand(1.:9.,5,5)
using LinearAlgebra
L = tril(A)

b = ones(5)
include("../FNC.jl")
x = FNC.forwardsub(L,b)

b - L*x

alpha = 0.3;
beta = 2.2;
U = diagm(0=>ones(5),1=>[-1,-1,-1,-1])
U[1,[4,5]] = [ alpha-beta, beta ]
U

x_exact = ones(5)
b = [alpha,0,0,0,1]

x = FNC.backsub(U,b)
err = x - x_exact

alpha = 0.3;
beta = 1e12;
U = diagm(0=>ones(5),1=>[-1,-1,-1,-1])
U[1,[4,5]] = [ alpha-beta, beta ]
b = [alpha,0,0,0,1]

x = FNC.backsub(U,b)
err = x - x_exact
