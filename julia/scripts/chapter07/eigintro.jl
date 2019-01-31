
A = pi*ones(2,2)
using LinearAlgebra
lambda = eigvals(A)

lambda,V = eigen(A)

D = diagm(0=>lambda)
opnorm( A - V*D/V )      # "/V" is like "*inv(V)""

lambda,V = eigen([1 1;0 1])
@show rank(V);
