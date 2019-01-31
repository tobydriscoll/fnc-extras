
year = 1980:10:2010 
pop = [984.736, 1148.364, 1263.638, 1330.141];

t = year .- 1980
y = pop;

V = [ t[i]^j for i=1:4, j=0:3 ]

c = V \ y

using Polynomials
p = Poly(c)    # construct a polynomial
p(2005-1980)   # apply the 1980 time shift

using Plots
plot(1980 .+ t,y,m=:o,l=nothing,label="actual",legend=:topleft,
    xlabel="year",ylabel="population (millions)",title="Population of China")

tt = range(0,stop=30,length=300)   # 300 times from 1980 to 2010
plot!(1980 .+ tt,p(tt),label="interpolant")

plot(1980 .+ t,y,m=:o,l=nothing,label="actual",legend=:topleft,
    xlabel="year",ylabel="population (millions)",title="Population of China")

tt = range(-10,stop=50,length=300)   
plot!(1980 .+ tt,p(tt),label="interpolant")
