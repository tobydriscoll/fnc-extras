
using SparseArrays

pde = function pde(U,X,Y,d)
    LU = d.Dxx*U + U*d.Dyy'     # apply Laplacian
    F = @. U*(1-U^2) + 0.05*LU  # residual

    L = kron(d.Dyy,d.Ix) + kron(d.Iy,d.Dxx)
    u = d.vec(U)
    J = spdiagm(0 => @. 1-3*u^2)  + 0.05*L  # Jacobian
    return F,J
end

g(x,y) = tanh(5*(x+2*y-1));    # boundary condition

include("../FNC.jl")

U,X,Y = FNC.newtonpde(pde,g,100,[0,1],100,[0,1]);

using Plots
surface(X[:,1],Y[1,:],U',camera=(32,30),xlabel="x",ylabel="y",
    title="Steady Allen-Cahn")
