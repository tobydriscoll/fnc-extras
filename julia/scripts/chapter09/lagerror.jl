
 t = [ 1, 1.6, 1.9, 2.7, 3 ];

Phi = x -> prod(x-ti for ti=t)

using Plots
plot(x->Phi(x)/5,1,3)
scatter!(t,zeros(size(t)),color=:black,
    xaxis=("\$x\$"), yaxis=("\$\\Phi(x)\$"),
    title="Interpolation error function",legend=:none)
