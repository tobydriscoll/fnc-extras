
f = (u,t) -> (t+u)^2

using DifferentialEquations
sol = solve( ODEProblem((u,p,t)->f(u,t),1.,(0.,1.)) );

using Plots
plot(sol,label="",yscale=:log10)
