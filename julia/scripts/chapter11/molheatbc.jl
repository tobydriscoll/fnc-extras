
m = 100
include("../FNC.jl")
x,Dx,Dxx = FNC.diffcheb(m,[-1,1]);

extend(v) = [0;v;2];

chop(u) = u[2:m];

f = function (v,p,t)
    u = extend(v)
    phi = Dxx*u
    return chop(phi)
end
u0 = @. 1 + sin(pi/2*x) + 3*(1-x^2)*exp(-4*x^2);

using DifferentialEquations
V = solve(ODEProblem(f,chop(u0),(0.,0.15)));

t = range(0,stop=0.15,length=11) 
U = hcat( (extend(V(t)) for t in t)... )

using Plots
plot(x,U,label=["t=$t" for t in t],
    xaxis=("x"), yaxis=("u(x,t)"), title="Heat equation",leg=:topleft)
