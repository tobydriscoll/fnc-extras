
include("../FNC.jl")
using Plots

plot([],[],label="",xaxis=("\$x\$"),yaxis=(:log10,"\$|f(x)-p(x)|\$",[1e-20,1]))

f = x -> 1/(x^2 + 16)

x = range(-1,stop=1,length=1601)
for (k,n) = enumerate([4,10,16,40])
    t = [ -cos(pi*k/n) for k=0:n ]
    y = f.(t)                           # interpolation data
    p = FNC.polyinterp(t,y)
    err = @.abs(f(x)-p(x))
    plot!(x,err,m=(1,:o,stroke(0)),label="degree $n")
end
plot!([],[],label="",title="Error for Chebyshev interpolants")
