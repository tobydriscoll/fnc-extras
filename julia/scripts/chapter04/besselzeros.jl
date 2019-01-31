
using SpecialFunctions,Plots 

J3(x) = besselj(3,x)
plot(J3,0,20,
    grid=:xy,legend=:none,
    xaxis=("\$x\$"),yaxis=("\$J_3(x)\$"),title="Bessel function")

using NLsolve
omega = []
for guess = [6.,10.,13.,16.,19.]
    s = nlsolve(x->besselj(3,x[1]),[guess])
    omega = [omega;s.zero]
end
omega

plot!(omega,J3.(omega),m=:o,l=nothing,title="Bessel function with roots")
