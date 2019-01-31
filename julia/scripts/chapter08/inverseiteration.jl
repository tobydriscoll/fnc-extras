
lambda = [1,-0.75,0.6,-0.4,0]

using LinearAlgebra
A = triu(ones(5,5),1) + diagm(0=>lambda)   # triangular matrix, eigs on diagonal

include("../FNC.jl")
gamma,x = FNC.inviter(A,0.7,30)
eigval = gamma[end]

err = @. eigval - gamma

using Plots,LaTeXStrings
plot(0:29,abs.(err),m=:o,label="", 
    title="Convergence of inverse iteration",
    xlabel=L"k",yaxis=(L"|\lambda_3 - \gamma_k|",:log10,[1e-16,1]) )

@show observed_rate = err[22]/err[21];

@show theoretical_rate = (lambda[3]-0.7) / (lambda[1]-0.7);
