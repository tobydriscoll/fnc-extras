
t = [ 1, 1.5, 2, 2.25, 2.75, 3 ]
n = 5;  k = 2;

phi = x -> prod(x-t[i+1] for i=[0:k-1;k+1:n])
ell_k = x -> phi(x) / phi(t[k+1])

using Plots
plot(ell_k,1,3)
scatter!(t,[zeros(k);1;zeros(n-k)],color=:black,
    xaxis=("\$x\$"), yaxis=("\$\\ell_2(x)\$"),
    title="Lagrange cardinal function",legend=:none)
