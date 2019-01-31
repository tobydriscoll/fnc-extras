
lambda = @. 10 + (1:100)

using LinearAlgebra
A = triu(rand(100,100),1) + diagm(0=>lambda)
b = rand(100);

Km = [b zeros(100,29)]
for m = 1:29      
    v = A*Km[:,m]
    Km[:,m+1] = v/norm(v)
end

resid = zeros(30)
for m = 1:30  
    z = (A*Km[:,1:m])\b
    x = Km[:,1:m]*z
    resid[m] = norm(b-A*x)
end

using Plots
plot(0:29,resid,m=:o,
    xaxis=("\$m\$"),yaxis=(:log10,"\$\\| b-Ax_m \\|\$"), 
    title="Residual for linear systems",leg=:none)
