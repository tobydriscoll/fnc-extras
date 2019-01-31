
lambda = [1,-0.75,0.6,-0.4,0]

using LinearAlgebra
A = triu(ones(5,5),1) + diagm(0=>lambda)   # triangular matrix, eigs on diagonal

include("../FNC.jl")
gamma,x = FNC.poweriter(A,60)
eigval = gamma[end]

err = @. eigval - gamma

using Plots,LaTeXStrings
plot(0:59,abs.(err),m=:o,label="", 
    title="Convergence of power iteration",
    xlabel=L"k",yaxis=(L"|\lambda_1 - \gamma_k|",:log10,[1e-10,1]) )

@show theory = lambda[2]/lambda[1];
@show observed = err[40]/err[39];

gamma[36:40]
