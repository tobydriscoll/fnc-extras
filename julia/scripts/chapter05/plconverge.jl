
include("../FNC.jl")

f = x -> exp(sin(7*x))
x = (0:10000)/1e4  # sample the difference at many points
n = @. 2^(3:10)
err = zeros(size(n))
for (i,n) = enumerate(n)
    t = (0:n)/n   # interpolation nodes
    p = FNC.plinterp(t,f.(t))
    err[i] = maximum( @. abs(f(x)-p(x)) )
end

using Plots,LaTeXStrings
order2 = @. 0.1*(n/n[1])^(-2)
plot(n,[err order2],m=:o,l=[:solid :dash],label=["error" "2nd order"],
    xaxis=(:log10,L"n"),yaxis=(:log10,L"\|f-p\|_\infty"),title="Convergence of PL interpolation")
