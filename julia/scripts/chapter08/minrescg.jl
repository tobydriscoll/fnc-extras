
using SparseArrays
include("../FNC.jl")

n = 2000
density = 0.005
A = FNC.sprandsym(n,density,1e-2)
@show nnz(A);

x = (1:n)/n
b = A*x;

using IterativeSolvers,LinearAlgebra

xMR,histMR = minres(A,b,tol=1e-12,maxiter=101,log=true)
xCG,histCG = cg(A,b,tol=1e-12,maxiter=101,log=true)

using Plots,LaTeXStrings
plot(0:100,[histMR[:resnorm] histCG[:resnorm]]/norm(b),m=(2,:o),label=["MINRES" "CG"], 
    title="Convergence of MINRES and CG",
    xaxis=("Krylov dimension \$m\$"), yaxis=(:log10,L"\|r_m\| / \|b\|") )

@show errorMR = norm( xMR - x ) / norm(x);
@show errorCG = norm( xCG - x) / norm(x);

A = FNC.sprandsym(n,density,1e-4);

using IterativeSolvers,LinearAlgebra

xMR,histMR = minres(A,b,tol=1e-12,maxiter=101,log=true)
xCG,histCG = cg(A,b,tol=1e-12,maxiter=101,log=true)

using Plots,LaTeXStrings
plot(0:100,[histMR[:resnorm] histCG[:resnorm]]/norm(b),m=(2,:o),label=["MINRES" "CG"], 
    title="Convergence of MINRES and CG",
    xaxis=("Krylov dimension \$m\$"), yaxis=(:log10,L"\|r_m\| / \|b\|") )

@show errorMR = norm( xMR - x ) / norm(x);
@show errorCG = norm( xCG - x) / norm(x);
