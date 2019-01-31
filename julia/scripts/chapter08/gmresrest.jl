
using MatrixDepot
d = 50;
A = d^2*matrixdepot("poisson",d)
@show n = size(A,1)
b = ones(n);

using IterativeSolvers,Plots
maxit = 120;  rtol = 1e-8;
rest = [maxit,20,40,60]
plot([],[],label="",title="Convergence of restarted GMRES",leg=:bottomleft,
    xaxis=("m"), yaxis=(:log10,"residual norm",[1e-8,100]))
for j = 1:4
    x,hist = gmres(A,b,restart=rest[j],tol=rtol,maxiter=maxit,log=true)
    plot!(hist[:resnorm],label="restart = $(rest[j])")
end
plot!([],[],label="")
