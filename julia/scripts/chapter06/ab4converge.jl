
f = (u,t) -> sin((t+u)^2);
tspan = (0.0,4.0);
u0 = -1.0;

using DifferentialEquations
ivp = ODEProblem((u,p,t)->f(u,t),u0,tspan)
u_exact = solve(ivp,reltol=1e-14,abstol=1e-14);

include("../FNC.jl")
n = @. 10*2^(0:5)
err = zeros(size(n))
for (j,n) = enumerate(n)
    t,u = FNC.ab4(f,tspan,u0,n)
    err[j] = maximum( @.abs(u_exact(t)-u) )
end

using Plots
plot(n,err,m=:o,label="AB4",
    xaxis=(:log10,"n"),yaxis=(:log10,"inf-norm error"),
    title="Convergence of AB4",leg=:bottomleft)
plot!(n,0.1*(n/n[1]).^(-4),l=:dash,label="4th order")
