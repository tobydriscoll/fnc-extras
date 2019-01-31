
lambda = @. 10 + (1:100)

using LinearAlgebra
A = triu(rand(100,100),1) + diagm(0=>lambda)
b = rand(100);

include("../FNC.jl")
Q,H = FNC.arnoldi(A,b,60);

resid = [norm(b);zeros(60)]
for m = 1:60  
    s = [norm(b); zeros(m)]
    z = H[1:m+1,1:m]\s
    x = Q[:,1:m]*z
    resid[m+1] = norm(b-A*x)
 end

using Plots
plot(0:60,resid,m=(3,:o),
    xaxis=("\$m\$"),yaxis=(:log10,"\$\\| b-Ax_m \\|\$"), 
    title="Residual for GMRES",leg=:none)
