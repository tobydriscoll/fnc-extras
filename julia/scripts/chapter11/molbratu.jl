
m = 100
include("../FNC.jl")
x,Dx,Dxx = FNC.diffcheb(m,[-1,1]);

extend(v) = [0;v;0];  # extend to boundary
chop(u) = u[2:m];     # discard boundary
ODE = function (v,p,t) 
    u = extend(v)
    uxx = Dxx*u
    f = @.u^2 + uxx
    return chop(f)
end

u0 = @. 6*(1-x^2)*exp(-4*(x-.5)^2)

using DifferentialEquations
V = solve(ODEProblem(ODE,chop(u0),(0.,1.5)));

t = range(0,stop=1.5,length=7) 
U = hcat( (extend(V(t)) for t in t)... )

using Plots
plot(x,U,label=["t=$t" for t in t],
    xaxis=("x"), yaxis=("u(x,t)"), title="Heat equation with source",leg=:topleft)

an = @animate for t = range(0,stop=1.5,length=100)
    plot(x,extend(V(t)),label="t=$(round(t,digits=3))",
        xaxis=("x"), yaxis=([0,10],"u(x,t)"), title="Heat equation with source",leg=:topleft)
end
gif(an,"molbratu.gif")
