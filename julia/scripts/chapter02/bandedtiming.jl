
using LinearAlgebra,SparseArrays

n = 10000
A = diagm(0=>1:n,1=>n-1:-1:1,-1=>ones(n-1))

@time lu(A);

A = spdiagm(0=>1:n,1=>n-1:-1:1,-1=>ones(n-1))

@time lu(A);
