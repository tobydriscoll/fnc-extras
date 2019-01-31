
f(x,y) = -sin(3*x.*y-4*y)*(9*y^2+(3*x-4)^2);
g(x,y) = sin(3*x*y-4*y);
xspan = [0,1];  yspan = [0,2];

include("../FNC.jl")
U,X,Y = FNC.poissonfd(f,g,50,xspan,80,yspan);

x = X[:,1];  y = Y[1,:];
using Plots
surface(x,y,U,match_dimensions=true,color=:bluesreds,
    title="Solution of Poisson equation",      
    xaxis=("x"), yaxis=("y"), zaxis=("u(x,y)"))    

?gui

error = g.(X,Y) - U;
M = max( maximum(error),-minimum(error) )   
contourf(x,y,error,levels=17,match_dimensions=true,aspect_ratio=1,clims=(-M,M),color=:bluesreds,
    title="Error",xaxis=("x"),yaxis=("y") )
