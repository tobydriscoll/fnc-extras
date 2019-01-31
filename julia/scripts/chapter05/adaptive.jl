
f = x -> (x+1)^2*cos((2*x+1)/(x-4.3));

using QuadGK
@show I,errest = quadgk(f,0,4,atol=1e-14,rtol=1e-14);  # 'exact' value

include("../FNC.jl")
Q,t = FNC.intadapt(f,0,4,0.001)
@show num_nodes = length(t);

using Plots
plot(f,0,4,color=:black,legend=:none,
    xlabel="x",ylabel="f(x)",title="Adaptive node selection")
plot!(t,f.(t),seriestype=:sticks,m=(:o,2))

@show err = I - Q;

tol_ = @. 10.0^(-4:-1:-14)
err_ = zeros(size(tol_))
num_ = zeros(Int,size(tol_))
for i = 1:length(tol_)
    Q,t = FNC.intadapt(f,0,4,tol_[i])
    err_[i] = I - Q
    num_[i] = length(t)
end

using DataFrames
DataFrame(tol=tol_,error=err_,f_evals=num_)

plot(num_,abs.(err_),m=:o,label="results",
    xaxis=(:log10,"number of nodes"),yaxis=(:log10,"error"),
    title="Convergence of adaptive quadrature")
order4 = @. 0.01*(num_/num_[1])^(-4)
plot!(num_,order4,l=:dash,label="\$O(n^{-4})\$")
