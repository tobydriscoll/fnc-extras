
phi = (t,theta,omega) -> -0.05*omega - sin(theta)
init = range(2.5,stop=-2,length=101)

include("../FNC.jl")
t,theta = FNC.bvp(phi,[0,5],2.5,[],-2,[],init)

using Plots
plot(t,theta,xaxis=("t"),yaxis=("\$\\theta(t)\$"),
    title="Pendulum over [0,5]",leg=:none)

t,theta = FNC.bvp(phi,[0,8],2.5,[],-2,[],init);
plot(t,theta,xaxis=("t"),yaxis=("\$\\theta(t)\$"),
    title="Pendulum over [0,8]",leg=:none)
