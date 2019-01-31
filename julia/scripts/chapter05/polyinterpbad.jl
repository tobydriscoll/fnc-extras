
n = 5
t = range(-1,stop=1,length=n+1)
y = @. t^2 + t + 0.05*sin(20*t)

using Plots
plot(t,y,m=:o,l=nothing,label="data",leg=:top)

using Polynomials
p = polyfit(t,y,n)     # interpolating polynomial
plot!(x->p(x),-1,1,label="interpolant")

n = 18
t = range(-1,stop=1,length=n+1)
y = @. t^2 + t + 0.05*sin(20*t)

plot(t,y,m=:o,l=nothing,label="data",leg=:top)

p = polyfit(t,y,n)
plot!(x->p(x),-1,1,label="interpolant")
