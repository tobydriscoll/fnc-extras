
f = x -> exp(sin(7*x));
a = 0;  b = 2;

using QuadGK
I,errest = quadgk(f,a,b,atol=1e-14,rtol=1e-14);
println("Integral = $I")

include("../FNC.jl")
T,t,y = FNC.trapezoid(f,a,b,40)
@show T;
@show err = I - T;

n = @. 40*2^(0:5)
err = zeros(size(n));
for (k,n) = enumerate(n)
    T,t,y = FNC.trapezoid(f,a,b,n)
    err[k] = I - T
end

using DataFrames
DataFrame(n=n,error=err)

using Plots

plot(n,abs.(err),m=:o,label="results",
    xaxis=(:log10,"n"),yaxis=(:log10,"error"),title="Convergence of trapezoidal integration")
plot!(n,3e-3*(n/n[1]).^(-2),l=:dash,label="2nd error")
