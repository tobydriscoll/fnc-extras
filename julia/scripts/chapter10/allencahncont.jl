
epsilon = 0.05;
phi = (x,u,dudx) -> (u^3 - u) / epsilon;

init = range(-1,stop=1,length=141)

include("../FNC.jl")
x,u1 = FNC.bvp(phi,[0,1],-1,[],1,[],init)

using Plots
plot(x,u1,label="\$\\epsilon = 0.05\$",
    xaxis=("x"),yaxis=("u(x)"),title="Allen-Cahn solution")

epsilon = 0.005;
x,u = FNC.bvp(phi,[0,1],-1,[],1,[],init);

x,u2 = FNC.bvp(phi,[0,1],-1,[],1,[],u1)
plot!(x,u2,label="\$\\epsilon = 0.005\$")

epsilon = 0.0005
x,u3 = FNC.bvp(phi,[0,1],-1,[],1,[],u2)
plot!(x,u3,label="\$\\epsilon = 0.0005\$")
