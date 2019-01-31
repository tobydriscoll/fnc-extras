
f = x -> x + exp(sin(4*x));

dfdx = x -> 1 + 4*exp(sin(4*x))*cos(4*x);
d2fdx2 = x -> 4*exp(sin(4*x))*(4*cos(4*x)^2-4*sin(4*x));

include("../FNC.jl")
t,Dx,Dxx = FNC.diffmat2(12,[-1,1])
y = f.(t);

yx = Dx*y;
yxx = Dxx*y;

using Plots
plot(dfdx,-1,1,layout=2,subplot=1,xaxis=("x"),yaxis=("f'(x)"),leg=:none)
scatter!(t,yx,m=(2),subplot=1)
plot!(d2fdx2,-1,1,subplot=2,xaxis=("x"),yaxis=("f''(x)"))
scatter!(t,yxx,m=(2),subplot=2,leg=:none)

using LinearAlgebra   # for norm
n = @. round(Int,2^(4:.5:11) )
err1 = zeros(size(n))
err2 = zeros(size(n))
for (k,n) = enumerate(n)
    t,Dx,Dxx = FNC.diffmat2(n,[-1,1])
    y = f.(t)
    err1[k] = norm( dfdx.(t) - Dx*y, Inf )
    err2[k] = norm( d2fdx2.(t) - Dxx*y, Inf )
end

using DataFrames
DataFrame(n=n,error_first=err1,error_second=err2)

plot(n,[err1 err2],m=:o,label=["\$f'\$" "\$f''\$"])
plot!(n,10*10*n.^(-2),l=:dash,label="2nd order",
    xaxis=(:log10,"n"), yaxis=(:log10,"max error"),
    title="Convergence of finite differences")
