
include("../FNC.jl") 
using SparseArrays
lambda = 1.5

pde = function (U,X,Y,d)
    LU = d.Dxx*U + U*d.Dyy';     # apply Laplacian
    F = @. LU - lambda/(U+1)^2   # residual

    L = kron(d.Dyy,d.Ix) + kron(d.Iy,d.Dxx)  
    u = d.vec(U)
    J = L + spdiagm( 0 => @. 2*lambda/(u+1)^3 ) 
    return F,J
end      

g(x,y) = 0     # boundary condition
U,X,Y = FNC.newtonpde(pde,g,100,[0,2.5],80,[0,1]);

using Plots
surface(X[:,1],Y[1,:],U',color=:blues,aspect_ratio=1,
    xlabel="x",ylabel="y",title="Deflection of a MEMS membrane")        
