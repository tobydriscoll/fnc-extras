
include("../FNC.jl")
using LinearAlgebra

m = 100
x,Dx,Dxx = FNC.diffper(m,[0,1]);

tfinal = 0.05;  n = 500;  
tau = tfinal/n;  t = tau*(0:n);
U = zeros(m,n+1);

U[:,1] = @. exp( -60*(x-0.5)^2 );

A = I + tau*Dxx;
for j = 1:n
    U[:,j+1] = A*U[:,j]
end

using Plots
plot(x,U[:,1:3:7],label=["t=$t" for t in t[1:3:7]],
    xaxis=("x"),yaxis=("u(x,t)"),
    title="Heat equation by forward Euler")

plot(x,U[:,13:3:19],label=["t=$t" for t in t[13:3:19]],
    xaxis=("x"),yaxis=("u(x,t)"),
    title="Heat equation by forward Euler")

M = vec(maximum( abs.(U), dims=1 ))     # max in each column
plot(t,M,xaxis=("\$t\$"), yaxis=(:log10,"\$\\max_x |u(x,t)|\$"),
    title="Nonphysical growth",leg=:none) 

using SparseArrays

B = sparse(I - tau*Dxx)
for j = 1:n
    U[:,j+1] = B\U[:,j]
end

plot(x,U[:,1:100:501],label=["t=$t" for t in t[1:100:501]],
    xaxis=("x"),yaxis=("u(x,t)"),
    title="Heat equation by backward Euler")
