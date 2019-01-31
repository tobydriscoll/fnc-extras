
f = x -> 1/(x^2 + 16)

using Plots
plot(f,-1,1,title="Test function",legend=:none)

include("../FNC.jl")
plot([],[],label="",xaxis=("\$x\$"),yaxis=(:log10,"\$|f(x)-p(x)|\$",[1e-20,1]))

x = range(-1,stop=1,length=1601)
n = 4:4:12
for (k,n) = enumerate(n)
    t = range(-1,stop=1,length=n+1)     # equally spaced nodes
    y = f.(t)                          # interpolation data
    p = FNC.polyinterp(t,y)
    err = @.abs(f(x)-p(x))
    plot!(x,err,m=(1,:o,stroke(0)),label="degree $n")
end
plot!([],[],label="",title="Error for low degrees")

n = @. 12 + 15*(1:3)
plot([],[],label="",xaxis=("\$x\$"),yaxis=(:log10,"\$|f(x)-p(x)|\$",[1e-20,1]))

for (k,n) = enumerate(n)
    t = range(-1,stop=1,length=n+1)     # equally spaced nodes
    y = f.(t)                          # interpolation data
    p = FNC.polyinterp(t,y)
    err = @.abs(f(x)-p(x))
    plot!(x,err,m=(1,:o,stroke(0)),label="degree $n")
end
plot!([],[],label="",title="Error for higher degrees")
