
m = 4;   x = 0:2*pi/m:2*pi;
n = 2;   y = 1:2/n:3;

include("../FNC.jl")
X,Y = FNC.ndgrid(x,y);
X

Y

using Plots
scatter(X,Y,m=:blue,xtick=x,ytick=y,leg=:none)

f(x,y) = sin(x*y-y);
F = f.(X,Y)

m = 70;   x = 0:2*pi/m:2*pi;
n = 50;   y = 1:2/n:3;
X,Y = FNC.ndgrid(x,y);
F = f.(X,Y);

plot(x,y,F,levels=10,xlabel="x",ylabel="y",fill=true,match_dimensions=true)

surface(x,y,F,xlabel="x",ylabel="y",zlabel="f(x,y)",match_dimensions=true,leg=:false)   
