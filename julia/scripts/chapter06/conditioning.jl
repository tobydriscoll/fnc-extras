
using Plots

u = [ t->exp(t)*u0 for u0 in [0.7,1,1.3] ]
plot(u,0,3,leg=:none,xlabel="t",ylabel="u(t)", title="Exponential divergence of solutions")

u = [ t->exp(-t)*u0 for u0 in [0.7,1,1.3] ]
plot(u,0,3,leg=:none,xlabel="t",ylabel="u(t)", title="Exponential convergence of solutions")
