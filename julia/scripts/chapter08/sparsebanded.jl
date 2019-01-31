
using SparseArrays

n = 50;
A = spdiagm(-3=>fill(n,n-3),0=>ones(n),1=>-(1:n-1))

Matrix( A[1:7,1:7] )

include("../FNC.jl")

L,U = FNC.lufact(A)

using Plots
spy(sparse(L),layout=2,subplot=1,markersize=2,title="L")
spy!(sparse(U),layout=2,subplot=2,markersize=2,title="U")

using LinearAlgebra
fact = lu(A)

spy(sparse(fact.L),layout=2,subplot=1,markersize=2,title="L")
spy!(sparse(fact.U),layout=2,subplot=2,markersize=2,title="U")
