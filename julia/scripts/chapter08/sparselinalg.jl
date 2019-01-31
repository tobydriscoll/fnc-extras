
using SparseArrays

n = 5000
density = 1.23e-3
lambda = @. 1/(1:n)
include("../FNC.jl")
A = FNC.sprandsym(n,density,lambda);

using Plots
spy(A,title="Sparse symmetric matrix",color=:bluesreds)

using Arpack
lambda,V = eigs(A,nev=5,which=:LM)    # largest magnitude
lambda

lambda,V = eigs(A,nev=5,sigma=0)    # closest to zero
1 ./ lambda

using LinearAlgebra
x = @. 1/(1:n);  b = A*x;
@elapsed sparse_err = norm(x - A\b)

A = Matrix(A)  # convert to regular matrix
x = @. 1/(1:n);  b = A*x;
@elapsed dense_err = norm(x - A\b)

@show sparse_err,dense_err;
