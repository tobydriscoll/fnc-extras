
lambda = 0.6
phi = (r,w,dwdr) -> lambda/w^2 - dwdr/r;

a = eps();  b = 1;

f = (v,p,r) -> [ v[2]; phi(r,v[1],v[2]) ];

using DifferentialEquations, Plots

for w0 = 0.4:0.1:0.9
    IVP = ODEProblem(f,[w0,0],(a,b))
    sol = solve(IVP)
    plot!(sol,vars=[1],label="w0 = $w0")
end
plot!([],[],label="",
    xaxis=("x"), yaxis=("w(x)"),   
    title="Solutions for choices of w(0)",leg=:bottomright)
