
include("../FNC.jl")
m = 200
x,Dx = FNC.diffmat2(m,[-1,1]);

chop(u) = u[2:m];
extend(v) = [0;v;0];

dwdt = function (w,c,t)
    u = extend(w[1:m-1])
    z = w[m:2*m]
    dudt = Dx*z
    dzdt = c^2*(Dx*u)
    return [ chop(dudt); dzdt ]
    end;

u_init = @.exp(-100*(x)^2)
z_init = -u_init
w_init = [ chop(u_init); z_init ];  

using DifferentialEquations
IVP = ODEProblem(dwdt,w_init,(0.,2.),2)
sol = solve(IVP,RK4());

n = length(sol.t)-1
U = [ zeros(1,n+1); sol[1:m-1,:]; zeros(1,n+1) ];
Z = sol[m:2*m,:];

using Plots
an = @animate for (i,t) = enumerate(sol.t) 
    plot(x,U[:,i],layout=(1,2),subplot=1,
        xaxis=("x"),yaxis=([-1,1],"u(x,t)"),    
        title="Wave equation, t=$(round(t,digits=3))",leg=:none )
    plot!(x,sol.t,U',subplot=2,xlabel="x",ylabel="t",title="Space-time view",leg=:none)
end
gif(an,"wave.gif")
