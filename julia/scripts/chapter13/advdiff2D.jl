
include("../FNC.jl")
m = 50;  n = 50;
X,Y,d = FNC.rectdisc(m,[-1,1],n,[-1,1]);

U0 = @. (1-X^4)*(1-Y^4);

using Plots
plot(X[:,1],Y[1,:],U0,match_dimensions=true,aspect_ratio=1,title="Initial condition")

unpack = function (w)
    U = copy(U0)          # get the boundary right
    U[@. !d.isbndy] .= w  # overwrite the interior
    return U
end

pack(U) = U[@. !d.isbndy];

dwdt = function (w,nu,t)
    U = unpack(w)
    Uxx = d.Dxx*U;  Uyy = U*d.Dyy';   # 2nd partials
    dUdt = 1 .- d.Dx*U + nu*(Uxx + Uyy);  # PDE
    return pack(dUdt)
end

using DifferentialEquations
IVP = ODEProblem(dwdt,pack(U0),(0.0,1.0),0.05)
sol = solve(IVP,alg_hints=[:stiff]);

plot(X[:,1],Y[1,:],unpack(sol(0.5)),match_dimensions=true,aspect_ratio=1,
    title="Solution at t=0.5")


plot(X[:,1],Y[1,:],unpack(sol(1)),match_dimensions=true,aspect_ratio=1,
    title="Solution at t=1")

an = @animate for t in range(0,stop=1,length=80)
    surface(X[:,1],Y[1,:],unpack(sol(t)),match_dimensions=true,aspect_ratio=1,color=:blues,clims=(0,2),
        title="Advection-diffusion solution at t=$(round(t,digits=2))")
end
gif(an,"advdiff2D.gif")
