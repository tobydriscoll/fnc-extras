
year = 1955:5:2000
t = year .- 1955;
y = [ -0.0480, -0.0180, -0.0360, -0.0120, -0.0040,
    0.1180, 0.2100, 0.3320, 0.3340, 0.4560 ];

V = [ t.^0 t ]    # Vandermonde-ish matrix
c = V\y
using Polynomials,Plots
p = Poly(c)
f = s -> p(s-1955)
plot(year,y,m=:o,l=nothing,label="data",
    xlabel="year",ylabel="anomaly (degrees C)",leg=:bottomright)
plot!(f,1955,2000,label="linear fit")

V = [ t[i]^j for i=1:length(t), j=0:3 ]   # Vandermonde-ish matrix
p = Poly( V\y )
f = s -> p(s-1955)
plot!(f,1955,2000,label="cubic fit")
