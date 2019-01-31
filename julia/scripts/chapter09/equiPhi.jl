
using Plots

plot([],[],xaxis=("\$x\$"),yaxis=(:log10,"\$|\\Phi(x)|\$",[1e-25,1]),
    legend=:none,title="Effect of equispaced nodes")

x = range(-1,stop=1,length=1601)
for n = 10:10:50
    t = range(-1,stop=1,length=n+1)
    Phi = [ prod(xk.-t) for xk in x ]
    scatter!(x,abs.(Phi),m=(1,stroke(0)))
end
plot!([],[],legend=:none,title="Effect of equispaced nodes")
