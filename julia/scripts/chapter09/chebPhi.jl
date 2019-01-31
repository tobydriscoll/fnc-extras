
using Plots
plot([],[],xaxis=("\$x\$"),yaxis=(:log10,"\$|\\Phi(x)|\$",[1e-18,1e-2]))

x = range(-1,stop=1,length=1601)
for n = 10:10:50
    theta = pi*(0:n)/n
    t = @. -cos(theta)                   
    Phi = [ prod(xk.-t) for xk in x ]
    plot!(x,abs.(Phi),m=(1,:o,stroke(0)))
end
plot!([],[],legend=:none,title="Effect of Chebyshev nodes")
