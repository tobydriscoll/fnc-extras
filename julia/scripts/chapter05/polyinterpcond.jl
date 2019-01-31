
n = 18
t = range(-1,stop=1,length=n+1)
y = [zeros(9);1;zeros(n-9)];  # data for 10th cardinal function

using Plots
plot(t,y,m=:o,l=nothing,label="data")

include("../FNC.jl")
plot!(FNC.spinterp(t,y),label="spline",
    xlabel="x",ylabel="p(x)",title="Piecewise cubic cardinal function")

plot(t,y,m=:o,l=nothing,label="data")

using Polynomials
p = polyfit(t,y,n)
plot!(x->p(x),-1,1,label="polynomial",
    xlabel="x",ylabel="p(x)",title="Polynomial cardinal function")
