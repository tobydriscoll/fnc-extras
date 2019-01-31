
f = (u,t) -> sin((t+u)^2);
tspan = (0.0,4.0);
u0 = -1.0;

using DifferentialEquations
ivp = ODEProblem((u,p,t)->f(u,t),u0,tspan)
sol = solve(ivp);

@show sol(1.0);
@show sol.(0:.25:4);

using Plots
plot(sol,label="u(t)")

sol

plot!(sol.t,sol.u,m=:o,l=nothing,label="discrete values")
