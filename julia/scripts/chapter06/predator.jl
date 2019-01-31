
function predprey(u,p,t)
    alpha,beta = p;  y,z = u;  # rename for convenience
    s = (y*z) / (1+beta*y)     # appears in both equations
    return [ y*(1-alpha*y) - s,  -z + s ]
end

u0 = [1,0.01]
tspan = (0.,80.)
alpha = 0.1;  beta = 0.25;

using DifferentialEquations
sol = solve( ODEProblem(predprey,u0,tspan,[alpha,beta]) );

using Plots
plot(sol,label=["prey" "predator"],title="Predator-prey solution")

@show size(sol.u);
@show (sol.t[20],sol.u[20]);

u = [ sol.u[i][j] for i=1:length(sol.t), j=1:2 ]
plot!(sol.t,u,m=(:0,3),label="")

plot(sol,vars=(1,2),label="",
    xlabel="y",ylabel="z",title="Predator-prey phase plane")
