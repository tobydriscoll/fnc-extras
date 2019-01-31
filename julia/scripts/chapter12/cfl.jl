
include("../FNC.jl")
x,Dx = FNC.diffper(400,[0 1])
uinit = @. exp(-80*(x-0.5)^2);

ode = (u,c,t) -> -c*(Dx*u);
using DifferentialEquations
IVP = ODEProblem(ode,uinit,(0.,2.),2.)
sol = solve(IVP,RK4());

using Plots
t = 2*(0:80)/80
u = hcat([sol(t) for t in t]...)
contour(x,t,u',color=:viridis,
    xaxis=("x"),yaxis=("t"),title="Linear advection",leg=:none)

avgtau1 = sum(diff(sol.t))/(length(sol.t)-1)

x,Dx = FNC.diffper(800,[0 1])
uinit = @. exp(-80*(x-0.5)^2);
IVP = ODEProblem(ode,uinit,(0.,2.),2.)
sol = solve(IVP,RK4());

avgtau2 = sum(diff(sol.t))/(length(sol.t)-1)
@show ratio = avgtau1 / avgtau2
