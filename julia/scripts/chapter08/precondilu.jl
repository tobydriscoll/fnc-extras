
using SparseArrays, LinearAlgebra 
A = 2.8I + sprand(10000,10000,0.002);

using IterativeSolvers
b = rand(10000)
gmres(A,b,maxiter=300,tol=1e-10,restart=50,log=true);
time_plain = @elapsed x,hist1 = gmres(A,b,maxiter=300,tol=1e-10,restart=50,log=true)

using Plots
plot(hist1[:resnorm],label="", 
    title="GMRES with no preconditioning",
    xaxis=("iteration number"), yaxis=(:log10,"residual norm") )

using IncompleteLU
iLU = ilu(A,τ=0.2);
@show nnz(A),nnz(iLU.L);

time_prec = @elapsed x,hist2 = gmres(A,b,Pl=iLU,maxiter=300,tol=1e-10,restart=50,log=true)

plot(hist1[:resnorm],label="no prec.", 
    xaxis=("iteration number"), yaxis=(:log10,"residual norm") )
plot!(hist2[:resnorm],label="iLU prec.")
