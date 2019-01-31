
f = x -> exp(sin(7*x))

using Plots
plot(f,0,1,label="function")

t = [0, 0.075, 0.25, 0.55, 0.7, 1]  # nodes
y = f.(t)                           # values at nodes

plot!(t,y,m=:o,l=nothing,label="nodes")

include("../FNC.jl")
S = FNC.spinterp(t,y)

plot!(S,0,1,label="spline")

x = (0:10000)/1e4          # sample the difference at many points
n_ = @. round(Int,2^(3:0.5:8))  # numbers of nodes
err_ = zeros(size(n_))
for (i,n) = enumerate(n_)
    t = (0:n)/n 
    S = FNC.spinterp(t,f.(t))
    err_[i] = maximum( @. abs(f(x)-S(x)) )
end

@show err_;

using LaTeXStrings
order4 = @. (n_/n_[1])^(-4)
plot(n_,[err_,order4],m=[:o :none],l=[:solid :dash],label=["error","4th order"],
    xaxis=(:log10,L"n"),yaxis=(:log10,L"\| f-S \|_\infty"),
    title="Convergence of spline interpolation")
