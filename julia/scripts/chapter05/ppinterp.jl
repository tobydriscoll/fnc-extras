
n = 12
t = range(-1,stop=1,length=n+1)
y = @. t^2 + t + 0.5*sin(20*t)

using Plots
plot(t,y,m=:o,l=nothing,label="data",leg=:top) 

using Interpolations
p = LinearInterpolation(t,y)
plot!(x->p(x),-1,1,label="piecewise linear")

p = CubicSplineInterpolation(t,y)
plot(t,y,m=:o,l=nothing,label="data",leg=:top) 
plot!(x->p(x),-1,1,label="piecewise cubic")
