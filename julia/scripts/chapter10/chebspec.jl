
include("../FNC.jl")
t,Dx = FNC.diffcheb(3,[-1,1])
Dx

f = x -> x + exp(sin(4*x));
dfdx = x -> 1 + 4*exp(sin(4*x))*cos(4*x);
d2fdx2 = x -> 4*exp(sin(4*x))*(4*cos(4*x)^2-4*sin(4*x));

n = 5:5:70
err1 = zeros(size(n))
err2 = zeros(size(n))
using LinearAlgebra
for (k,n) = enumerate(n)
    t,Dx,Dxx = FNC.diffcheb(n,[-1,1])
    y = f.(t)
    err1[k] = norm( dfdx.(t) - Dx*y, Inf )
    err2[k] = norm( d2fdx2.(t) - Dxx*y, Inf )
end

using DataFrames
DataFrame(n=n,error_first=err1,error_second=err2)

using Plots
plot(n,[err1 err2],m=:o,label=["\$f'\$" "\$f''\$"],
    xaxis=("n"), yaxis=(:log10,"max error"),
    title="Convergence of Chebyshev derivatives")
