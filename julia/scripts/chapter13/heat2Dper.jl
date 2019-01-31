
include("../FNC.jl")
m = 60;  x,Dx,Dxx = FNC.diffper(m,[-1,1]);
n = 40;  y,Dy,Dyy = FNC.diffper(n,[-1,1]);
X,Y = FNC.ndgrid(x,y);

U0 = @. sin(4*pi*X)*exp(cos(pi*Y))

using Plots
contourf(x,y,U0,match_dimensions=true,color=:redsblues,aspect_ratio=1,
    xaxis=("x"),yaxis=("y"),title="Initial condition")    

unpack(u) = reshape(u,m,n);
pack(U) = U[:];

dudt = function (u,nu,t)
    U = unpack(u);
    Uxx = Dxx*U;  Uyy = U*Dyy';     # 2nd partials
    dUdt = nu*(Uxx + Uyy);  # PDE
    return pack(dUdt);
end

using DifferentialEquations
IVP = ODEProblem(dudt,pack(U0),(0,0.2),0.1)
sol = solve(IVP,Rodas4P());

an = @animate for t = range(0,stop=0.2,length=81)
    surface(x,y,unpack(sol(t)),match_dimensions=true,color=:redsblues,clims=(-2,2),
        xaxis=("x"),yaxis=("y"),title="Heat equation, t=$(round(t,digits=3))")
end 
gif(an,"heat2Dper.gif")
