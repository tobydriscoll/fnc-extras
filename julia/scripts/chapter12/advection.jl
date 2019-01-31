
include("../FNC.jl")
x,Dx,Dxx = FNC.diffper(300,[-4,4])
f = (u,c,t) -> -c*(Dx*u);

u_init = @. 1 + exp(-3*x^2)

using DifferentialEquations
IVP = ODEProblem(f,u_init,(0.,3.),2.)
sol = solve(IVP,RK4());

using Plots
an = @animate for t = range(0,stop=3,length=120) 
    plot(x,sol(t),
        xaxis=("x"),yaxis=([1,2],"u(x,t)"),    
        title="Advection equation, t=$(round(t,digits=2))",leg=:none )
end
gif(an,"advection.gif")
