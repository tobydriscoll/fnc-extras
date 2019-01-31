
f = (u,t) -> (t+u)^2;

include("../FNC.jl")
t,u = FNC.rk23(f,[0,1],1.0,1e-5);

using Plots
plot(t,u,label="",
    xlabel="t",yaxis=(:log10,"u(t)"),title="Finite-time blowup")
