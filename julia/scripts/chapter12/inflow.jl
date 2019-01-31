
include("../FNC.jl")
n = 100
x,Dx = FNC.diffmat2(n,[0 1])
uinit = @. exp(-80*(x-0.5)^2);

chop(u) = u[1:n];  extend(v) = [v;0];
ode(v,c,t) = -c*chop(Dx*extend(v));

using DifferentialEquations
IVP = ODEProblem(ode,uinit[1:n],(0.,1.),-1)
sol = solve(IVP,RK4());

using Plots
plot(x[1:n],sol.t,sol[:,:]',
    xlabel="x",ylabel="t",title="Inflow boundary condition",leg=:none)

chop(u) = u[2:n+1];  extend(v) = [0;v];
sol = solve(IVP,RK4());
plot(x[1:n],sol.t,sol[:,:]',
    xlabel="x",ylabel="t",title="Outflow boundary condition",leg=:none)
