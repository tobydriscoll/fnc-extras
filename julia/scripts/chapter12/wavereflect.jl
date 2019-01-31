
include("../FNC.jl")
m = 120
x,Dx = FNC.diffcheb(m,[-1,1]);
c = @. 1 + (sign(x)+1)/2
chop(u) = u[2:m];
extend(v) = [0;v;0];

dwdt = function (w,c,t)
    u = extend(w[1:m-1])
    z = w[m:2*m]
    dudt = Dx*z
    dzdt = c.^2 .* (Dx*u)
    return [ chop(dudt); dzdt ]
    end;

u_init = @.exp(-100*(x+0.5)^2);
z_init = -u_init;
w_init = [ chop(u_init); z_init ];    
using DifferentialEquations
IVP = ODEProblem(dwdt,w_init,(0.,2.),c)
sol = solve(IVP,RK4());

using Plots
an = @animate for t = 2*(0:100)/100 
    plot(x,extend(sol(t,idxs=1:m-1)),
        xaxis=("x"),yaxis=([-1,1],"u(x,t)"),    
        title="Wave equation, variable speed",label="t=$(round(t,digits=3))" )
end
gif(an,"wavereflect.gif")
