
u(x,y) = sin(x*y-y);
dudx(x,y) = y*cos(x*y-y);
dudy(x,y) = (x-1)*cos(x*y-y);

include("../FNC.jl")
m = 80;  x,Dx = FNC.diffmat2(m,[0,2*pi]);
n = 60;  y,Dy = FNC.diffmat2(n,[1,3]);
X,Y = FNC.ndgrid(x,y)
U = u.(X,Y);

plot(X,Y,dudx.(X,Y),match_dimensions=true,levels=10,
    title="du/dx") 

using Plots

contourf(x,y,dudx.(X,Y),match_dimensions=true,levels=10,layout=(1,2),subplot=1,
    title="du/dx")      
contourf!(x,y,Dx*U,levels=10,match_dimensions=true,layout=(1,2),subplot=2,
    title="approximation")      

contourf(x,y,dudy.(X,Y),match_dimensions=true,levels=10,layout=(1,2),subplot=1,
    title="du/dy")      
contourf!(x,y,U*Dy',levels=10,match_dimensions=true,layout=(1,2),subplot=2,
    title="approximation")
