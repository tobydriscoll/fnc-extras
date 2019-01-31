
include("../FNC.jl")
x,Dx,Dxx = FNC.diffcheb(40,[0,1]);
A = -Dx[2:end,2:end];    # leave out first row and column

using LinearAlgebra,Plots
lambda = eigvals(A)
scatter(real(lambda),imag(lambda),m=3,
    title="Eigenvalues of advection with zero inflow",leg=:none,aspect_ratio=1) 

maximum( real(lambda) )
