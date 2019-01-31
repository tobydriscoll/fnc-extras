
m = 25;
x = range(0.05,stop=6,length=m)
y = @. 2*x/(0.5+x)                   # exactly on the curve
@. y += 0.15*cos(2*exp(x/16)*x);     # noise added

using Plots
plot(x,y,m=:o,l=nothing,label="data",
     xlabel="x",ylabel="v",leg=:bottomright)

function misfit(c)
    V,Km = c   # rename components for clarity
    return @. V*x/(Km+x) - y
end

function misfitjac(c)
    V,Km = c   # rename components for clarity
    J = zeros(m,2)
    J[:,1] = @. x/(Km+x)              # d/d(V)
    J[:,2] = @. -V*x/(Km+x)^2         # d/d(Km)
    return J
end

include("../FNC.jl")
c1 = [1, 0.75]
c = FNC.newtonsys(c->(misfit(c),misfitjac(c)),c1)
@show V,Km = c[:,end]  # final values
model = x -> V*x/(Km+x);

using LinearAlgebra
final_misfit_norm = norm(@.model(x)-y) 

plot!(model,0,6,label="MM fit" )

A = [ x.^(-1) x.^0 ];  u = @. 1/y;
z =  A\u;
alpha,beta = z

linmodel = x -> 1 / (beta + alpha/x);
final_misfit_linearized = norm(@. linmodel(x)-y)

plot!(linmodel,0,6,label="linearized fit")
