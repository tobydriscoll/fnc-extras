
include("../FNC.jl")
m = 60;  n = 60;
X,Y,d = FNC.rectdisc(m,[-2,2],n,[-2,2]);
x = X[:,1]; y = Y[1,:];  # for plotting

U0 = @. (X+0.2)*exp(-12*(X^2+Y^2))
V0 = zeros(size(U0))

using Plots
surface(x,y,U0,     
    title="Initial condition",    
    xaxis=("x"),yaxis=("y") ) 

unpack = function (w)
    numU = (m-1)*(n-1)   # number of unknowns for U
    U = copy(U0)               
    U[@. !d.isbndy] = w[1:numU]  # overwrite the interior
    V = d.unvec( w[numU+1:end] )     # use all values
    return U,V
end

pack = function (U,V)
    w = U[@. !d.isbndy]
    return [ w; V[:] ]
end

dwdt = function (w,tmp,t)
    U,V = unpack(w) 
    dUdt = V
    dWdt = d.Dxx*U + U*d.Dyy'
    return pack(dUdt,dWdt)
end

using DifferentialEquations
IVP = ODEProblem(dwdt,pack(U0,V0),(0,3.0))
sol = solve(IVP,alg_hints=[:nonstiff]);

an = @animate for t = range(0,stop=3,length=80)
    surface(x,y,unpack(sol(t)),match_dimensions=true,color=:redsblues,clims=(-0.1,0.1),
        title="Wave equation solution at t=$(round(t,digits=2))")
end
gif(an,"wave2D.gif")
