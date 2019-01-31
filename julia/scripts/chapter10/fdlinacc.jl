
lambda = 10;
exact = x -> sinh(lambda*x)/sinh(lambda) - 1;

p = x -> 0;
q = x -> -lambda^2;
r = x -> lambda^2;

include("../FNC.jl")
n = [32,64,128,256,512]
err = zeros(size(n))
using LinearAlgebra:norm
for (k,n) = enumerate(n)
    x,u = FNC.bvplin(p,q,r,[0,1],-1,0,n)
    
    err[k] = norm(exact.(x)-u,Inf)
end

using DataFrames
DataFrame(n=n,error=err)

using Plots
plot(n,err,m=(:o,3),label="observed",
    xaxis=(:log10,"n"), yaxis=(:log10,"max error"),
    title="Convergence of finite differences") 
plot!(n,n.^(-2),l=:dash,label="2nd order")
