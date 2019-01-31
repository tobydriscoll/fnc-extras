
using JLD
vars = load("voting.jld")
A = vars["A"]
m,n = size(A)

using Plots
heatmap(A,color=:viridis,
    title="Votes in 111th U.S. Senate",xlabel="bill",ylabel="senator")

using LinearAlgebra
U,sigma,V = svd(A)
tau = cumsum(sigma.^2) / sum(sigma.^2)

scatter(tau[1:16],m=3,label="",
    xaxis=("k"), yaxis=("\$\\tau_k\$"), title="Fraction of singular value energy")

scatter( U[:,1], m=2,label="",layout=(1,2),
    xlabel="senator" ,title="left singular vector")
scatter!( V[:,1], m=2,label="",subplot=2,
    xlabel="bill",title="right singular vector")

x1 = A*V[:,1];   x2 = A*V[:,2];

Rep = vec(vars["Rep"]); Dem = vec(vars["Dem"]);  Ind = vec(vars["Ind"]);
scatter(x1[Dem],x2[Dem],color=:blue,label="D",
    xaxis=("partisanship"),yaxis=("bipartisanship"),title="111th US Senate in 2D" )
scatter!(x1[Rep],x2[Rep],color=:red,label="R")
scatter!(x1[Ind],x2[Ind],color=:yellow,label="I")
