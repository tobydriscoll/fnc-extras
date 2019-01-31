
using SparseArrays
n = 100
D2 = spdiagm(0=>fill(2,n-1),1=>-ones(n-2),-1=>-ones(n-2))
I = spdiagm(0=>ones(n-1))
A = kron(I,D2) + kron(D2,I);

using IterativeSolvers
b = rand(size(A,1))
minres(A,b,maxiter=100,tol=1e-10,log=true);
time_plain = @elapsed x,hist1 = cg(A,b,maxiter=400,tol=1e-10,log=true)

using Plots
plot(hist1[:resnorm],label="", 
    title="CG with no preconditioning",
    xaxis=("iteration number"), yaxis=(:log10,"residual norm") )

using Preconditioners,LinearAlgebra
P = CholeskyPreconditioner(A,1);

time_prec = @elapsed x,hist2 = cg(A,b,Pl=P,maxiter=400,tol=1e-10,log=true)

plot(hist1[:resnorm],label="no prec.", 
    xaxis=("iteration number"), yaxis=(:log10,"residual norm"),
    title="CG with incomplete Cholesky preconditioning")
plot!(hist2[:resnorm],label="iChol prec.")
