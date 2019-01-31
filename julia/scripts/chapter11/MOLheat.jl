
include("../FNC.jl")
using LinearAlgebra

m = 100
x,Dx,Dxx = FNC.diffper(m,[0,1])
u0 = @. exp( -60*(x-0.5)^2 );

tfinal = 0.05
using DifferentialEquations
ODE = (u,p,t) -> Dxx*u;  
IVP = ODEProblem(ODE,u0,(0,tfinal))

u = solve(IVP,DP5())  # select DP5 solver

using Plots
plot(x,u[:,1:50:end],label=["t=$t" for t in round.(u.t[1:50:end],digits=4)], 
    xaxis=("x"), yaxis=("u(x,t)"),
    title="Heat equation by ode45")

num_steps_1 = length(u.t)-1

u = solve(IVP,Rodas4P());

num_steps_2 = length(u.t)-1
