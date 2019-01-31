
rho_c = 1080;  rho_m = 380;  q_m = 10000;
Q0prime(rho) = q_m*4*rho_c^2*(rho_c-rho_m)*rho_m*(rho_m-rho)/(rho*(rho_c-2*rho_m) + rho_c*rho_m)^3;

include("../FNC.jl")
x,Dx,Dxx = FNC.diffper(800,[0,4]);

ode = (rho,ep,t) -> -Q0prime.(rho).*(Dx*rho) + ep*(Dxx*rho);

rho_init = @. 400 + 10*exp(-20*(x-3)^2)
using DifferentialEquations
IVP = ODEProblem(ode,rho_init,(0.,1.),0.02)
sol = solve(IVP);

using Plots
plot(x,[sol(t) for t=0:.2:1],label=["t=$t" for t=0:.2:1],
    xaxis=("x"),yaxis=("car density"),title="Traffic flow")     

an = @animate for t = range(0,stop=1,length=80) 
    plot(x,sol(t),
        xaxis=("x"),yaxis=([400,410],"density"),    
        title="Traffic flow, t=$(round(t,digits=2))",leg=:none )
end
gif(an,"traffic1.gif")

rho_init = @. 400 + 80*exp(-16*(x-3)^2)
IVP = ODEProblem(ode,rho_init,(0.,0.5),0.02)
sol = solve(IVP);

an = @animate for t = range(0,stop=0.5,length=80) 
    plot(x,sol(t),
        xaxis=("x"),yaxis=([400,480],"density"),    
        title="A traffic jam",leg=:none )
end
gif(an,"traffic2.gif")
