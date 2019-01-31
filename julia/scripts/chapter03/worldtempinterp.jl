
t = 1955:5:2000
y = [ -0.0480, -0.0180, -0.0360, -0.0120, -0.0040,
    0.1180, 0.2100, 0.3320, 0.3340, 0.4560 ];
    
using Plots
plot(t,y,m=:o,l=nothing,label="data",
    xlabel="year",ylabel="anomaly (degrees C)",leg=:bottomright)

t = @. (t-1950)/10; 
V = [ t[i]^j for i=1:length(t), j=0:length(t)-1 ]
c = V\y

using Polynomials
p = Poly(c)
f = s -> p((s-1950)/10)
plot!(f,1955,2000,label="interpolant")
