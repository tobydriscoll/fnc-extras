
f = (u,t) -> exp(t-u*sin(u))

include("../FNC.jl")
t,u = FNC.rk23(f,[0.,5.],0.0,1e-5)

using Plots
scatter(t,u,m=(:o,2),label="",
    xlabel="t",ylabel="u(t)",title="Adaptive IVP solution")

plot(t[1:end-1],diff(t),label="",
    xaxis=("t"),yaxis=(:log10,"step size"),title=("Adaptive step sizes"))

h_min = minimum(diff(t))

h_avg = sum(diff(t))/(length(t)-1)
