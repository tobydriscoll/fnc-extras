
f = (u,t) -> sin((t+u)^2);
tspan = (0.0,4.0);
u0 = -1.0;

using DifferentialEquations
ivp = ODEProblem((u,p,t)->f(u,t),u0,tspan)
sol = solve(ivp);

using Plots
plot(sol,label="",ylabel="u(t)",title="Solution of u'=sin((t+u)^2)")
