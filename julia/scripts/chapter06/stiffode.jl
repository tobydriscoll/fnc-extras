
f = (u,t) -> u^2 - u^3;
u0 = 0.005;

include("../FNC.jl")
tI,uI = FNC.am2(f,[0.,400.],u0,200);

using Plots
plot(tI,uI,label="AM2",
    xlabel="t",ylabel="y(t)",leg=:bottomright)

tE,uE = FNC.ab4(f,[0.,400.],u0,200);
scatter!(tE,uE,m=3,label="AB4",ylim=[-4,2])

uE[105:111]

scatter(tI,uI,label="AM2",m=(:o,3),
    xlabel="t",ylabel="y(t)",leg=:bottomright)

for n = [1000,1600]
    tE,uE = FNC.ab4(f,[0 400],u0,n);
    plot!(tE,uE,label="AM4, n=$n")
end
plot!([],[],label="")
