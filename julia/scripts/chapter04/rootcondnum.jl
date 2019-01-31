
f  = x -> (x-1)*(x-2);

interval = [0.8,1.2]

using Plots
plot(f,interval...,label="function",aspect_ratio=1,
    xlabel="x",yaxis=("f(x)",[-0.2,0.2]),title="Well-conditioned root")
plot!([x->f(x)+0.02,x->f(x)-0.02],interval...,label="perturbation",color=:black)

f  = x -> (x-1)*(x-1.01);

using Plots
plot(f,interval...,label="",aspect_ratio=1,
    xlabel="x",yaxis=("f(x)",[-0.2,0.2]),title="Poorly conditioned root",leg=:top)
plot!([x->f(x)+0.02,x->f(x)-0.02],interval...,label="",color=:black)
