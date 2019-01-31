
f = (u,t) -> sin((t+u)^2);
tspan = (0.0,4.0);
u0 = -1.0;

include("../FNC.jl")
t,u = FNC.eulerivp(f,tspan,u0,20);

using Plots
plot(t,u,m=:o,label="n=20",
    xlabel="t", ylabel="u(t)", title="Solution by Euler's method" )

t,u = FNC.eulerivp(f,tspan,u0,200)
plot!(t,u,label="n=200")

using DifferentialEquations
ivp = ODEProblem((u,p,t)->f(u,t),u0,tspan)
u_exact = solve(ivp,reltol=1e-14,abstol=1e-14);

plot!(u_exact,l=:dash,label="accurate")

n = @. 50*2^(0:5)
err = zeros(size(n))
for (j,n) = enumerate(n)
    t,u = FNC.eulerivp(f,tspan,u0,n)
    err[j] = maximum( @. abs(u_exact(t)-u) )
end

using DataFrames
DataFrame(n=n,error=err)

plot(n,err,m=:o,label="results", 
    xaxis=(:log10,"n"), yaxis=(:log10,"inf-norm error"), title="Convergence of Euler's method")
plot!(n,0.05*(n/n[1]).^(-1),l=:dash,label="1st order")
