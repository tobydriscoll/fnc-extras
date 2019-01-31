
f = function (u,p,t)
    q,s,w = p
    [ s*(u[2]-u[1]*u[2]+u[1]-q*u[1]^2);
    (-u[2]-u[1]*u[2]+u[3])/s; 
    w*(u[1]-u[3]) ]
end

using DifferentialEquations
IVP = ODEProblem(f,[1.,1.,4.],(0.,6.),(8.375e-6,77.27,0.161))
@elapsed u = solve(IVP,Rodas4P())  # select Rodas4P solver

using Plots
plot(u)
scatter!(u.t,u[:,:]',m=2,xaxis=("t"),yaxis=("u(t)"),
    title="Oregonator",leg=:none)

@show num_steps_stiff = length(u.t); 

@elapsed u = solve(IVP,DP5())  # select DP5 solver

@show num_steps_nonstiff = length(u.t);

q,s,w = (8.375e-6,77.27,0.161)
J = u -> [ -s*(u[2]+1-2*q*u[1]) s*(1-u[1]) 0; 
    -u[2]/s (-1-u[1])/s 1/s; 
    w 0 -w];

t = u.t
i1 = findfirst(@.t>0.5) 
using LinearAlgebra
lambda1 = eigvals( J(u[:,i1]) )

maxstep1 = 2.8 / maximum(abs.(lambda1))

step1 = t[i1+1] - t[i1]

i2 = findfirst(@.t>4)   
lambda2 = eigvals( J(u[:,i2]) )

@show maxstep2 = 2.8 / maximum(abs.(lambda2));
@show step2 = t[i2+1] - t[i2];
