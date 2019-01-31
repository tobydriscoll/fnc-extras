
r = (0:40)/40
theta = 2pi*(0:80)/80

include("../FNC.jl")
R,Theta = FNC.ndgrid(r,theta);
F = @. 1-R^4;

using Plots
surface(r,theta,F,match_dimensions=true,
    xlabel="r",ylabel="\\theta",title="A polar function",leg=:none)

plotlyjs()
X = @. R*cos(Theta);  Y = @. R*sin(Theta);
surface(X,Y,F,leg=:none)

theta = 2pi*(0:60)/60
phi = pi*(0:60)/60
Theta,Phi = FNC.ndgrid(theta,phi);
X = @.cos(Theta)*sin(Phi)
Y = @.sin(Theta)*sin(Phi) 
Z = cos.(Phi)

F = @. X*Y*Z^3
surface(X,Y,Z,fill_z=F,title="Function on the unit sphere")
