
include("../FNC.jl")
using Plots

lambda = (6:4:18)
for lam in lambda
    lval = -1.0;  rval = 0.0;
    phi = (x,u,dudx) -> lam^2*u + lam^2
    x,u = FNC.shoot(phi,(0.0,1.0),lval,[],rval,[],0.0)
    plot!(x,u,m=:o,label="\$\\lambda=$lam\$")
end
plot!([],[],label="",
    xaxis=("x"),yaxis=([-2,0.5],"u(x)"),title="Shooting instability",leg=:topleft)
