
using SparseArrays
 
pde = function pde(U,X,Y,d)
    LU = d.Dxx*U + U*d.Dyy'      # apply Laplacian
    Ux = d.Dx*U
    F = @. 1 - Ux + 0.05*LU      # residual

    L = kron(d.Dyy,d.Ix) + kron(d.Iy,d.Dxx)
    u = d.vec(U)
    J = -kron(d.Iy,d.Dx) + 0.05*L  # Jacobian
    return F,J
end

g(x,y) = 0;    # boundary condition

include("../FNC.jl")
U,X,Y = FNC.newtonpde(pde,g,100,[-1,1],100,[-1,1]);

using Plots
surface(X[:,1],Y[1,:],U',xlabel="x",ylabel="y",
    title="Steady Advection-diffusion")
